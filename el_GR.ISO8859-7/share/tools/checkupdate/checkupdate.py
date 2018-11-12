#!/usr/bin/env python

#-
# Copyright (c) 2007 Giorgos Keramidas <keramida@FreeBSD.org>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $FreeBSD$

"""
The translation helper utility `checkupdate'.

To use this utility, you have to check out a clean copy of the doc/ tree
of FreeBSD which includes at least the following subdirectories:

    el_GR.ISO8859-7
    en_US.ISO8859-1
    share

Then you can feed a list of files (flist) from the `el_GR.ISO8859-7'
part of the tree to the standard input of this script, and it will try
to print a report of updates which may be useful to merge from `en_US'
to `el_GR'.

NOTE: The `checkupdate' script depends on manually maintained `%SOURCE%'
and `%SRCID%' comments in the `el_GR' part of the tree, to work
correctly.  It does not maintain the comments/tags itself, though.

NOTE: If you use relative pathnames, make sure they are relative to the
root of the doc/ tree, and that you run the script from the toplevel
directory or that you correctly pass the -R option with the doc/
workspace path.
"""

import errno
import getopt
import os
import re
import sys
import subprocess

# Alias some functions from other modules, to shorter, easier to use names.
exit = sys.exit

# Save the invocation name of the script, for later use.
progname = os.path.basename(sys.argv[0])

# -------------------- script options ----------------------------------

allchecks = None                # All the file check functions we support.
checks = None                   # No checks are done by default.
patchmode = False               # Show patches that need translation.
root = "."                      # The default workspace directory.
verbose = None                  # Run in `quiet' mode by default.
everything = False              # Report everything, i.e. all input files.
tuplemode = False               # Use the standard output mode
compactmode = False             # Generate compact stdout suitable for commit logs.
pickymode = True                # Skip files without '%SRCID%' and '%SOURCE%' (default).

# -------------------- useful functions --------------------------------

def message(msg=None):
    """Print an optional `msg' message string to our standard error
    stream.  Note that a newline is appended automatically to the
    message string, as if it was displayed with print(), and no
    exceptions are captured by message()."""
    if msg:
        s = "%s\n" % (msg)
        sys.stderr.write(s)
        sys.stderr.flush()
    return None

def error(code, msg=None):
    """Print `msg' as an optional error message string, and die with an
    error of `code'."""
    if msg:
        s = '%s: error: %s' % (progname, msg)
        message(s)
    exit(code)

def warning(msg=None):
    """Print `msg' as an optional warning string."""
    if msg:
        s = '%s: warning: %s' % (progname, msg)
        message(s)
    return None

def debug(level=1, msg=None):
    """Print an optional debugging message `msg', when the verbosity
    level `verbose' of the script exceeds or is equal to `level'
    (default=1)."""
    if verbose and verbose >= level and msg:
        message("# " + msg)

def setroot(path):
    """Change the `root' of the workspace we are going to use to `path'.
    The `path' directory must alredy exist, and be accessible to the
    user running the script."""

    global root             # Declare global scope for `root'
    if os.path.exists(path):
        root = path
        debug(1, "Workspace = `%s'" % root)
        return root
    else:
        return None

def freebsdrevision(fname):
    """Parse the `fname' file, looking for an instance of the FreeBSD
    CVS ID line, extract the revision number from the ID line, and
    return it as a string.  Multiple matches are ok, as long as their
    revision ID and dates match precisely each other.

    FreeBSD is progressively switching its repositories from CVS to
    Subversion.  This function tries to DTRT with both CVS and
    Subversion ID lines, so it may not be 100% right at all times.

    The old-style CVS ID lines look like this:

      $\FreeBSD: src/bin/rcp/rcp.c,v 1.46 2007/05/22 04:21:00 cperciva Exp $

    The new-style Subversion ID lines look like this:

      $\FreeBSD: head/bin/rcp/rcp.c 169848 2007-05-22 04:21:00Z cperciva $

    The freebsrevision() function first tries to match the CVS format for
    each line, and if that fails it tries the Subversion format.  If one
    of these formats matches, then it extracts the revision number and
    it returns it.  If none matches, then it just returns `None' to show
    that there is no matching ID line."""

    if not fname:
        return None

    # There isn't much we can do with a directory path.
    if os.path.isdir(fname):
        debug(2, "No FreeBSD ID line for directory `%s'" % fname)
        return None

    try:
        cvsre = re.compile(r'^.*\$\FreeBSD:\s+\S+,v\s+(\d+(?:\.\d+){1,})\s+(?:d{2}|\d{4})/\d{2}/\d{2}\s+\d{2}:\d{2}:\d{2}\s+\S+\s+Exp\s+\$.*$')
        svnre = re.compile(r'^.*\$\FreeBSD:\s+\S+\s+(\d+)\s+\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}Z\s+\S+\s+\$.*$')
    except Exception, inst:
        warning("invalid regular expression: %s" % inst)
        return (None, None)

    rev = None
    try:
        debug(3, "Finding FreeBSD revision number of file `%s'" % fname)
        for l in file(fname):
            m = cvsre.match(l) or svnre.match(l)
            if m:
                nrev = m.group(1)
                if rev and rev != nrev:
                    debug(3, "Multiple revision numbers (%s and %s) found in file `%s'" % (rev, nrev, fname))
                    return None
                rev = nrev
    except IOError, inst:
        if inst.errno == errno.ENOENT:
            debug(3, "%s: cannot open file for reading" % fname)
            return None
    except Exception, inst:
        debug(3, "%s: cannot extract revision number: %s" % (fname, str(inst)))
        return None
    if not rev:
        debug(3, "FreeBSD revision not found in file `%s'" % fname)
    return rev

def fileinfo(fname):
    """Extract the `%%SOURCE%%' and `%%SRCID%%' info from file `fname'.
    The `fname' file should be accessible for reading.  It will be
    opened for read and every line will be matched with the `%%SOURCE%%'
    and `%%SRCID%%' patterns.  There should be only one occurence of
    these patterns in the file.  Multiple matches will trigger an error."""

    if not fname:
        return None

    # There isn't much we can do with a directory path.
    if os.path.isdir(fname):
        debug(2, "Skipping directory `%s'" % fname)
        return (None, None)

    # The regexps to match %SOURCE% and %SRCID% in our input file.
    try:
        srcre = re.compile(r'^.*(%SOURCE%)\s+(\S+)\s*$')
        srcidre = re.compile(r'^.*(%SRCID%)\s+(\S+)\s*$')
    except Exception, inst:
        warning("invalid regular expression: %s" % inst)
        return (None, None)

    # No file info obtained yet.
    info = (None, None, None, None, None, None)
    src, srcid = (None, None)
    try:
        debug(3, "Finding %%SOURCE%% and %%SRCID%% info of file `%s'" % fname)

        for l in file(fname):
            l = l.rstrip('\r\n')
            nsrc = None
            m = srcre.match(l)
            if m:
                nsrc = m.group(2)
            # Validate the `%SOURCE%' path, to avoid false matches with
            # `%SOURCE%' tags in comments or documentation.  This isn't
            # exactly a perfect validation check, but it should catch most
            # of the common cases.
            if nsrc and ('/' in nsrc or os.path.exists(nsrc)):
                if src:
                    warning("multiple %%SOURCE%% tags in file %s" % fname)
                src = nsrc
                debug(4, "%%SOURCE%% matched %s in line: %s" % (fname, l))
            # Check for an `%SRCID%' match.
            #
            # XXX: This doesn't really validate the resulting `%SRCID%' value
            # XXX: as a CVS or Subversion revision.  We should probably add
            # XXX: a few checks here.
            nsrcid = None
            m = srcidre.match(l)
            if m:
                nsrcid = m.group(2)
                if srcid:
                    warning("multiple %%SRCID%% tags in file %s" % fname)
                srcid = nsrcid
                debug(4, "%%SRCID%% matched %s in line: %s" % (fname, l))
    except IOError, inst:
        if inst.errno == errno.ENOENT:
            warning("%s: cannot open file for reading" % fname)
            return info
    except Exception, inst:
        warning("%s: cannot extract SOURCE and SRCID info" % fname)
        return info
    if not src:
        debug(3, "%%SOURCE%% not found in file `%s'" % fname)
    if not srcid:
        debug(3, "%%SRCID%% not found in file `%s'" % fname)

    fid, newsrcid = map(freebsdrevision, (fname, src))
    srcexists = src and os.path.exists(src)
    info = (fname, fid, src, srcexists, srcid, newsrcid)
    return info

def reportfile(fname, frev, srcfile, srcexists, srcid, srcrev):
    """Report that an update is needed for a translated file."""

    if not compactmode:
        text = "%s%s" % (fname, frev and " rev. " + str(frev) or "")
    revtext = "%-10s -> %-10s" % (srcid or "NO-%SRCID%", srcrev or "NONE")
    if not compactmode:
        if srcfile and not srcexists:
            filetext = "%s (MISSING)" % srcfile
        elif srcfile:
            filetext = "%s" % srcfile
        else:
            filetext = "NO-%SOURCE%"

    if compactmode:
        print "%s %s" % (revtext, fname)
    else:
        print "%s" % text
        print "    %s  %s" % (revtext, filetext)
        print ""

def showdiff(fname, frev, srcfile, srcexists, srcid, srcrev):
    """Show differences in the original file."""

    if not (srcfile and srcexists and srcid and srcrev):
        # Raise an exception?
        print "    No patch could be retrieved."
        print ""
        return None

    cvsdiff = ["cvs", "-R", "diff", "-u",
               "-r%s" % srcid, "-r%s" % srcrev, "%s" % srcfile]

    svndiff = ["svn", "diff",
               "-r", "%s:%s" % (srcid, srcrev), "%s" % srcfile]

    diffargs = None
    if os.path.isdir(root + "/CVS"):
        diffargs = cvsdiff
    elif os.path.isdir(root + "/.svn"):
        diffargs = svndiff

    if not diffargs:
        print "    Not a Subversion or CVS checkout."
        print ""
        return None

    diffcmd = ""

    for arg in diffargs:
        diffcmd += (arg + " ")

    print "    Patch review for:"
    print "    %s" % diffcmd
    print ""

    output = subprocess.Popen(diffargs, stdout=subprocess.PIPE, cwd=root).communicate()[0]

    print output
    print ""
    return True

def checkinfo(info):
    """Check the `info' tuple of file information.  The tuple should
    have at least six pieces of file information:

        (file-name, greek-revision,
         english-file, english-file-exists?,
         last-translated-revision, current-revision)

    These are all the bits we need for basic `update' checking."""

    fname = None                # Translated file path
    frev = None                 # Translated file revision
    srcfile = None              # English source file path
    srcexists = None            # Does the English source file exist?
    srcid = None                # `%SRCID%' value from translated file
    srcrev = None               # English file revision

    try:
        (fname, frev, srcfile, srcexists, srcid, srcrev) = \
            info
    except ValueError:
        warning("Invalid file info: %s" % str(info))
        return None

    if not fname:
        debug(2, "No translated file in info: %s" % str(info))
        return None

    # Report all files, if `everything' is enabled.
    if everything:
        reportfile(fname, frev, srcfile, srcexists, srcid, srcrev)
        return True

    # If a file has an fname and only one of srcfile but no srcid or
    # srcrev, then we report it because it seems 'odd' to have only a
    # `%SOURCE%' tag.
    if srcfile and (not srcid or not srcrev):
        reportfile(fname, frev, srcfile, srcexists, srcid, srcrev)
        return True

    # Similarly, if a file only has srcid, we report it.
    if srcid and (not srcfile or not srcrev):
        reportfile(fname, frev, srcfile, srcexists, srcid, srcrev)
        return True

    # The same if a file only has srcrev.
    if srcrev and (not srcfile or not srcid):
        reportfile(fname, frev, srcfile, srcexists, srcid, srcrev)
        return True

    # There is no frev, srcid, srcrev so do not report (has no sense).
    if (pickymode and not everything) and (not srcid and not srcrev and not frev):
        return None

    # There is no srcid, srcrev, may be the user does not want to track
    # this file.
    if (pickymode and not everything) and (not srcid and not srcrev):
        return None

    # If one of srcid, srcrev is unavailable, we report it.
    if not srcid or not srcrev:
        reportfile(fname, frev, srcfile, srcexists, srcid, srcrev)
        return True

    # Finally, if we have both srcrev, srcid, report only the files that
    # have different values for these two.
    if srcid != srcrev:
        reportfile(fname, frev, srcfile, srcexists, srcid, srcrev)
        if patchmode:
            return showdiff(fname, frev, srcfile, srcexists, srcid, srcrev)
        return True

    return None

def processfile(fname):
    """Process a single file, looking for updates and any other checks
    we have enabled for all the files."""

    if not fname:
        return None

    debug(2, "Processing file `%s'" % fname)
    if os.path.isdir(fname):
        # We don't do anything with directories.  Symlinks and other
        # files which stand a chance of being readable as plain text are
        # ok, but directories don't really make sense here, so skip them.
        debug(2, "Skipping directory `%s'" % fname)
        return None

    retval = None
    info = fileinfo(fname)
    if info:
        r = fname
        if tuplemode:
            print info
        else:
            checkinfo(info)
    return retval

def usage():
    """Print a usage message, and exit."""
    print "usage: %s [-acenpPqtv] [-R workspace]" % progname
    exit(1)

# -------------------- main script body --------------------------------

if __name__ == "__main__":
    debug(3, "Parsing script options")
    try:
        opts, args = getopt.getopt(sys.argv[1:], 'acenpPqtR:v')
    except getopt.GetoptError, err:
        usage()

    # Go through the list of command-line options, and tune the globals
    # which affect the behavior of the script accordingly.
    for o, v in opts:
        if o == '-a':
            debug(3, "Enabling all file checks")
            checks = allchecks  # All file checks enabled.
        elif o == '-c':
            debug(3, "Compact mode on")
            compactmode = True  # Generate compact report.
            patchmode = False   # No previews allowed.
        elif o == '-e':
            debug(3, "Reporting file revision info for everything")
            everything = True
        elif o == '-n':
            debug(3, "Disabling all file checks")
            checks = None       # No file checks enabled.
        elif o == '-p':
            if not compactmode:
                debug(3, "Enabling patch preview mode")
                patchmode = True# Show diffs for files to be merged.
            else:
                debug(3, "No patch preview due to compact mode")
        elif o == '-P':
            debug(3, "Disabling picky mode")
            pickymode = False   # Picky mode: no check if no revision.
        elif o == '-q':
            debug(3, "Going into quiet mode.")
            verbose = False     # Quiet mode; no verbose messages.
        elif o == '-R':
            debug(3, "Switching to workspace at `%s'" % v)
            if not setroot(v):
                error(1, "Directory `%s' does not exist" % v)
        elif o == '-t':
            debug(3, "Output formatted as tuples")
            tuplemode = True
        elif o == '-v':
            verbose = verbose and (verbose + 1) or 1
            debug(1, "Bumping verbosity level to %d" % verbose)
        else:
            assert False, "Unhandled option `%s'" % o

    # If the root directory is merely '.', convert it to a full pathname.
    if root == '.':
        try:
            root = os.getcwd()
        except Exception, inst:
            error(1, "Cannot save working directory: %s" % str(inst))
            exit(1)
    debug(2, "Normalized workspace root = `%s'" % root)

    # Save the current working directory.
    savedpath = None
    try:
        savedpath = os.getcwd()
    except Exception, inst:
        error(1, "Cannot save working directory: %s" % str(inst))
        exit(1)

    # Switch into the workspace `root'.
    try:
        os.chdir(root)
    except Exception, inst:
        error(1, "Cannot switch to workspace root `%s'" % str(inst))
        exit(1)
    debug(3, "Current working directory = `%s'" % os.getcwd())

    # Read a list of files from stdin, and process them.
    try:
        for l in sys.stdin.readlines():
            fname = l.rstrip('\r\n')
            processfile(fname)
    except KeyboardInterrupt:
        message("%s: Interrupted." % progname)
        exit(1)
    except Exception, inst:
        error(1, "%s" % str(inst))

    # Restore the working directory we had before processing files.
    if savedpath:
        try:
            os.chdir(savedpath)
        except Exception, inst:
            error(1, "Cannot restore working directory: %s" % str(inst))
            exit(1)

    # All done.
    exit(0)

<!-- $FreeBSD: www/en/ports/ports.inc,v 1.65 2003/02/22 22:00:07 brueffer Exp $ -->
<p>The FreeBSD Ports and Packages Collection offers a simple way for
users and administrators to install applications.  The ports
collection has been <a
href="growth/status.png">growing at a
tremendous rate</a>.
</p>

<p>The Ports Collection supports the latest release on the
FreeBSD-CURRENT and FreeBSD-STABLE branches.  Older releases are not
supported and may or may not work correctly with an up-to-date ports
collection.  Over time, changes to the ports collection may rely on
features that are not present in older releases.  Wherever convenient,
we try not to gratuitously break support for recent releases, but it
is sometimes unavoidable.  When this occurs, patches contributed by
the user community to maintain support for older releases will usually
be committed.
</p>

<p>Each ``port'' listed here
contains any patches necessary to make the original application source
code compile and run on FreeBSD.  Installing an application is as
simple as downloading the port, unpacking it and typing <tt>make</tt>
in the port directory.  For even greater convenience, you can simply
install the <a href="ftp://ftp.FreeBSD.org/pub/FreeBSD/branches/-current/ports.tar.gz">
entire ports hierarchy</a> at installation time (or use
<a href="../doc/en_US.ISO8859-1/books/handbook/synching.html#CVSUP">CVSup</a> to track it on
an ongoing basis) and have thousands of applications right at your
fingertips.

Each port's <tt>Makefile</tt> automatically fetches the
application source code, either from a local disk, CDROM or via ftp,
unpacks it on your system, applies the patches, and compiles.  If
all went well, a simple <tt>make install</tt> will install the
application and register it with the package system.</p>

<p>For most ports, a precompiled <tt>package</tt> also exists, saving
the user the work of having to compile anything at all.  Each port
contains a link to its corresponding package and you may either simply
download that file and then run the <strong>pkg_add</strong> command
on it or you can simply grab the link location and hand it straight
to <strong>pkg_add</strong> since it's capable of accepting FTP URLs as
well as filenames.</p>

<p>For more information about new, changed or removed ports/packages,
or if you wish to search for a specific application to see if it's
available as a port/package, please see the 
<a href="http://www.FreeBSD.org/cgi/ports.cgi">FreeBSD Ports Changes</a>
page.</p>

<FORM METHOD="GET" ACTION="http://www.FreeBSD.org/cgi/ports.cgi">
Search for:
<INPUT NAME="query" VALUE="">
<SELECT NAME="stype">
<OPTION VALUE="all">All</OPTION>
<OPTION VALUE="name">Package Name</OPTION>
<OPTION VALUE="text">Description</OPTION>
</SELECT>
<INPUT TYPE="submit" VALUE="Submit">
</FORM>


<p>For more information about using ports, see <a
href="../doc/en_US.ISO8859-1/books/handbook/ports.html">Installing Applications: Packages and Ports</a>, a
section of the <a href="../doc/en_US.ISO8859-1/books/handbook/index.html">FreeBSD Handbook</a>.  For
information about creating new ports, see the <a
href="../doc/en_US.ISO8859-1/books/porters-handbook/index.html">Porter's Handbook</a>.</p> 

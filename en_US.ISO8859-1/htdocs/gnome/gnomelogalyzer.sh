#!/bin/sh
#-
# Copyright (c) 2004-2005 FreeBSD GNOME Team <freebsd-gnome@FreeBSD.org>
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
# Heh. "Tort."
#
# $MCom: portstools/gnomelogalyzer.sh.in,v 1.12 2005/06/28 05:47:54 adamw Exp $
#   $FreeBSD$
#

# This script uses some simple yet effective heuristics to analyse
# the output of a port's build failure, and spit out what is most
# likely the problem and the solution. (Hint: the solution is invariably
# to run portupgrade -a, except for when it isn't.)

# You can set the environment variable VERBOSE to something non-null
# to see debugging messages.  They're probably not all that exciting.


help(){
	echo "Usage: `basename $0` [BUILDLOG]"
	echo
	echo "Where BUILDLOG is an optional log of stdout and stderr"
	echo "from a failed GNOME ports build. For example,"
	echo "\"make 2>&1 | tee /path/to/BUILDLOG\" (for sh/ksh/bash/zsh) or"
	echo "\"make |& tee /path/to/BUILDLOG\" (for csh/tcsh)."
	echo
	echo "You can also just run `basename $0` and it will take care"
	echo "of the buildlog-generating business."
}


debug(){
	if [ -n "${VERBOSE}" ]; then
		if [ "$1" = "-n" ]; then
			echo -n "$2"
		else
			echo "$1"
		fi
	fi
}


# Are we blue in the face yet?
soln_portupgrade(){
    	if echo "$1" | grep -q "^-f" ; then
		echo
		echo "To correct this problem, make sure that ports-mgmt/portupgrade is installed, and then run the command \"portupgrade $1\"." | fmt 75 79
	else
		if [ -n "$1" ]; then
			specific="either run \"portupgrade $1\", or "
		fi
		echo
		echo "To correct this problem, make sure that ports-mgmt/portupgrade is installed, and then ${specific}upgrade all out-of-date ports with the command \"portupgrade -a\"." | fmt 75 79
	fi
}


get_tmpdir()
{
	if [ -n "${MC_TMPDIR}" -a -d "${MC_TMPDIR}" ]; then
		tmpdir="${MC_TMPDIR}"
	elif [ -n "${TMPDIR}" -a -d "${TMPDIR}" ]; then
		tmpdir="${TMPDIR}"
	elif [ -d "/var/tmp" ]; then
		tmpdir="/var/tmp"
	elif [ -d "/tmp" ]; then
		tmpdir="/tmp"
	elif [ -d "/usr/tmp" ]; then
		tmpdir="/usr/tmp"
	else
		return 1
	fi

	echo ${tmpdir}

	return 0
}

get_tmpfile()
{
    template=$1
    tmpfile=""

    tmpfile="`get_tmpdir`/${template}.XXXXXX"

    tmpfile=`mktemp -q ${tmpfile}`

    echo ${tmpfile}

    return 0
}

###########
#
# main()

debug -n "gnomelogalyzer ($0), ver. "
debug `echo "$MCom: portstools/gnomelogalyzer.sh.in,v 1.12 2005/06/28 05:47:54 adamw Exp $" | cut -f3 -d' '`

echo; # for good measure.
# check to make sure that the build log has been specified
if [ ! -z "$1" ]; then
	if [ ! -f "$1" ]; then
		echo "Error: Please supply a valid build log."
		help
		exit 1
	fi
	buildlog="$1"
else
	if [ ! -f ./Makefile ]; then
		echo "Error: You must run `basename $0` from within the"
		echo "directory of the failed port, or you must supply a"
		echo "valid build log."
		help
		exit 1
	fi
	buildlog=`get_tmpfile logalyze`
	echo -n "Generating build log. Please wait... "
	if [ -n "${VERBOSE}" ]; then
		/bin/sh -c "/usr/bin/make 2>&1" | tee ${buildlog}
	else
		/bin/sh -c "/usr/bin/make 2>&1" >> ${buildlog}
	fi
	echo "done."
	echo ""
fi


######
#
# TEST: Invalid pkg-config version
#
# SOLUTION: portupgrade pkg-config

debug -n "Checking pkg-config version... "
if grep -q '\*\*\* Your version of pkg-config is too old.' ${buildlog} ; then
	echo "You have an outdated version of pkg-config installed."
	soln_portupgrade "pkg-config"
	exit
else
	debug "OK"
fi

#####
#
# TEST: Out-of-date libraries
#
# SOLUTION: portupgrade

debug -n "Checking for out-of-date libraries... "
if grep -qE 'error: Library requirements' ${buildlog} && grep -qE ' not met;' ${buildlog} ; then
	echo "One or more GNOME libraries are too out-of-date."
	soln_portupgrade
	exit
else
	debug "OK"
fi

#####
#
# TEST: b0rked intltool
#
# SOLUTION: portupgrade -f intltool

debug -n "Checking for incomplete intltool installation... "
if grep -q 'error: XML::Parser perl module is required for intltool' ${buildlog} ; then
	echo "Your installation of intltool is incomplete."
	soln_portupgrade "-f intltool"
	echo
	echo "If portupgrade does not work, and you recently updated Perl, you should reinstall all of your Perl modules.  The best way to do this is with the command: portupgrade -f p5-\*" | fmt 75 79
	exit
else
	debug "OK"
fi

#####
#
# TEST: Pango without libXft
#
# SOLUTION: portupgrade -f libXft && portupgrade -f pango

debug -n "Checking for a pango without libXft support... "
if grep -q 'error: Xft Pango backend is required for x11 target' ${buildlog} ; then
	echo "Your Pango installation lacks libXft support."
	soln_portupgrade "-f -N libXft && portupgrade -f pango"
	exit
else
	debug "OK"
fi

#####
#
# TEST: Libtool out-of-date
#
# SOLUTION: portupgrade libtool-1.5\*

debug -n "Checking for an out-of-date libtool15... "
if grep -q 'libtool15: link: `1000:0' ${buildlog} ; then
    echo "Your libtool15 is out-of-date."
    soln_portupgrade "libtool-1.5\*"
    exit
else
    debug "OK"
fi

#####
#
# TEST:FreeType2 out-of-date
#
# SOLUTION: portupgrade freetype2

debug -n "Checking for an out-of-date freetype2... "
if grep -q "struct FTC_ImageTypeRec_' has no member named" ${buildlog} || \
    grep -q '\#error "`ft2build.h' ${buildlog} ; then
    echo "Your freetype2 is out-of-date."
    soln_portupgrade "-f freetype2"
    exit
else
    debug "OK"
fi

#####
#
# Catch-all
#

debug "Giving up..."
echo "The cause of your build failure is not known to `basename $0`.  Before e-mailing the build log to the FreeBSD GNOME team at freebsd-gnome@FreeBSD.org, TRY EACH OF THE FOLLOWING:" | fmt 75 79
echo
echo "  * If you are generating your own logfile, make sure to generate it with"
echo "    something similar to:"
echo "	  \"make 2>&1 | tee /path/to/logfile\" (sh/bash/ksh/zsh) or"
echo "	  \"make |& tee /path/to/logfile\" (csh/tcsh)"
echo "	* Make sure you are downloading the complete Ports tree."
echo "	* Check /usr/ports/UPDATING for information pertinent to your build"
echo "	  failure"
echo "	* 99% of the commonly reported build failures can be solved by"
echo "	  running \"portupgrade -a\""
echo "	* Read the FAQs at https://www.FreeBSD.org/gnome/"
echo "	* Search the archives of freebsd-gnome@FreeBSD.org.  Archives can be"
echo "	  searched at https://www.freebsd.org/gnome/index.html#search"
echo
echo "If you have not performed each of the above suggestions, don't bother asking for help.  The chances are good that you'll simply be told to perform one of the aforementioned steps." | fmt 75 79

exit

# Here there be tacos.

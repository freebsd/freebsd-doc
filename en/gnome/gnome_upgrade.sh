#!/bin/sh
#
# ##################################################################
# ##################################################################
# ## If you want to upgrade your GNOME desktop from 2.4 to 2.6,   ##
# ## you're on the right track! Read our upgrade FAQ at           ##
# ## http://www.freebsd.org/gnome/docs/faq26.html for complete    ##
# ## instructions!                                                ##
# ##################################################################
# ##################################################################
#
#-
# Copyright (c) 2004 FreeBSD GNOME Team <freebsd-gnome@FreeBSD.org>
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
# $Id: gnome_upgrade.sh,v 1.4 2004-04-26 03:35:39 marcus Exp $
#

# This script will aid in doing major upgrades to the GNOME Desktop (e.g.
# an upgrade from 2.4 --> 2.6).

GNOME_UPGRADE_SH_VER=42;	# This should be nailed down before releasing

## BEGIN global variable declarations.
VERBOSE=${VERBOSE:=0}
PORTSDIR=${PORTSDIR:=/usr/ports}
LOCALBASE=${LOCALBASE:=/usr/local}
X11BASE=${X11BASE:=/usr/X11R6}

PROJECT_URL="http://www.FreeBSD.org/gnome/"
SUPPORT_EMAIL="freebsd-gnome@FreeBSD.org"

SUPPORTED_FREEBSD_VERSIONS="4.9 4.10 5.2 5.2.1"
	# Ports that must be up-to-date and installed for the Big Update to work
EXTERNAL_DEPENDS="popt gettext* libiconv expat pkgconfig freetype2 XFree86-libraries* Xft libXft XFree86-fontScalable* XFree86-fontEncodings* png libaudiofile tiff jpeg libxml2 python libxslt gnomehier scrollkeeper intltool p5-XML-Parser docbook-sk xmlcatmgr docbook-xsl docbook-xml sdocbook-xml startup-notification gnome-icon-theme Hermes sox libmpeg2 guile libltdl aspell gle cdrtools mkisofs bitstream-vera openldap-client lcms libmng libtool ghostscript*"
EXTERNAL_4_DEPENDS="libgnugetopt"
EXTERNAL_5_DEPENDS="perl-5*"
	# Ports that are obsoleted by the new GNOME version
RM_PORTS="acme gswitchit gnomevfs-extras libxklavier"
	# Files that need to be removed for the Big Update to work (chicken-and-egg kludge)
RM_FILES=""
	# The Big Update updates UPGRADE_TARGET and everything that depends on it
UPGRADE_TARGET="glib-2*"
	# Ports that should be left until after the Big Update
EXCLUDE_PORTS="libgtop2 gnomesystemmonitor gdesklets gnomeapplets2 gnome2 regexxer gnomemeeting"
	# Ports that should be installed from scratch after the Big Update
	# (Needs to be in category/port form, like editors/AbiWord2)
POSTINSTALL_PORTS=""
	# Ports that need to be rebuilt after the Big Update
	# (Make sure to include upstream dependencies!)
REINSTALL_PORTS="libgtop2 gnomesystemmonitor gdesklets gnomeapplets2 gnome2 gnomevfs2 libgnome AbiWord2* gnome2-office"

# the following exists to resolve chicken-and-egg dependency problems.
#
# Y depends upon X, but X needs to be removed for the build:
#
#if [ -x ${X11BASE}/bin/PROGRAM_X ]; then
#    if [ -x ${X11BASE}/bin/PROGRAM_Y ]; then
#        RM_PORTS="${RM_PORTS} programY"
#        POSTINSTALL_PORTS="${POSTINSTALL_PORTS} editors/programY"
#    fi
#fi

if [ -f ${X11BASE}/libdata/pkgconfig/gucharmap.pc ]; then
	if [ -x ${X11BASE}/bin/abiword ]; then
		RM_PORTS="${RM_PORTS} AbiWord2*"
		POSTINSTALL_PORTS="${POSTINSTALL_PORTS} editors/AbiWord2"
	fi
fi

## END global variable declarations.

get_tmpfile()
{
    template=$1
    tmpfile=""

    if [ -n "${MC_TMPDIR}" -a -d "${MC_TMPDIR}" ]; then
	tmpfile="${MC_TMPDIR}/${template}.XXXXXX"
    elif [ -n "${TMPDIR}" -a -d "${TMPDIR}" ]; then
	tmpfile="${TMPDIR}/${template}.XXXXXX"
    elif [ -d "/var/tmp" ]; then
	tmpfile="/var/tmp/${template}.XXXXXX"
    elif [ -d "/tmp" ]; then
	tmpfile="/tmp/${template}.XXXXXX"
    elif [ -d "/usr/tmp" ]; then
	tmpfile="/usr/tmp/${template}.XXXXXX"
    else
	return 1
    fi

    tmpfile=`mktemp -q ${tmpfile}`

    echo ${tmpfile}

    return 0
}

check_supported()
{
    version=$1
    supported=0

    for i in ${SUPPORTED_FREEBSD_VERSIONS}; do
	numeric_version=`echo ${version} | /usr/bin/cut -d'-' -f1`
	if [ ${numeric_version} = ${i} ]; then
	    supported=1
	    break
	fi
    done

    return ${supported}
}

run_pkgdb()
{
    msg=$1
    logfile=$2
    pkgdb_args="$3"
    PKGDB="${LOCALBASE}/sbin/pkgdb"

    if [ -z "$pkgdb_args" ]; then
        pkgdb_args="-aF"
    fi

    echo "===> Running ${PKGDB} ${msg} ..."
    echo "===> Running ${PKGDB} ${msg} ..." >> ${logfile}
    if [ ${VERBOSE} != 0 ]; then
	echo "INFO: Running ${PKGDB} $pkgdb_args >> ${logfile}"
    fi
    echo "INFO: Running ${PKGDB} $pkgdb_args >> ${logfile}" >> ${logfile}
    if [ "$pkgdb_args" = "-F" ]; then
        ${PKGDB} $pkgdb_args 2>&1 | /usr/bin/tee ${logfile}
    else
        ${PKGDB} $pkgdb_args 2>&1 >> ${logfile}
    fi
    # Unless a meteor hits pkgdb while it's running, this next part won't
    # even be executed ::/
    if [ $? != 0 ]; then
        echo "FAILED."
        echo "===> ${PKGDB} repair has failed.  Please repair the package database by hand (run "pkgdb -F"), then re-run this script.  If you require additional help, compress ${logfile}, and send it to ${SUPPORT_EMAIL}." | /usr/bin/fmt 75 79
        exit 1
    fi
    echo "DONE."
    return 0
}

run_portupgrade()
{
    target="$1"
    logfile=$2

    PORTUPGRADE_MAKE_ENV="${PORTUPGRADE_MAKE_ENV} GNOME_UPGRADE_SH_VER=${GNOME_UPGRADE_SH_VER}"

    echo "===> Running ${PORTUPGRADE} -O -m "BATCH=yes ${PORTUPGRADE_MAKE_ENV}" ${PORTUPGRADE_ARGS} ${target}" >> ${logfile}
    if [ ${VERBOSE} != 0 ]; then
	echo; echo "INFO: Running ${PORTUPGRADE} -O -m "BATCH=yes ${PORTUPGRADE_MAKE_ENV}" ${PORTUPGRADE_ARGS} ${target}"
    fi
    echo "INFO: Running ${PORTUPGRADE} -O -m "BATCH=yes ${PORTUPGRADE_MAKE_ENV}" ${PORTUPGRADE_ARGS} ${target}" >> ${logfile}
    ${PORTUPGRADE} -O -m "BATCH=yes ${PORTUPGRADE_MAKE_ENV}" ${PORTUPGRADE_ARGS} ${target} >> ${logfile} 2>&1

    return $?
}

## BEGIN main block.
if [ `/usr/bin/id -u` != 0 ]; then
    echo "You must be root to run this script."
    exit 1
fi
if [ ! -d ${PORTSDIR} ]; then
    echo "${PORTSDIR} does not exist or is not a directory.  Please set PORTSDIR to the directory containing the full FreeBSD ports tree." | /usr/bin/fmt 75 79
    exit 1
fi

version=`/usr/bin/uname -r`
check_supported ${version}
supported=$?

if [ ${VERBOSE} != 0 ]; then
    echo "INFO: OS version = ${version}, supported = ${supported}"
fi

if [ ${supported} = 0 ]; then
    echo "===> FreeBSD ${version} is not supported by the FreeBSD GNOME project.  Please refer to ${PROJECT_URL} for a list of supported versions." | /usr/bin/fmt 75 79
    exit 1
fi

# Seriously. We do this for your protection.
echo
echo "To prevent crashing your system, as well as to significantly speed up the upgrade, you are strongly advised to run this program from a console.  If any GNOME or Gtk+-2 application is running, you MUST abort now." | /usr/bin/fmt 75 79
echo
echo "If necessary, hit Control-C now, drop to a terminal, and restart the upgrade." | /usr/bin/fmt 75 79
echo
# $i is a good clobberable variable name
read -p "Hit <ENTER> to continue with the upgrade: " i
echo

logfile=`get_tmpfile gnome_upgrade_log`
if [ $? != 0 ]; then
    echo "===> Failed to create temporary logfile."
    exit 1
fi

if [ ${VERBOSE} != 0 ]; then
    echo "INFO: PORTSDIR = ${PORTSDIR}"
fi
echo "INFO: PORTSDIR = ${PORTSDIR}" >> ${logfile}

echo "You can watch the upgrade process in real-time by running:"
echo "		tail -f ${logfile}"
echo "INFO: logfile = ${logfile}" >> ${logfile}

major_version=`echo ${version} | /usr/bin/cut -d'.' -f1`
eval "EXTERNAL_DEPENDS=\"${EXTERNAL_DEPENDS} \${EXTERNAL_${major_version}_DEPENDS}\""

if [ ${VERBOSE} != 0 ]; then
    echo "INFO: EXTERNAL_DEPENDS = ${EXTERNAL_DEPENDS}"
fi
echo "INFO: EXTERNAL_DEPENDS = ${EXTERNAL_DEPENDS}" >> ${logfile}

# First, check to see that we have portupgrade installed.
PORTUPGRADE="${LOCALBASE}/sbin/portupgrade"
if [ ! -x ${PORTUPGRADE} ]; then
    if [ ${VERBOSE} = 1 ]; then
	echo "INFO: Portupgrade is not installed; installing ..."
    fi
    echo "INFO: Portupgrade is not installed; installing ..." >> ${logfile}
    if [ ! -d "${PORTSDIR}/sysutils/portupgrade" ]; then
	echo "===> Failed to find ${PORTSDIR}/sysutils/portupgrade.  Please make sure you have the whole ports tree checked out in ${PORTSDIR}." | /usr/bin/fmt 75 79
	exit 1
    fi
    echo -n "===> Installing sysutils/portupgrade ..."
    echo "===> Installing sysutils/portupgrade ..." >> ${logfile}
    cd ${PORTSDIR}/sysutils/portupgrade
    /usr/bin/make -DFORCE_PKG_REGISTER install clean >> ${logfile} 2>&1
    if [ $? != 0 ]; then
	echo "FAILED."
	echo "===> sysutils/portupgrade was NOT successfully installed.  Please install portupgrade manually, then re-run this script.  The output of the failed build is in ${logfile}." | /usr/bin/fmt 75 79
	exit 1
    fi
    echo "DONE."
fi

echo
echo ">>>>> STAGE 1 of 5: Cleaning the package database."

# Now we need to run pkgdb to make sure our database is consistent.
run_pkgdb "to start with a consistent package database" ${logfile}

# if there are any problems that could not be corrected in the previous step,
# an interactive run is necessary to resolve them. if the db is consistent,
# this step is just a time-consuming noop.
run_pkgdb "again, to resolve any inconsistencies that require manual interaction" ${logfile} "-F"

# Run portupgrade on all the external dependencies.
echo
echo ">>>>> STAGE 2 of 5: Updating any out-of-date GNOME dependencies."
echo "===> Running ${PORTUPGRADE} for external dependencies ..." >> ${logfile}
run_portupgrade "${EXTERNAL_DEPENDS}" ${logfile}
if [ $? != 0 ]; then
    echo "FAILED."
    echo "===> ${PORTUPGRADE} failed to run for the external GNOME dependencies.  Please make sure that ${EXTERNAL_DEPENDS} are up-to-date, then re-run this script.  The output of the failed portupgrade can be found in ${logfile}.  If you require additional help, please compress ${logfile}, and send it to ${SUPPORT_EMAIL}." | /usr/bin/fmt 75 79
    exit 1
fi
echo "DONE."

# Run pkgdb again.
run_pkgdb "after updating GNOME dependencies" ${logfile}

echo
echo ">>>>> STAGE 3 of 5: Removing previously stand-alone applications that are now a part of another GNOME application." | /usr/bin/fmt 75 79
# Remove any ports that are no longer in the tree.  Note: we can ignore errors
# here since users may not have these ports installed.
PKGDEINSTALL="${LOCALBASE}/sbin/pkg_deinstall"
for i in ${RM_PORTS}; do
    echo -n "===> Removing ${i} ..."
    echo "===> Removing ${i} ..." >> ${logfile}
    if [ ${VERBOSE} != 0 ]; then
	echo "INFO: Running ${PKGDEINSTALL} -fO ${i}"
    fi
    echo "INFO: Running ${PKGDEINSTALL} -fO ${i}" >> ${logfile}
    ${PKGDEINSTALL} -fO ${i} >> ${logfile} 2>&1
    echo "DONE."
done

# Correct any stale dependencies from stuff that got removed.
# This hopefully isn't necessary, but if it is, this is the
# place to run it.
# run_pkgdb "after removing dead packages. Note: this will take a LONG time ..." ${logfile} "-fu"

# Remove any specific files whose mere existence is known to cause build failures.
if [ ${VERBOSE} != 0 ]; then
	echo "INFO: Removing any files whose existence can cause build failures."
fi
echo "INFO: Removing any files whose existence can cause build failures." >> ${logfile}
if [ ! -z "${RM_FILES}" ]; then
	for file in ${RM_FILES}; do
		if [ ${VERBOSE} != 0 ]; then
			echo "INFO: Removing ${file}"
		fi
		echo "INFO: Removing ${file}" >> ${logfile}
		/bin/rm -f ${file}
	done
fi

# Anything in the gtk2 tree that wasn't installed as part of gtk2 carries the
# chance of killing the build.
for gtkfile in `find ${X11BASE}/lib/gtk-2.0 -type f`; do
	if [ ! `pkg_info -L gtk-2\* | grep ${gtkfile}` ]; then
		if [ ${VERBOSE} != 0 ]; then
			echo "INFO: Removing ${gtkfile}"
		fi
		echo "INFO: Removing {$gtkfile}" >> ${logfile}
		/bin/rm -f ${gtkfile}
	fi
done


echo
echo ">>>>> STAGE 4 of 5: Rebuilding all GNOME applications, and everything that relies upon them. (The Big Update)" | /usr/bin/fmt 75 79
# Now comes the fun part.  We will do a recursive forced upgrade on a certain
# target and all dependent ports.
if [ ${VERBOSE} != 0 ]; then
	echo "===> Running portupgrade on ${UPGRADE_TARGET} and all dependent ports.  Note: this will take a LONG time (a bit longer than it took to build it all the first time ...)" | /usr/bin/fmt 75 79
else
	echo "Note: this will take a LONG time (a bit longer than it took to build it all the first time ...).  If you've been planning a day trip, now would be a great time to take it." | /usr/bin/fmt 75 79
fi
echo "===> Running portupgrade on ${UPGRADE_TARGET} and all dependent ports ..." >> ${logfile}
SAVE_PORTUPGRADE_ARGS="${PORTUPGRADE_ARGS}"
PORTUPGRADE_ARGS="${PORTUPGRADE_ARGS} -r -f"
if [ ! -z "${EXCLUDE_PORTS}" ]; then
    for excl in ${EXCLUDE_PORTS}; do
	    PORTUPGRADE_ARGS="${PORTUPGRADE_ARGS} -x ${excl}"
    done
fi
run_portupgrade ${UPGRADE_TARGET} ${logfile}
if [ $? != 0 ]; then
    echo
    echo "*** UPGRADE FAILED ***"
    echo
    echo "===> ${PORTUPGRADE} failed to run a recursive upgrade on ${UPGRADE_TARGET}.  The output of the failed build is in ${logfile}.  If you require additional help in figuring out why the upgrade failed, please compress ${logfile} and send it to ${SUPPORT_EMAIL}." | /usr/bin/fmt 75 79
    exit 1
fi
PORTUPGRADE_ARGS="${SAVE_PORTUPGRADE_ARGS}"
echo
echo "${PORTUPGRADE} has finished.  That was the hard part!"

echo
echo ">>>>> STAGE 5 of 5: Rebuilding a couple ports that had to wait until new GNOME libraries were in place. (Almost done!)" | /usr/bin/fmt 75 79
# Now, install anything that needs to be installed after other
# things have been updated. This includes things that had to
# be removed for chicken-and-egg problems. This is done before
# reinstallation in case anything in POSTINSTALL belongs to
# anything in REINSTALL.
if [ ! -z "${POSTINSTALL_PORTS}" ]; then
    SAVE_PORTUPGRADE_ARGS="${PORTUPGRADE_ARGS}"
    PORTUPGRADE_ARGS="${PORTUPGRADE_ARGS} -N"
    for i in ${POSTINSTALL_PORTS}; do
        echo -n "===> Installing ${i} ..."
        echo "===> Installing ${i} ..." >> ${logfile}
        run_portupgrade ${i} ${logfile}
        if [ $? != 0 ]; then
            echo "FAILED."
            echo "===> Failed to install ${i}.  Please install this port by hand.  The output of the failed build is in ${logfile}.  If you require additional assistance reinstalling this port, please compress ${logfile} and send it to ${SUPPORT_EMAIL}." | /usr/bin/fmt 75 79
            exit 1
        fi
        echo "DONE."
    done
    PORTUPGRADE_ARGS="${SAVE_PORTUPGRADE_ARGS}"
fi

# Now we need to reinstall any ports that have weird upgrade problems.
SAVE_PORTUPGRADE_ARGS="${PORTUPGRADE_ARGS}"
PORTUPGRADE_ARGS="${PORTUPGRADE_ARGS} -f"
for i in ${REINSTALL_PORTS}; do
    echo -n "===> Reinstalling ${i} ..."
    echo "===> Reinstalling ${i} ..." >> ${logfile}
    run_portupgrade ${i} ${logfile}
    if [ $? != 0 ]; then
	echo "FAILED."
	echo "===> Failed to reinstall ${i}.  Please reinstall this port by hand.  The output of the failed build is in ${logfile}.  If you require additional assistance reinstalling this port, please compress ${logfile} and send it to ${SUPPORT_EMAIL}." | /usr/bin/fmt 75 79
	exit 1
    fi
    echo "DONE."
done
PORTUPGRADE_ARGS="${SAVE_PORTUPGRADE_ARGS}"

# Now, run pkgdb one last time just as a housekeeping step.
run_pkgdb "to clean up after ourselves" ${logfile}

echo
echo "Congratulations!  GNOME has been successfully upgraded.  Please refer to ${PROJECT_URL} for a list of known issues, FAQ, and other useful resources for running GNOME on FreeBSD." | /usr/bin/fmt 75 79

exit 0

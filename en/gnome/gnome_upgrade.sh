#!/bin/sh
#
# ##################################################################
# ##################################################################
# ## If you want to upgrade your GNOME desktop from 2.8 to 2.10,  ##
# ## you're on the right track! Read our upgrade FAQ at           ##
# ## http://www.freebsd.org/gnome/docs/faq28.html for complete    ##
# ## instructions!                                                ##
# ##################################################################
# ##################################################################
#
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
# $Id: gnome_upgrade.sh,v 1.18 2005-03-13 19:13:20 adamw Exp $
# $FreeBSD$
#

# This script will aid in doing major upgrades to the GNOME Desktop (e.g.
# an upgrade from 2.8 --> 2.10).

GNOME_UPGRADE_SH_VER=2102;	# Increment this with every functional change

## BEGIN global variable declarations.
VERBOSE=${VERBOSE:=0}
WATCH_BUILD=${WATCH_BUILD:=0}
PORTSDIR=${PORTSDIR:=/usr/ports}
LOCALBASE=${LOCALBASE:=/usr/local}
X11BASE=${X11BASE:=/usr/X11R6}

PROJECT_URL="http://www.FreeBSD.org/gnome/"
SUPPORT_EMAIL="freebsd-gnome@FreeBSD.org"

SUPPORTED_FREEBSD_VERSIONS="4.10 4.11 5.3 5.4 6.0"
	# The Big Update updates UPGRADE_TARGET and everything that depends on it
UPGRADE_TARGET="glib-2*"
	# Variables to be set across every portupgrade run
PORTUPGRADE_MAKE_ENV="GNOME_UPGRADE_SH_VER=${GNOME_UPGRADE_SH_VER} DISABLE_VULNERABILITIES=1"

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

cleanup()
{
    retval=$1
    logfile=$2

    echo "INFO: GNOME upgrade finished at `date`" >> ${logfile}

    exit ${retval}
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

    if [ -z "${pkgdb_args}" ]; then
        pkgdb_args="-aF"
    fi

    echo -n "===> Running ${PKGDB} ${msg} ..."
    echo "===> Running ${PKGDB} ${msg} ..." >> ${logfile}
    if [ ${VERBOSE} != 0 ]; then
	echo "INFO: Running ${PKGDB} ${pkgdb_args}"
    fi
    echo "INFO: Running ${PKGDB} ${pkgdb_args}" >> ${logfile}
    if [ "${pkgdb_args}" = "-F" ]; then
        ${PKGDB} ${pkgdb_args} 2>&1 | /usr/bin/tee -a ${logfile}
    else
        ${PKGDB} ${pkgdb_args} >> ${logfile} 2>&1
    fi
    # Unless a meteor hits pkgdb while it's running, this next part won't
    # even be executed ::/
    if [ $? != 0 ]; then
        echo "FAILED."
        echo "ERROR: ${PKGDB} repair has failed.  Please repair the package database by hand (run \"pkgdb -F\"), then re-run this script.  If you require additional help, compress ${logfile}, and send it to ${SUPPORT_EMAIL}." | /usr/bin/fmt 75 79
        cleanup 1 ${logfile}
    fi
    echo "DONE."
    return 0
}

run_portupgrade()
{
    logfile=$1
    shift
    target="$*"

    # insert custom env variables here, if necessary.
    PORTUPGRADE_MAKE_ENV="${PORTUPGRADE_MAKE_ENV}"

    echo "===> Running ${PORTUPGRADE} -O -m \"BATCH=yes ${PORTUPGRADE_MAKE_ENV}\" ${PORTUPGRADE_ARGS} ${target}" >> ${logfile}
    if [ ${VERBOSE} != 0 ]; then
        echo; echo "INFO: Running ${PORTUPGRADE} -O -m \"BATCH=yes ${PORTUPGRADE_MAKE_ENV}\" ${PORTUPGRADE_ARGS} ${target}"
    fi
    echo "INFO: Running ${PORTUPGRADE} -O -m \"BATCH=yes ${PORTUPGRADE_MAKE_ENV}\" ${PORTUPGRADE_ARGS} ${target}" >> ${logfile}
    ${PORTUPGRADE} -O -m "BATCH=yes ${PORTUPGRADE_MAKE_ENV}" ${PORTUPGRADE_ARGS} ${target} >> ${logfile} 2>&1

    return $?
}

## BEGIN main block.
if [ `/usr/bin/id -u` != 0 ]; then
    echo "ERROR: You must be root to run this script."
    exit 1
fi
if [ ! -d ${PORTSDIR} ]; then
    echo "ERROR: ${PORTSDIR} does not exist or is not a directory.  Please set PORTSDIR to the directory containing the full FreeBSD ports tree." | /usr/bin/fmt 75 79
    exit 1
fi

version=`/usr/bin/uname -r`
check_supported ${version}
supported=$?

if [ ${VERBOSE} != 0 ]; then
    echo "INFO: OS version = ${version}, supported = ${supported}"
fi

restart=0
upgrade_list=
if [ "$1" = "-restart" ]; then
    upgrade_list=$2
    if [ -z "${upgrade_list}" ]; then
	errormsg="ERROR: -restart requires a path to the list of GNOME ports to upgrade as its argument." | /usr/bin/fmt 75 79
    fi
    if [ ! -f ${upgrade_list} ]; then
	errormsg="ERROR: ${upgrade_list} does not exist or is not a file." | /usr/bin/fmt 75 79
    fi
    if [ ! -z "${errormsg}" ]; then
    	echo "${errormsg}" | /usr/bin/fmt 75 79
	possible_files=`ls ${TMPDIR}/gnome_upgrade_lst*`
	if [ $? = 0 ]; then
		echo "Possible upgrade lists from previous upgrade attempts: ${possible_files}" | /usr/bin/fmt 75 79
	fi
	exit 1
    fi
    restart=1
else
    upgrade_list=`get_tmpfile gnome_upgrade_lst`
    if [ $? != 0 ]; then
        echo "ERROR: Failed to create temporary upgrade list file."
        exit 1
    fi
fi

if [ ${supported} = 0 ]; then
    echo "ERROR: FreeBSD ${version} is not supported by the FreeBSD GNOME project.  Please refer to ${PROJECT_URL} for a list of supported versions." | /usr/bin/fmt 75 79
    exit 1
fi

# Seriously. We do this for your protection.
echo
echo "WARNING: To prevent crashing your system, as well as to significantly speed up the upgrade, you are strongly advised to run this program from a console.  If any GNOME or GTK+-2 application is running, you MUST abort now." | /usr/bin/fmt 75 79
echo
echo "WARNING: If necessary, hit Control-C now, drop to a terminal, and restart the upgrade." | /usr/bin/fmt 75 79
echo
# $i is a good clobberable variable name
read -p "Hit <ENTER> to continue with the upgrade: " i
echo

logfile=`get_tmpfile gnome_upgrade_log`
if [ $? != 0 ]; then
    echo "ERROR: Failed to create temporary logfile."
    exit 1
fi
tmpbase=`/usr/bin/dirname ${logfile}`
available=`/bin/df -m ${tmpbase} | /usr/bin/sed -E -e '/^[^\/]/D' | /usr/bin/awk '{print $4;}'`
if [ "${available}" -lt "200" ]; then
    echo "ERROR: Not enough space in ${tmpbase} to log the upgrade.  Please set the MC_TMPDIR variable to a location that has at least 200 MB of free space, then restart the upgrade." | /usr/bin/fmt 75 79
    exit 1
fi
echo "INFO: GNOME upgrade started at `date`" >> ${logfile}
if [ ${WATCH_BUILD} != 0 ]; then
    /usr/bin/tail -f ${logfile} &
fi

if [ ${VERBOSE} != 0 ]; then
    echo "INFO: PORTSDIR = ${PORTSDIR}"
fi
echo "INFO: PORTSDIR = ${PORTSDIR}" >> ${logfile}

if [ ${WATCH_BUILD} = 0 ]; then
    echo "You can watch the upgrade process in real-time by running:"
    echo "		tail -f ${logfile}"
    if [ ${VERBOSE} != 0 ]; then
        echo "or by defining WATCH_BUILD in your environment."
    fi
fi
echo "INFO: logfile = ${logfile}" >> ${logfile}

# First, check to see that we have portupgrade installed.
PORTUPGRADE="${LOCALBASE}/sbin/portupgrade"
if [ ! -x ${PORTUPGRADE} ]; then
    if [ ${VERBOSE} = 1 ]; then
	echo "INFO: Portupgrade is not installed; installing ..."
    fi
    echo "INFO: Portupgrade is not installed; installing ..." >> ${logfile}
    if [ ! -d "${PORTSDIR}/sysutils/portupgrade" ]; then
	echo "ERROR: Failed to find ${PORTSDIR}/sysutils/portupgrade.  Please make sure you have the whole ports tree checked out in ${PORTSDIR}." | /usr/bin/fmt 75 79
	cleanup 1 ${logfile}
    fi
    echo -n "===> Installing sysutils/portupgrade ..."
    echo "===> Installing sysutils/portupgrade ..." >> ${logfile}
    cd ${PORTSDIR}/sysutils/portupgrade
    /usr/bin/make -DFORCE_PKG_REGISTER install clean >> ${logfile} 2>&1
    if [ $? != 0 ]; then
	echo "FAILED."
	echo "ERROR: sysutils/portupgrade was NOT successfully installed.  Please install portupgrade manually, then re-run this script.  The output of the failed build is in ${logfile}." | /usr/bin/fmt 75 79
	cleanup 1 ${logfile}
    fi
    echo "DONE."
fi

exclude_ports=
if [ -n "${PORTUPGRADE_EXCLUDE}" ]; then
    for excl in ${PORTUPGRADE_EXCLUDE}; do
	exclude_ports="${exclude_ports} -x ${excl}"
    done
fi

# Obtain a list of ports that need upgrading.  We can skip this if the upgrade
# is being restarted.
if [ ${restart} = 0 ]; then
    echo -n "===> Generating list of ports to upgrade in ${upgrade_list} ..."
    echo "===> Generating list of ports to upgrade in ${upgrade_list} ..." >> ${logfile}
    ${PORTUPGRADE} -rnf ${exclude_ports} ${UPGRADE_TARGET} | \
    	/usr/bin/egrep '^[[:space:]]+\+' | /usr/bin/cut -d' ' -f2 > ${upgrade_list} 2> /dev/null
    echo "DONE."
else
    echo "INFO: Using existing upgrade list in ${upgrade_list}." >> ${logfile}
    if [ ${VERBOSE} != 0 ]; then
	echo "INFO: Using existing upgrade list in ${upgrade_list}."
    fi
fi

# Build a list of all ports not in ${upgrade_list} for our list of
# external dependencies.  Everyone should run a portupgrade -a on their
# system from time to time anyway.
echo -n "===> Generating list of external dependencies ..."
echo "===> Generating list of external dependencies ..." >> ${logfile}
result=`${PORTUPGRADE} -an ${exclude_ports} | /usr/bin/egrep '^[[:space:]]+\+' | /usr/bin/cut -d' ' -f2`

external_list=
if [ -n "${result}" ]; then
    for ext in ${result}; do
	if ! /usr/bin/grep -qw "^${ext}" ${upgrade_list}; then
	    external_list="${external_list} ${ext}"
	    if [ ${VERBOSE} != 0 ]; then
		echo "INFO: Adding ${ext} to the list of external dependencies." | /usr/bin/fmt 75 79
	    fi
	    echo "INFO: Adding ${ext} to the list of external dependencies." >> ${logfile}
	fi
    done
fi
echo "DONE."

echo
echo ">>>>> STAGE 1 of 4: Cleaning the package database."

echo
echo "The nautilus-media port was removed, because its functionality"
echo "was merged into another application. This next step might complain"
echo "about the nautilus-media port no longer existing. When it asks what"
echo "you want to do about it, you can either choose choose \"[no]\" to"
echo "ignore the issue, or, if (and only if!) you are very familiar with"
echo "pkgdb(1), you can hit CTRL-D to remove the dependency."
echo

# Now we need to run pkgdb to make sure our database is consistent.
run_pkgdb "to start with a consistent package database" ${logfile}

# if there are any problems that could not be corrected in the previous step,
# an interactive run is necessary to resolve them. if the db is consistent,
# this step is just a time-consuming noop.
run_pkgdb "again, to resolve any inconsistencies that require manual interaction" ${logfile} "-F"

# Run portupgrade on all the external dependencies.
echo
echo ">>>>> STAGE 2 of 4: Updating any out-of-date dependencies."
echo "===> Running ${PORTUPGRADE} for external dependencies ..." >> ${logfile}
if [ -n "${external_list}" ]; then
    run_portupgrade ${logfile} ${external_list}
    if [ $? != 0 ]; then
        echo "FAILED."
        echo "ERROR: ${PORTUPGRADE} failed to run for the external GNOME dependencies.  Please make sure that the following ports are up-to-date, then re-run this script.  The output of the failed portupgrade can be found in ${logfile}.  If you require additional help, please compress ${logfile}, and send it to ${SUPPORT_EMAIL}." | /usr/bin/fmt 75 79
	echo ${external_list} | /usr/bin/sed -e 'y/ /\n/'
        cleanup 1 ${logfile}
    fi
fi
echo "DONE."

# Run pkgdb again.
run_pkgdb "after updating external dependencies" ${logfile}

echo
echo ">>>>> STAGE 3 of 4: Removing all ports that depend up ${UPGRADE_TARGET}" | /usr/bin/fmt 75 79
if [ ${restart} = 0 ]; then
# Remove any ports that depend upon ${UPGRADE_TARGET}.  This isn't as bad
# as it seems since a portupgrade -f would have done this anyway.  We're
# just taking care of it up front.
PKGDEINSTALL="${LOCALBASE}/sbin/pkg_deinstall"
for i in `/bin/cat ${upgrade_list}`; do
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
else
    echo "This step is skipped on a restart."
fi

echo
echo ">>>>> STAGE 4 of 4: Rebuilding all GNOME applications, and everything that relies upon them. (The Big Update)" | /usr/bin/fmt 75 79
# Now comes the fun part.  We will do a recursive forced upgrade on a certain
# target and all dependent ports.
if [ ${VERBOSE} != 0 ]; then
	echo "===> Running portinstall for all previously installed dependencies of ${UPGRADE_TARGET}.  Note: this will take a LONG time" | /usr/bin/fmt 75 79
else
	echo "Note: this will take a LONG time.  If you've been planning a day trip, now would be a great time to take it." | /usr/bin/fmt 75 79
fi
PORTINSTALL=${LOCALBASE}/sbin/portinstall
for port in `/bin/cat ${upgrade_list}`; do
    echo "===> Running ${PORTINSTALL} -O -m \"BATCH=yes ${PORTUPGRADE_MAKE_ENV}\" ${PORTUPGRADE_ARGS} ${port}" >> ${logfile}
    if [ ${VERBOSE} != 0 ]; then
	echo; echo "INFO: Running ${PORTINSTALL} -O -m \"BATCH=yes ${PORTUPGRADE_MAKE_ENV}\" ${PORTUPGRADE_ARGS} ${port}"
    fi
    echo "INFO: Running ${PORTINSTALL} -O -m \"BATCH=yes ${PORTUPGRADE_MAKE_ENV}\" ${PORTUPGRADE_ARGS} ${port}" >> ${logfile}
    ${PORTINSTALL} -O -m "BATCH=yes ${PORTUPGRADE_MAKE_ENV}" ${PORTUPGRADE_ARGS} ${port} >> ${logfile} 2>&1
    if [ $? != 0 ]; then
        echo
        echo "*** UPGRADE FAILED ***"
        echo
        echo "ERROR: ${PORTINSTALL} failed to install ${port}.  The output of the failed build is in ${logfile}.  If you require additional help in figuring out why the upgrade failed, please compress ${logfile} and send it to ${SUPPORT_EMAIL}." | /usr/bin/fmt 75 79
	echo
	echo "INFO: If you wish to resume this upgrade where it left off, re-run this script with the \"-restart ${upgrade_list}\" argument." | /usr/bin/fmt 75 79
        cleanup 1 ${logfile}
    fi
done
echo
echo "${PORTINSTALL} has finished.  That was the hard part!"

# Now, run pkgdb one last time just as a housekeeping step.
run_pkgdb "to clean up after ourselves" ${logfile}

echo
echo "Congratulations!  GNOME has been successfully upgraded.  Please refer to ${PROJECT_URL} for a list of known issues, FAQ, and other useful resources for running GNOME on FreeBSD." | /usr/bin/fmt 75 79

/bin/rm -f ${upgrade_list}

cleanup 0 ${logfile}

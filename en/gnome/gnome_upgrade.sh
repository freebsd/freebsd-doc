#!/bin/sh
#
# ##################################################################
# ##################################################################
# ## If you want to upgrade your GNOME desktop from 2.10 to 2.12, ##
# ## you're on the right track! Read our upgrade FAQ at           ##
# ## http://www.freebsd.org/gnome/docs/faq212.html for complete   ##
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
# $MCom: portstools/gnome_upgrade.sh.in,v 1.154 2005/10/02 05:50:39 marcus Exp $
#   $FreeBSD$
#

# This script will aid in doing major upgrades to the GNOME Desktop (e.g.
# an upgrade from 2.10 --> 2.12).

GNOME_UPGRADE_SH_VER=2.12-3;	# Increment this with every functional change
GNOME_UPGRADE_SH_REV='$Revision: 1.23 $'

## BEGIN global variable declarations.
VERBOSE=${VERBOSE:=0}
WATCH_BUILD=${WATCH_BUILD:=0}
PORTSDIR=${PORTSDIR:=/usr/ports}
LOCALBASE=${LOCALBASE:=/usr/local}
X11BASE=${X11BASE:=/usr/X11R6}

PROJECT_URL="http://www.FreeBSD.org/gnome/"
SUPPORT_EMAIL="freebsd-gnome@FreeBSD.org"
PORTSTREE="MarcusCom"
TB_URL="http://www.marcuscom.com/tb/packages%s/%s-%s/Latest/"

SUPPORTED_FREEBSD_VERSIONS="5.3 5.4 6.0 7.0"
	# The Big Update updates UPGRADE_TARGET and everything that depends on it
UPGRADE_TARGET="glib-2*"
	# Ports to remove before doing the upgrade.
RM_PORTS="clearlooks clearlooks-metacity"
	# Apps that cannot be built with the new GNOME version and must be removed
PORTUPGRADE_EXCLUDE=""
	# Variables to be set across every portupgrade run
PORTUPGRADE_MAKE_ENV="GNOME_UPGRADE_SH_VER=${GNOME_UPGRADE_SH_VER} DISABLE_VULNERABILITIES=1"

## END global variable declarations.

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

usage () {
    echo "usage: $0 [-f] [-k] [-h] [-P] [-p] [-v] [-restart <list filename>]"
    echo ""
    echo "    -f       : Do not prompt for any confirmations (think: force)"
    echo "    -k       : Keep going even if an error is encountered"
    echo "    -h       : Print this usage summary and exit"
    echo "    -p       : Use packages for upgrades where possible (note: Tinderbox                       packages will be used unless PACKAGESITE is set prior to starting               the upgrade)"
    echo "    -P       : Only use packages for upgrades (note: Tinderbox packages will be                used unless PACKAGESITE is set prior to starting the upgrade)"
    echo "    -v       : Print the version of $0 and exit"
    echo "    -restart : Restart a failed upgrade using the <list filename> to get the                   list of ports that still require an upgrade"
}

cleanup()
{
    retval=$1
    logfile=$2

    if [ ${retval} = 0 ]; then
	echo "INFO: GNOME upgrade finished successfully at `date`" >> ${logfile}
    else
	echo "INFO: GNOME upgrade FAILED at `date`" >> ${logfile}
    fi

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

rm_pkg()
{
    pkg=$1
    logfile=$2

    PKGDEINSTALL="${LOCALBASE}/sbin/pkg_deinstall"

    echo -n "===> Removing ${pkg} ..."
    echo "===> Removing ${pkg} ..." >> ${logfile}
    if [ ${VERBOSE} != 0 ]; then
        echo "INFO: Running ${PKGDEINSTALL} -fO ${pkg}"
    fi
    echo "INFO: Running ${PKGDEINSTALL} -fO ${pkg}" >> ${logfile}
    ${PKGDEINSTALL} -fO ${pkg} >> ${logfile} 2>&1
    echo "DONE."
}

## BEGIN main block.
# Print some basic version information
force=0
keepgoing=0
restart=0
packages=0
onlypkgs=0
upgrade_list=
while [ $# -gt 0 ]; do
    case "x$1" in
	x-f)
	  force=1
	  ;;
	x-k)
	  keepgoing=1
	  ;;
	x-restart)
	  shift
	  restart=1
	  upgrade_list=$1
	  ;;
	x-P)
	  packages=1
	  onlypkgs=1
	  ;;
	x-p)
	  packages=1
	  ;;
	x-h)
	  usage
	  exit 0
	  ;;
	x-v)
          echo "FreeBSD GNOME Upgrade tool: gnome_upgrade.sh"
          echo "--"
          echo "Script version: ${GNOME_UPGRADE_SH_VER}"
          echo 'MarcusCom revision: $MCom: portstools/gnome_upgrade.sh.in,v 1.154 2005/10/02 05:50:39 marcus Exp $'
          echo 'FreeBSD revision: $FreeBSD$'
          echo "--"
          echo "Visit http://www.freebsd.org/gnome for more information"
          echo ""
          exit 0
	  ;;
	*)
	  usage
	  exit 1
	  ;;
    esac
    shift
done

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

if [ ${supported} = 0 ]; then
    echo "ERROR: FreeBSD ${version} is not supported by the FreeBSD GNOME project.  Please refer to ${PROJECT_URL} for a list of supported versions." | /usr/bin/fmt 75 79
    exit 1
fi

if [ ${restart} = 1 ]; then
    if [ -z "${upgrade_list}" ]; then
	errormsg="ERROR: -restart requires a path to the list of GNOME ports to upgrade as its argument."
    fi
    if [ ! -f ${upgrade_list} ]; then
	errormsg="ERROR: ${upgrade_list} does not exist or is not a file."
    fi
    if [ ! -z "${errormsg}" ]; then
    	echo "${errormsg}" | /usr/bin/fmt 75 79
	tempdir=`get_tmpdir`
	possible_files=`/bin/ls ${tempdir}/gnome_upgrade_lst*`
	if [ $? = 0 ]; then
		echo "Possible upgrade lists from previous upgrade attempts: ${possible_files}" | /usr/bin/fmt 75 79
	fi
	exit 1
    fi
else
    upgrade_list=`get_tmpfile gnome_upgrade_lst`
    if [ $? != 0 ]; then
        echo "ERROR: Failed to create temporary upgrade list file."
        exit 1
    fi
fi

# Seriously. We do this for your protection.
echo
echo "WARNING: To prevent crashing your system, as well as to significantly speed up the upgrade, you are strongly advised to run this program from a console.  If any GNOME or GTK+-2 application is running, you MUST abort now." | /usr/bin/fmt 75 79
echo
echo "WARNING: If necessary, hit Control-C now, drop to a terminal, and restart the upgrade." | /usr/bin/fmt 75 79
echo
if [ ${force} = 0 ]; then
    read -p "Hit <ENTER> to continue with the upgrade: " i
fi
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

export HTTP_USER_AGENT="gnome_upgrade/${GNOME_UPGRADE_SH_VER} (rev. ${GNOME_UPGRADE_SH_REV})"

# Check to see if the user would like to use packages.
if [ ${packages} = 1 ]; then
    if [ ${VERBOSE} = 1 ]; then
	echo "INFO: Enabling package support"
    fi
    echo "INFO: Enabling package support" >> ${logfile}
    if [ -z "${PACKAGESITE}" ]; then
        arch=`/usr/bin/uname -m`
        if [ ${arch} = "i386" -o ${arch} = "amd64" ]; then
	    tbarch=""
	    if [ ${VERBOSE} = 1 ]; then
	        echo "INFO: Architecture is ${arch}; using Tinderbox for PACKAGESITE"
	    fi
	    echo "INFO: Architecture is ${arch}; using Tinderbox for PACKAGESITE" >> ${logfile}
	    if [ ${arch} = "amd64" ]; then
	        tbarch="-amd64"
	    fi
	    tbversion=`echo ${version} | /usr/bin/cut -d'-' -f1`
	    version_sufx=`echo ${version} | /usr/bin/cut -d'-' -f2`
	    if [ ${version_sufx} = "CURRENT" -o ${version_sufx} = "STABLE" ]; then
	        major_version=`echo ${tbversion} | /usr/bin/cut -d'.' -f1`
	        tbversion="${major_version}-${version_sufx}"
	    fi
	    PACKAGESITE=`/usr/bin/printf ${TB_URL} "${tbarch}" ${tbversion} ${PORTSTREE}`
	    if [ ${VERBOSE} = 1 ]; then
	        echo "INFO: PACKAGESITE set to ${PACKAGESITE}"
	    fi
	    echo "INFO: PACKAGESITE set to ${PACKAGESITE}" >> ${logfile}
	    export PACKAGESITE
        else
	    echo "WARNING: You are upgrading on ${arch} for which there is no Tinderbox.  Packages may not be available." | /usr/bin/fmt 75 79
	    echo "WARNING: You are upgrading on ${arch} for which there is no Tinderbox.  Packages may not be available." >> ${logfile}
	fi
    else
	if [ ${VERBOSE} = 1 ]; then
	    echo "INFO: Using pre-set PACAKGESITE ${PACKAGESITE} for packages."
	fi
	echo "INFO: Using pre-set PACAKGESITE ${PACKAGESITE} for packages." >> ${logfile}
    fi

    if [ ${onlypkgs} = 1 ]; then
	echo "WARNING: Only packages will be used for upgrading; this may lead to failures" | /usr/bin/fmt 75 79
	echo "WARNING: Only packages will be used for upgrading; this may lead to failures" >> ${logfile}
	PORTUPGRADE_ARGS="-PP"
    else
        PORTUPGRADE_ARGS="-P"
    fi
fi

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
    if [ -n "${RM_PORTS}" ]; then
        echo "===> Removing ports that can no longer be installed with GNOME."
        echo "===> Removing ports that can no longer be installed with GNOME." >> ${logfile}
        for i in ${RM_PORTS}; do
	    rm_pkg ${i} ${logfile}
        done
    fi
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

# We run pkgdb twice. The first time, we run pkgdb -fu, which rebuilds the
# entire database from scratch. This takes a decent chunk of time (a minute
# or two), but if the database is inconsistent, portupgrade(1) will fail. And
# when portupgrade fails, external dependencies don't actually get updated.
# The second time, we run pkgdb -F just in case. Once we're sure that pkgdb -fu
# does what we want it to do, the second time can probably just be removed.

# Run pkgdb -fu to force a clean database.
run_pkgdb "the Long Way to make sure the package database is clean" ${logfile} "-fu"

# If there are any problems that could not be corrected in the previous step,
# an interactive run is necessary to resolve them. If the db is consistent,
# this step is just a time-consuming NOOP. In fact, given that we force a
# database rebuild, this step is probably a NOOP no matter what.
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
for i in `/bin/cat ${upgrade_list}`; do
    rm_pkg ${i} ${logfile}
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
failed_ports=
port_count=0
total_count=`/usr/bin/wc -l ${upgrade_list} | /usr/bin/awk '{print $1}'`
for port in `/bin/cat ${upgrade_list}`; do
    echo "===> Running ${PORTINSTALL} -O -m \"BATCH=yes ${PORTUPGRADE_MAKE_ENV}\" ${PORTUPGRADE_ARGS} ${port}" >> ${logfile}
    if [ ${VERBOSE} != 0 ]; then
	echo; echo "INFO: Running ${PORTINSTALL} -O -m \"BATCH=yes ${PORTUPGRADE_MAKE_ENV}\" ${PORTUPGRADE_ARGS} ${port}"
    fi
    echo "INFO: Running ${PORTINSTALL} -O -m \"BATCH=yes ${PORTUPGRADE_MAKE_ENV}\" ${PORTUPGRADE_ARGS} ${port}" >> ${logfile}
    port_count=`expr ${port_count} + 1`
    echo "Upgrading ${port} (${port_count}/${total_count})"
    ${PORTINSTALL} -O -m "BATCH=yes ${PORTUPGRADE_MAKE_ENV}" ${PORTUPGRADE_ARGS} ${port} >> ${logfile} 2>&1
    if [ $? != 0 ]; then
	if [ ${keepgoing} = 1 ]; then
	    failed_ports="${failed_ports} ${port}"
	else
            echo
            echo "*** UPGRADE FAILED ***"
            echo
            echo "ERROR: ${PORTINSTALL} failed to install ${port}.  The output of the failed build is in ${logfile}.  If you require additional help in figuring out why the upgrade failed, please compress ${logfile} and send it to ${SUPPORT_EMAIL}." | /usr/bin/fmt 75 79
	    echo
	    echo "INFO: If you wish to resume this upgrade where it left off, re-run this script with the \"-restart ${upgrade_list}\" argument." | /usr/bin/fmt 75 79
            cleanup 1 ${logfile}
	fi
    fi
done
echo
if [ -n "${failed_ports}" ]; then
    echo "*** UPGRADE FAILED ***"
    echo
    echo "ERROR: ${PORTINSTALL} failed to install the following ports.  The output of the failed build(s) are in ${logfile}.  If you require additional help in figuring out why the upgrade failed, please compress ${logfile} and send it to ${SUPPORT_EMAIL}." | /usr/bin/fmt 75 79
    echo
    for port in ${failed_ports}; do
	echo "    ${port}"
    done
    cleanup 1 ${logfile}
fi

echo "${PORTINSTALL} has finished.  That was the hard part!"

# Now, run pkgdb one last time just as a housekeeping step.
run_pkgdb "to clean up after ourselves" ${logfile}

echo
echo "Congratulations!  GNOME has been successfully upgraded.  Please refer to ${PROJECT_URL} for a list of known issues, FAQ, and other useful resources for running GNOME on FreeBSD." | /usr/bin/fmt 75 79

/bin/rm -f ${upgrade_list}

cleanup 0 ${logfile}

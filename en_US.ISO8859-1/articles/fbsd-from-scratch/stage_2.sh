#!/bin/sh
#
# stage_2.sh - FreeBSD From Scratch, Stage 2: Ports Installation.
#              Usage: ./stage_2.sh {configname}
#
# $Id: stage_2.sh,v 1.2 2004-01-03 15:46:31 schweikh Exp $
# $FreeBSD$

DBDIR="/var/db/pkg"
PORTS="/usr/ports"
LOGDIR="/home/root/setup/ports.log"; mkdir -p ${LOGDIR}

# The linprocfs appears to be required for certain java/jdk* ports.
if mount | grep '^linprocfs'; then
	: # linprocfs already mounted.
else
	mount /compat/linux/proc
fi

MYNAME="$(basename $0)"
usage () {
	exec >&2
	echo "usage: ${MYNAME} [-hn] configname"
	echo ""
	echo "  Options:"
	echo "  -h    Print this help text."
	echo "  -n    Dryrun: just show what would be done."
	echo ""
	echo "  The config file (stage_2.conf.configname) is a list of"
	echo "  ports to install with one entry per line. Each line"
	echo "  consists of two or three space separated fields:"
	echo "  category, port, and optionally a build command."
	echo ""
	exit 1
}

args=`getopt hn $*`
if test $? != 0; then
	usage
fi
set -- $args
DRYRUN=
for i; do
	case "$i" in
	-n) DRYRUN="yes"; shift;;
	--) shift; break;;
	*) usage;;
	esac
done
if test $# -eq 1; then
	DATAFILE="$1"
else
	usage
fi

while read CATEGORY NAME CMD; do
	case "${CATEGORY}" in
	\#*) continue;;
	'') continue;;
	esac
	DIR="${PORTS}/${CATEGORY}/${NAME}"
	if ! test -d "${DIR}"; then
		echo "$DIR does not exist -- ignored"
		continue
	fi
	cd ${DIR}
	PKGNAME=`make -V PKGNAME`
	if test -d "${DBDIR}/${PKGNAME}"; then
		echo "${CATEGORY}/${NAME} already installed as ${PKGNAME}"
		continue
	fi
	LOG="${LOGDIR}/${CATEGORY}+${NAME}"
	echo "===> Installing ${CATEGORY}/${NAME}; logging to ${LOG}"
	test -n "${CMD}" || CMD="make install < /dev/null"
	if test -n "${DRYRUN}"; then
		if ls ${PKGNAME}.* >/dev/null 2>&1; then
			echo pkg_add -v ${PKGNAME}.*
		else
			echo "${CMD}"
		fi
		continue
	fi
	date "++++ Started %v %T +++" > ${LOG}
	STARTED=$(date +%s)
	echo "CMD: ${CMD}" >> ${LOG}
	(
		if ls ${PKGNAME}.* >/dev/null 2>&1; then
			echo "Found package" ${PKGNAME}.*
			pkg_add -v ${PKGNAME}.*
		else
			make clean
			eval "${CMD}"
			make clean # Uncomment if diskspace is tight under ${PORTS}.
		fi
	) 2>&1 | tee -a ${LOG}
	FINISHED=$(date +%s)
	DURATION=$(dc -e "${FINISHED} ${STARTED} - p")
	date "++++ Finished %v %T after ${DURATION} secs +++" >> ${LOG}
done < stage_2.conf.${DATAFILE}

# vim: tabstop=4:
# EOF $RCSfile: stage_2.sh,v $

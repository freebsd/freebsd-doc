#!/bin/sh
#
# stage_2.sh - FreeBSD From Scratch, 第 2 段階: ports のインストール
#              使い方: ./stage_2.sh [-hnp] configname
#
# 著者:      Jens Schweikhardt
# $Id: stage_2.sh,v 1.2 2006-03-13 16:46:15 rushani Exp $
# $FreeBSD$
# Original revision: 1.5

DBDIR="/var/db/pkg"
PORTS="/usr/ports"
: ${PACKAGES:=${PORTS}/packages}
LOGDIR="/home/root/setup/ports.log"; mkdir -p ${LOGDIR}
PKG_PATH="/cdrom/packages/All:/dvd/packages/All"
PKG=

MYNAME="$(basename $0)"
usage () {
	exec >&2
	echo "usage: ${MYNAME} [-hnp] configname"
	echo ""
	echo "  Options:"
	echo "  -h    Print this help text."
	echo "  -n    Dryrun: just show what would be done."
	echo "  -p    Install a precompiled package if one can be found."
	echo ""
	echo "  The config file (stage_2.conf.configname) is a list of"
	echo "  ports to install with one entry per line. Each line"
	echo "  consists of two or three space separated fields:"
	echo "  category, port, and optionally a build command."
	echo ""
	exit 1
}

# これらの場所にあるパッケージを順に探す。
# 1 つ見つかり次第戻って、結果を標準出力に表示する。
#
#   ${PORTS}/${CATEGORY}/${NAME}
#   ${PACKAGES}/All
#   ${PACKAGES}/${CATEGORY}
#   ${PKG_PATH}
#
find_package () {
	echo "${PORTS}/${CATEGORY}/${NAME}:${PACKAGES}/All:${PACKAGES}/${CATEGORY}:${PKG_PATH}" |
	tr : '\n' |
	while read d; do
		test -d "${d}" || continue
		PKG=$(ls ${d}/${PKGNAME}.* 2>/dev/null)
		test $? -eq 0 && echo "${PKG}" && return
	done
}

#
# コマンドライン引数を処理する。
#
args=`getopt hnp $*`
if test $? != 0; then
	usage
fi
set -- $args
DRYRUN=
CHKPKG=
for i; do
	case "$i" in
	-n) DRYRUN="yes"; shift;;
	-p) CHKPKG="yes"; shift;;
	--) shift; break;;
	*) usage;;
	esac
done
if test $# -eq 1; then
	DATAFILE="$1"
else
	usage
fi

#
# ports 一覧に対して繰り返す。
#
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
	if test -n "${CHKPKG}"; then
		PKG=$(find_package)
	else
		PKG=""
	fi
	if test -d "${DBDIR}/${PKGNAME}"; then
		echo "${CATEGORY}/${NAME} already installed as ${PKGNAME}"
		continue
	fi
	LOG="${LOGDIR}/${CATEGORY}+${NAME}"
	echo "===> Installing ${CATEGORY}/${NAME}; logging to ${LOG}"
	test -n "${CMD}" || CMD="make install BATCH=yes < /dev/null"
	if test -n "${DRYRUN}"; then
		if test -n "${PKG}"; then
			echo pkg_add -v ${PKG}
		else
			echo "${CMD}"
		fi
		continue
	fi
	date "++++ Started %v %T +++" > ${LOG}
	STARTED=$(date +%s)
	(
		if test -n "${PKG}"; then
			echo "Found package ${PKG}"
			pkg_add -v ${PKG}
		else
			echo "CMD: ${CMD}"
			make clean
			eval "${CMD}"
			make clean # ${PORTS} 以下のディスク容量がすくなければコメントをはずす
		fi
	) 2>&1 | tee -a ${LOG}
	FINISHED=$(date +%s)
	DURATION=$(dc -e "${FINISHED} ${STARTED} - p")
	date "++++ Finished %v %T after ${DURATION} secs +++" >> ${LOG}
done < stage_2.conf.${DATAFILE}

# vim: tabstop=4:
# EOF $RCSfile: stage_2.sh,v $

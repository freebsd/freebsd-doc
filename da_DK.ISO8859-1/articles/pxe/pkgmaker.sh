#!/bin/sh

# $Wintelcom: src/freebsd/pxe/doc/pkgmaker.sh,v 1.1 2000/07/14 12:42:05 bright Exp $
# $FreeBSD$

PKGNAME=${1}
PKGDIR=`pwd`/${PKGNAME}/

pkg_create -i ${PKGDIR}pre -I ${PKGDIR}post -f ${PKGDIR}PLIST  -s ${PKGDIR} -p / -d ${PKGDIR}DESCR -c ${PKGDIR}COMMENT ${PKGNAME}.tgz

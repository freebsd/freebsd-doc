#
# $FreeBSD$
#
# Article: FreeBSD PXE Jumpstart Guide

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

EXTRAS=		dhcpd.conf
EXTRAS+=	install.cfg
EXTRAS+=	loader.rc
EXTRAS+=	pkgmaker.sh
EXTRAS+=	post
EXTRAS+=	pre

SRCS=	article.sgml

afterinstall:
.for entry in ${EXTRAS}
	${INSTALL_DOCS} ${.CURDIR}/${entry} ${DESTDIR}
.endfor

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

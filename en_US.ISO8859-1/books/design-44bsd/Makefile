# $FreeBSD$

DOC?= book

FORMATS?= html

IMAGES_EN= fig1.eps fig2.eps

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

WITH_DOCFORMAT_NAVI_LINK?=YES

SRCS= book.sgml

# Use the local DSSSL file
DSLHTML?=       ${.CURDIR}/freebsd.dsl
DSLPRINT?=      ${.CURDIR}/freebsd.dsl

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

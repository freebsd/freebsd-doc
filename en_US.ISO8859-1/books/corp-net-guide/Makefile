# $FreeBSD$

DOC?= book

FORMATS?= html

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

WITH_DOCFORMAT_NAVI_LINK?=YES

SRCS= book.sgml

IMAGES_EN=		08-01.eps
IMAGES_EN+= 	08-02.eps
IMAGES_EN+=	08-03.eps
IMAGES_EN+=	08-04.eps
IMAGES_EN+=	08-05.eps
IMAGES_EN+=	08-06.eps

# Use the local DSSSL file
DSLHTML?=       ${.CURDIR}/freebsd.dsl
DSLPRINT?=      ${.CURDIR}/freebsd.dsl

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

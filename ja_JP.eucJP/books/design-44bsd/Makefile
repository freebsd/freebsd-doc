# $FreeBSD$
# Original revision: 1.2

DOC?= book

FORMATS?= html

IMAGES= fig1.eps fig2.eps

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

SRCS= book.sgml

# Use the local DSSSL file
DSLHTML?=       ${.CURDIR}/freebsd.dsl
DSLPRINT?=      ${.CURDIR}/freebsd.dsl

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

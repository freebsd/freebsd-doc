# $FreeBSD: doc/en_US.ISO_8859-1/books/design-44bsd/Makefile,v 1.1 2001/02/20 20:01:32 nik Exp $

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

# $FreeBSD: doc/en_US.ISO_8859-1/books/design-44bsd/Makefile,v 1.2 2001/03/09 18:05:31 nik Exp $

DOC?= book

FORMATS?= html

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

SRCS= book.sgml

IMAGES=		08-01.eps
IMAGES+= 	08-02.eps
IMAGES+=	08-03.eps
IMAGES+=	08-04.eps
IMAGES+=	08-05.eps
IMAGES+=	08-06.eps

# Use the local DSSSL file
DSLHTML?=       ${.CURDIR}/freebsd.dsl
DSLPRINT?=      ${.CURDIR}/freebsd.dsl

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

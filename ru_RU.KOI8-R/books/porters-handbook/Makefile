# 
# $FreeBSD: doc/ru_RU.KOI8-R/books/porters-handbook/Makefile,v 1.1 2000/10/17 17:25:01 phantom Exp $
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/porters-handbook/Makefile,v 1.2 2000/09/17 15:15:41 phantom Exp $
#
# Build the FreeBSD Porter's Handbook.
#

MAINTAINER=andy@FreeBSD.org.ua

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml

# Use the local DSSSL file
DSLHTML?= 	${.CURDIR}/freebsd.dsl
DSLPRINT?= 	${.CURDIR}/freebsd.dsl

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# 
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/porters-handbook/Makefile,v 1.3 2000/11/15 17:21:30 phantom Exp $
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

# 
# $FreeBSD: doc/ru_RU.KOI8-R/books/faq/Makefile,v 1.8 2000/12/29 14:36:48 phantom Exp $
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/faq/Makefile,v 1.4 2000/11/15 17:21:30 phantom Exp $
#
# Build the Russian FreeBSD FAQ
#

MAINTAINER=andy@FreeBSD.org phantom@FreeBSD.org

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS =	book.sgml 

# entities
SRCS+=	../../../en_US.ISO8859-1/books/handbook/authors.ent

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

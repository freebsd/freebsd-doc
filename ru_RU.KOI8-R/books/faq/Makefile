# 
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/faq/Makefile,v 1.3 2000/10/17 16:55:05 phantom Exp $
#
# Build the Russian FreeBSD FAQ
#

MAINTAINER=andy@FreeBSD.org phantom@FreeBSD.org

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

NO_TIDY=	YES

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS =	book.sgml 

# entities
SRCS+=	../../../en_US.ISO_8859-1/books/handbook/authors.ent

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

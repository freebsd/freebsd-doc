# 
# $FreeBSD: doc/ru_RU.KOI8-R/books/faq/Makefile,v 1.10 2001/07/25 14:07:11 phantom Exp $
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/faq/Makefile,v 1.6 2001/07/08 15:40:58 phantom Exp $
#
# Original revision: 1.6
# Build the Russian FreeBSD FAQ
#

MAINTAINER=andy@FreeBSD.org phantom@FreeBSD.org

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

JADEFLAGS+= -Vbiblio-xref-title
# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS =	book.sgml 

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

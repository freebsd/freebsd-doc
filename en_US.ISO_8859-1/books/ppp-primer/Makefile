# 
# $FreeBSD: doc/en_US.ISO_8859-1/books/faq/Makefile,v 1.6 1999/09/06 06:52:39 peter Exp $
#
# Build the PPP PrimerQ
#

MAINTAINER=nik@FreeBSD.org

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml 

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# 
# $FreeBSD: doc/ja_JP.eucJP/books/faq/Makefile,v 1.8 2000/02/03 03:11:04 kuriyama Exp $
#
# Build the FreeBSD FAQ
#
# Original revision: 1.6
#

MAINTAINER=kuriyama@FreeBSD.ORG

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
SRCS=  book.sgml 

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

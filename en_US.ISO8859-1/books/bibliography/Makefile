# 
# $FreeBSD: doc/en_US.ISO8859-1/books/handbook/Makefile,v 1.40 2001/07/17 01:37:39 murray Exp $
#
#

MAINTAINER=nik@FreeBSD.org

DOC?= book

FORMATS?= html

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

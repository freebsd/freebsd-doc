# 
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/developers-handbook/Makefile,v 1.1 2001/03/11 12:13:46 phantom Exp $
# $FreeBSD$
# Original revision: 1.1
#
# Build the FreeBSD Developers' Handbook.
#

MAINTAINER=asmodai@FreeBSD.org

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

# Entities

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

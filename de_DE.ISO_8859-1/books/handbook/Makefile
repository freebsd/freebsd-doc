# 
# $FreeBSD: doc/de_DE.ISO_8859-1/books/handbook/Makefile,v 1.5 2000/08/18 12:47:39 alex Exp $
#
# Build the FreeBSD Handbook in its German translation.
#

MAINTAINER=alex@FreeBSD.org

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
SRCS+= backups/chapter.sgml
SRCS+= basics/chapter.sgml
SRCS+= bibliography/chapter.sgml
SRCS+= ports/chapter.sgml

# Entities
SRCS+= ../../../en_US.ISO_8859-1/books/handbook/authors.ent 
SRCS+= chapters.ent 
SRCS+= newsgroups.ent 

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# 
# $FreeBSD: doc/de_DE.ISO_8859-1/books/handbook/Makefile,v 1.3 2000/06/29 10:08:28 alex Exp $
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

# Entities
SRCS+= ../../../en_US.ISO_8859-1/books/handbook/authors.ent 
SRCS+= chapters.ent 
SRCS+= newsgroups.ent 

# German
SRCS+= de-authors.ent 

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

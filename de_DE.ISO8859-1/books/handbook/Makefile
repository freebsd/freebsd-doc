# 
# $FreeBSD$
# $FreeBSDde: de-docproj/books/handbook/Makefile,v 1.11 2001/11/29 21:50:28 mheinen Exp $
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
SRCS+= basics/chapter.sgml
SRCS+= bibliography/chapter.sgml
SRCS+= config/chapter.sgml
SRCS+= disks/chapter.sgml
SRCS+= ports/chapter.sgml
SRCS+= security/chapter.sgml
SRCS+= sound/chapter.sgml
SRCS+= users/chapter.sgml

# Entities
SRCS+= chapters.ent 
SRCS+= newsgroups.ent 

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

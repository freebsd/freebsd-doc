# 
# $FreeBSD$
# $FreeBSDde: de-docproj/books/handbook/Makefile,v 1.17 2002/05/09 15:56:27 mheinen Exp $
#
# Build the FreeBSD Handbook in its German translation.
#

MAINTAINER=alex@FreeBSD.org

DOC?= book

FORMATS?= html-split

HAS_INDEX= true

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# Images from the cross-document image library
IMAGES_LIB=  callouts/1.png
IMAGES_LIB+= callouts/2.png
IMAGES_LIB+= callouts/3.png
IMAGES_LIB+= callouts/4.png
IMAGES_LIB+= callouts/5.png

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS+= book.sgml
SRCS+= basics/chapter.sgml
SRCS+= bibliography/chapter.sgml
SRCS+= cutting-edge/chapter.sgml
SRCS+= boot/chapter.sgml
SRCS+= config/chapter.sgml
SRCS+= disks/chapter.sgml
SRCS+= kernelconfig/chapter.sgml
SRCS+= ports/chapter.sgml
SRCS+= security/chapter.sgml
SRCS+= serialcomms/chapter.sgml
SRCS+= sound/chapter.sgml
SRCS+= users/chapter.sgml

# Entities
SRCS+= chapters.ent 
SRCS+= newsgroups.ent 

# alle Kapitel bauen
CHAPTERS?= ${SRCS:M*chapter.sgml}

SGMLFLAGS+= ${CHAPTERS:S/\/chapter.sgml//:S/^/-i chap./}

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

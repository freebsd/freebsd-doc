# 
# $FreeBSD: doc/en_US.ISO_8859-1/books/developers-handbook/Makefile,v 1.3 2001/05/11 10:27:00 murray Exp $
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
SRCS+= tools/chapter.sgml
SRCS+= secure/chapter.sgml
SRCS+= locking/chapter.sgml
SRCS+= isa/chapter.sgml
SRCS+= pci/chapter.sgml
SRCS+= usb/chapter.sgml
SRCS+= scsi/chapter.sgml
SRCS+= x86/chapter.sgml
SRCS+= vm/chapter.sgml
SRCS+= dma/chapter.sgml
SRCS+= ipv6/chapter.sgml

# Entities

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

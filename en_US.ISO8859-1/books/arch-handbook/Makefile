# 
# $FreeBSD: doc/en_US.ISO8859-1/books/developers-handbook/Makefile,v 1.5 2001/06/22 08:49:10 murray Exp $
#
# Build the FreeBSD Developers' Handbook.
#

MAINTAINER=asmodai@FreeBSD.org

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

GEN_INDEX?= yes

# Images
IMAGES= sockets/layers.eps sockets/sain.eps sockets/sainfill.eps sockets/sainlsb.eps sockets/sainmsb.eps sockets/sainserv.eps sockets/serv.eps sockets/serv2.eps sockets/slayers.eps

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml
SRCS+= tools/chapter.sgml
SRCS+= secure/chapter.sgml
SRCS+= locking/chapter.sgml
SRCS+= sockets/chapter.sgml
SRCS+= ipv6/chapter.sgml
SRCS+= isa/chapter.sgml
SRCS+= pci/chapter.sgml
SRCS+= usb/chapter.sgml
SRCS+= scsi/chapter.sgml
SRCS+= x86/chapter.sgml
SRCS+= vm/chapter.sgml
SRCS+= dma/chapter.sgml

# Entities

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

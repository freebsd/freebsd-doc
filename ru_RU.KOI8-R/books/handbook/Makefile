# 
# Build the FreeBSD Handbook.
#
# The FreeBSD Russian Documentation Project
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/handbook/Makefile,v 1.18 2001/03/11 12:04:50 phantom Exp $
# Original version: 1.28
#

MAINTAINER=phantom@FreeBSD.org

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
SRCS+= advanced-networking/chapter.sgml
SRCS+= backups/chapter.sgml
SRCS+= basics/chapter.sgml
SRCS+= bibliography/chapter.sgml
SRCS+= boot/chapter.sgml
#SRCS+= contrib/chapter.sgml
SRCS+= cutting-edge/chapter.sgml
SRCS+= disks/chapter.sgml
#SRCS+= eresources/chapter.sgml
#SRCS+= hw/chapter.sgml
SRCS+= install/chapter.sgml
#SRCS+= internals/chapter.sgml
SRCS+= introduction/chapter.sgml
#SRCS+= kernelconfig/chapter.sgml
SRCS+= kerneldebug/chapter.sgml
SRCS+= kernelopts/chapter.sgml
#SRCS+= l10n/chapter.sgml
SRCS+= linuxemu/chapter.sgml
SRCS+= mail/chapter.sgml
SRCS+= mirrors/chapter.sgml
SRCS+= pgpkeys/chapter.sgml
SRCS+= policies/chapter.sgml
SRCS+= ports/chapter.sgml
#SRCS+= ppp-and-slip/chapter.sgml
#SRCS+= printing/chapter.sgml
SRCS+= security/chapter.sgml
#SRCS+= serialcomms/chapter.sgml
SRCS+= staff/chapter.sgml
#SRCS+= users/chapter.sgml
SRCS+= x11/chapter.sgml

# Entities
SRCS+= ../../../en_US.ISO_8859-1/books/handbook/authors.ent 
SRCS+= chapters.ent 
SRCS+= mailing-lists.ent
SRCS+= newsgroups.ent
SRCS+= ruauthors.ent

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

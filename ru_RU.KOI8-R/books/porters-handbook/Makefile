#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/porters-handbook/Makefile,v 1.7 2003/09/26 02:34:16 andy Exp $
#
# Original reivision: 1.4
#

#
# Build the FreeBSD Porter's Handbook.
#

MAINTAINER=pluknet@FreeBSD.org

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

#
# SRCS lists the individual XML files that make up the document. Changes
# to any of these files will force a rebuild
#

# XML content
SRCS=  book.xml

# Entities
#SRCS+= ../../../en_US.ISO8859-1/books/handbook/authors.ent

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# 
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/porters-handbook/Makefile,v 1.6 2001/12/18 14:12:23 phantom Exp $
# Original reivision: 1.1
#
# Build the FreeBSD Porter's Handbook.
#

MAINTAINER=andy@FreeBSD.org.ua

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
#SRCS+= ../../../en_US.ISO8859-1/books/handbook/authors.ent

# Use the local DSSSL file
DSLHTML?= 	${.CURDIR}/freebsd.dsl
DSLPRINT?= 	${.CURDIR}/freebsd.dsl

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# 
# $FreeBSD: doc/en_US.ISO_8859-1/books/fdp-primer/Makefile,v 1.7 1999/09/06 06:52:39 peter Exp $
#
# Build the FreeBSD Documentation Project Primer.
#

MAINTAINER=nik@FreeBSD.org

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml 
SRCS+= overview/chapter.sgml 
SRCS+= psgml-mode/chapter.sgml 
SRCS+= see-also/chapter.sgml 
SRCS+= sgml-markup/chapter.sgml 
SRCS+= sgml-primer/chapter.sgml 
SRCS+= stylesheets/chapter.sgml 
SRCS+= structure/chapter.sgml
SRCS+= doc-build/chapter.sgml
SRCS+= the-website/chapter.sgml 
SRCS+= tools/chapter.sgml 
SRCS+= translations/chapter.sgml
SRCS+= writing-style/chapter.sgml 

# Entities
SRCS+= chapters.ent 

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

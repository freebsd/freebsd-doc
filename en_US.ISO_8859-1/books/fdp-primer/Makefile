# 
# $Id: Makefile,v 1.4 1999-08-28 19:49:38 jhb Exp $
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
SRCS+= the-faq/chapter.sgml 
SRCS+= the-handbook/chapter.sgml 
SRCS+= the-website/chapter.sgml 
SRCS+= tools/chapter.sgml 
SRCS+= translations/chapter.sgml
SRCS+= writing-style/chapter.sgml 

# Entities
SRCS+= chapters.ent 

DOC_PREFIX?= ../../..

.include "../../../share/mk/docproj.docbook.mk"

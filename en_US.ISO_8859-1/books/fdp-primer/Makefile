# 
# $FreeBSD: doc/en_US.ISO_8859-1/books/fdp-primer/Makefile,v 1.8 2000/06/23 00:37:53 nik Exp $
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

SRCS+= examples/appendix.sgml

# Images from the cross-document image library
LIB_IMAGES=	callouts/1.png
LIB_IMAGES+=	callouts/2.png
LIB_IMAGES+=	callouts/3.png
LIB_IMAGES+=	callouts/4.png
LIB_IMAGES+=	callouts/5.png

# Entities
SRCS+= chapters.ent 

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

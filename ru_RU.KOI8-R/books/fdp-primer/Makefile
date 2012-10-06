#
# The Russian FreeBSD Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/fdp-primer/Makefile,v 1.7 2004/11/22 16:00:40 den Exp $
#
# Original revision: r21373
#
# Build the FreeBSD Documentation Project Primer.
#

MAINTAINER=frdp@FreeBSD.org.ua

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

#
# SRCS lists the individual XML files that make up the document. Changes
# to any of these files will force a rebuild
#

# XML content
SRCS=  book.xml
SRCS+= overview/chapter.xml
SRCS+= psgml-mode/chapter.xml
SRCS+= see-also/chapter.xml
SRCS+= sgml-markup/chapter.xml
SRCS+= sgml-primer/chapter.xml
SRCS+= stylesheets/chapter.xml
SRCS+= structure/chapter.xml
SRCS+= doc-build/chapter.xml
SRCS+= the-website/chapter.xml
SRCS+= tools/chapter.xml
SRCS+= translations/chapter.xml
SRCS+= writing-style/chapter.xml

SRCS+= examples/appendix.xml

# Images from the cross-document image library
#IMAGES_LIB=	callouts/1.png
#IMAGES_LIB+=	callouts/2.png
#IMAGES_LIB+=	callouts/3.png
#IMAGES_LIB+=	callouts/4.png
#IMAGES_LIB+=	callouts/5.png

# Entities
SRCS+= chapters.ent

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

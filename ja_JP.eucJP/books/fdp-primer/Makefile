# 
# $FreeBSD$
#
# Build the FreeBSD Documentation Project Primer (Japanese).
#
# Original revision: 1.10
#

MAINTAINER=

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

NO_TIDY=	YES

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
#IMAGES_LIB=    callouts/1.png
#IMAGES_LIB+=   callouts/2.png
#IMAGES_LIB+=   callouts/3.png
#IMAGES_LIB+=   callouts/4.png
#IMAGES_LIB+=   callouts/5.png

# Entities
SRCS+= chapters.ent 

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

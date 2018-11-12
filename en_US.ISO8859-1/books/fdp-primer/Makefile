#
# $FreeBSD$
#
# Build the FreeBSD Documentation Project Primer.
#

MAINTAINER=doc@FreeBSD.org

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
SRCS+= tools/chapter.xml
SRCS+= working-copy/chapter.xml
SRCS+= structure/chapter.xml
SRCS+= doc-build/chapter.xml
SRCS+= the-website/chapter.xml
SRCS+= xml-primer/chapter.xml
SRCS+= xhtml-markup/chapter.xml
SRCS+= docbook-markup/chapter.xml
SRCS+= stylesheets/chapter.xml
SRCS+= translations/chapter.xml
SRCS+= po-translations/chapter.xml
SRCS+= manpages/chapter.xml
SRCS+= writing-style/chapter.xml
SRCS+= editor-config/chapter.xml
SRCS+= see-also/chapter.xml

SRCS+= examples/appendix.xml

# Images from the cross-document image library
IMAGES_LIB=	callouts/1.png
IMAGES_LIB+=	callouts/2.png
IMAGES_LIB+=	callouts/3.png
IMAGES_LIB+=	callouts/4.png
IMAGES_LIB+=	callouts/5.png
IMAGES_LIB+=	callouts/6.png
IMAGES_LIB+=	callouts/7.png
IMAGES_LIB+=	callouts/8.png
IMAGES_LIB+=	callouts/9.png

# Entities
SRCS+= chapters.ent

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

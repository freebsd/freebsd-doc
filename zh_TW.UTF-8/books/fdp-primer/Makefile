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

# Images from the cross-document image library
IMAGES_LIB=	callouts/1.png
IMAGES_LIB+=	callouts/2.png
IMAGES_LIB+=	callouts/3.png
IMAGES_LIB+=	callouts/4.png
IMAGES_LIB+=	callouts/5.png

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

# Fixme!
DOCBOOK_DEPS_DISABLE=YES

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

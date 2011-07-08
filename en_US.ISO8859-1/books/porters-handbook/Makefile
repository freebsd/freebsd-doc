# 
# $FreeBSD$
#
# Build the FreeBSD Porter's Handbook.
#

MAINTAINER=doc@FreeBSD.org

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

# Use the local DSSSL file
DSLHTML?= 	${.CURDIR}/freebsd.dsl
DSLPRINT?= 	${.CURDIR}/freebsd.dsl

# Images from the cross-document image library
IMAGES_LIB+=	callouts/1.png
IMAGES_LIB+=	callouts/2.png
IMAGES_LIB+=	callouts/3.png
IMAGES_LIB+=	callouts/4.png
IMAGES_LIB+=	callouts/5.png
IMAGES_LIB+=	callouts/6.png
IMAGES_LIB+=	callouts/7.png
IMAGES_LIB+=	callouts/8.png
IMAGES_LIB+=	callouts/9.png
IMAGES_LIB+=	callouts/10.png
IMAGES_LIB+=	callouts/11.png
IMAGES_LIB+=	callouts/12.png
IMAGES_LIB+=	callouts/13.png
IMAGES_LIB+=	callouts/14.png
IMAGES_LIB+=	callouts/15.png

URL_RELPREFIX?=	../../../..
DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

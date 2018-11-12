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
# SRCS lists the individual XML files that make up the document. Changes
# to any of these files will force a rebuild
#

# XML content
SRCS=  book.xml
SRCS+= porting-why/chapter.xml
SRCS+= new-port/chapter.xml
SRCS+= quick-porting/chapter.xml
SRCS+= slow-porting/chapter.xml
SRCS+= makefiles/chapter.xml
SRCS+= flavors/chapter.xml
SRCS+= special/chapter.xml
SRCS+= plist/chapter.xml
SRCS+= pkg-files/chapter.xml
SRCS+= testing/chapter.xml
SRCS+= upgrading/chapter.xml
SRCS+= security/chapter.xml
SRCS+= porting-dads/chapter.xml
SRCS+= porting-samplem/chapter.xml
SRCS+= order/chapter.xml
SRCS+= keeping-up/chapter.xml
SRCS+= uses/chapter.xml
SRCS+= versions/chapter.xml

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
IMAGES_LIB+=	callouts/16.png
IMAGES_LIB+=	callouts/17.png
IMAGES_LIB+=	callouts/18.png
IMAGES_LIB+=	callouts/19.png
IMAGES_LIB+=	callouts/20.png
IMAGES_LIB+=	callouts/21.png

URL_RELPREFIX?=	../../../..
DOC_PREFIX?= ${.CURDIR}/../../..

# Entities
SRCS+= chapters.ent

SYMLINKS=       ${DESTDIR} index.html handbook.html

# Turn on all the chapters.
CHAPTERS?= ${SRCS:M*chapter.xml}

XMLFLAGS+= ${CHAPTERS:S/\/chapter.xml//:S/^/-i chap./}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

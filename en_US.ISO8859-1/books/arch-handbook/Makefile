#
# $FreeBSD$
#
# Build the FreeBSD Architecture Handbook.
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
SRCS+= boot/chapter.xml
SRCS+= driverbasics/chapter.xml
SRCS+= isa/chapter.xml
SRCS+= jail/chapter.xml
SRCS+= kobj/chapter.xml
SRCS+= locking/chapter.xml
SRCS+= mac/chapter.xml
SRCS+= newbus/chapter.xml
SRCS+= pci/chapter.xml
SRCS+= scsi/chapter.xml
SRCS+= smp/chapter.xml
SRCS+= sound/chapter.xml
SRCS+= pccard/chapter.xml
SRCS+= sysinit/chapter.xml
SRCS+= usb/chapter.xml
SRCS+= vm/chapter.xml

# Images from the cross-document image library
IMAGES_LIB=  callouts/1.png
IMAGES_LIB+= callouts/2.png
IMAGES_LIB+= callouts/3.png
IMAGES_LIB+= callouts/4.png
IMAGES_LIB+= callouts/5.png
IMAGES_LIB+= callouts/6.png
IMAGES_LIB+= callouts/7.png
IMAGES_LIB+= callouts/8.png
IMAGES_LIB+= callouts/9.png
IMAGES_LIB+= callouts/10.png

# Entities

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

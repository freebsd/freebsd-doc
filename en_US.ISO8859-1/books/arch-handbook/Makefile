# 
# $FreeBSD$
#
# Build the FreeBSD Architecture Handbook.
#

MAINTAINER=doc@FreeBSD.org

DOC?= book

FORMATS?= html-split

#HAS_INDEX= true

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml
SRCS+= boot/chapter.sgml
SRCS+= driverbasics/chapter.sgml
SRCS+= isa/chapter.sgml
SRCS+= jail/chapter.sgml
SRCS+= kobj/chapter.sgml
SRCS+= locking/chapter.sgml
SRCS+= mac/chapter.sgml
SRCS+= newbus/chapter.sgml
SRCS+= pci/chapter.sgml
SRCS+= scsi/chapter.sgml
SRCS+= smp/chapter.sgml
SRCS+= sound/chapter.sgml
SRCS+= pccard/chapter.sgml
SRCS+= sysinit/chapter.sgml
SRCS+= usb/chapter.sgml
SRCS+= vm/chapter.sgml

# Entities

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

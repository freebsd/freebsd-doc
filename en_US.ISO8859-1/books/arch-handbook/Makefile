# 
# $FreeBSD$
#
# Build the FreeBSD Developers' Handbook.
#

MAINTAINER=murray@FreeBSD.org

DOC?= book

FORMATS?= html-split

HAS_INDEX= true

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# Images
IMAGES_EN= sockets/layers.eps sockets/sain.eps sockets/sainfill.eps sockets/sainlsb.eps sockets/sainmsb.eps sockets/sainserv.eps sockets/serv.eps sockets/serv2.eps sockets/slayers.eps

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml
SRCS+= boot/chapter.sgml
SRCS+= dma/chapter.sgml
SRCS+= driverbasics/chapter.sgml
SRCS+= introduction/chapter.sgml
SRCS+= ipv6/chapter.sgml
SRCS+= isa/chapter.sgml
SRCS+= jail/chapter.sgml
SRCS+= kerneldebug/chapter.sgml
SRCS+= kobj/chapter.sgml
SRCS+= l10n/chapter.sgml
SRCS+= locking/chapter.sgml
SRCS+= mac/chapter.sgml
SRCS+= pci/chapter.sgml
SRCS+= policies/chapter.sgml
SRCS+= scsi/chapter.sgml
SRCS+= secure/chapter.sgml
SRCS+= sockets/chapter.sgml
SRCS+= sound/chapter.sgml
SRCS+= sysinit/chapter.sgml
SRCS+= tools/chapter.sgml
SRCS+= usb/chapter.sgml
SRCS+= vm/chapter.sgml
SRCS+= x86/chapter.sgml

# Entities

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

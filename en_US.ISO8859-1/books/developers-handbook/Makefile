# 
# $FreeBSD$
#
# Build the FreeBSD Developers' Handbook.
#

MAINTAINER=doc@FreeBSD.org

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
SRCS+= dma/chapter.sgml
SRCS+= introduction/chapter.sgml
SRCS+= ipv6/chapter.sgml
SRCS+= kerneldebug/chapter.sgml
SRCS+= l10n/chapter.sgml
SRCS+= policies/chapter.sgml
SRCS+= secure/chapter.sgml
SRCS+= sockets/chapter.sgml
SRCS+= testing/chapter.sgml
SRCS+= tools/chapter.sgml
SRCS+= x86/chapter.sgml

# Entities

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

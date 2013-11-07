# The FreeBSD Documentation Project
# The FreeBSD German Documentation Project
#
# $FreeBSD$
# $FreeBSDde: de-docproj/books/developers-handbook/Makefile,v 1.3 2009/02/21 19:12:23 jkois Exp $
# basiert auf: 1.24
#
# Build the FreeBSD Developers' Handbook.
#

MAINTAINER=doc@FreeBSD.org

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# Images
IMAGES_EN= sockets/layers.eps sockets/sain.eps sockets/sainfill.eps sockets/sainlsb.eps sockets/sainmsb.eps sockets/sainserv.eps sockets/serv.eps sockets/serv2.eps sockets/slayers.eps

#
# SRCS lists the individual XML files that make up the document. Changes
# to any of these files will force a rebuild
#

# XML content
SRCS=  book.xml
SRCS+= introduction/chapter.xml
SRCS+= ipv6/chapter.xml
SRCS+= kernelbuild/chapter.xml
SRCS+= kerneldebug/chapter.xml
SRCS+= l10n/chapter.xml
SRCS+= policies/chapter.xml
SRCS+= secure/chapter.xml
SRCS+= sockets/chapter.xml
SRCS+= testing/chapter.xml
SRCS+= tools/chapter.xml
SRCS+= x86/chapter.xml

# Entities

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

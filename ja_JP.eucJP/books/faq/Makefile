# 
# $Id: Makefile,v 1.2 1999-08-23 15:33:55 kuriyama Exp $
#
# Build the FreeBSD FAQ
#

MAINTAINER=kuriyama@FreeBSD.ORG

JADEOPTS=	-ilang.ja
TIDYFLAGS=	-raw

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml 

DOC_PREFIX?= ../../..

.include "../../../share/mk/docproj.docbook.mk"

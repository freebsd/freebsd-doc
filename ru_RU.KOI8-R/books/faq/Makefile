# 
# $Id: Makefile,v 1.1 1999-08-29 16:51:17 nik Exp $
#
# Build the FreeBSD FAQ
#

MAINTAINER=nik@FreeBSD.ORG

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

.include "${DOC_PREFIX}/share/mk/docproj.docbook.mk"

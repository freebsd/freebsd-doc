# 
# $Id: Makefile,v 1.6 1999-09-03 17:44:11 nik Exp $
#
# Build the FreeBSD FAQ
#
# Original revision: 1.3
#

MAINTAINER=kuriyama@FreeBSD.ORG

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

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# 
# $Id: Makefile,v 1.2 1999-08-25 05:29:44 foxfair Exp $
#
# Build the FreeBSD Chinese-Big5 FAQ
#

MAINTAINER=foxfair@FreeBSD.org

TIDYFLAGS=      -raw

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

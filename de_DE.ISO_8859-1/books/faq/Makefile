#
#    The FreeBSD Documentation Project
#    The FreeBSD German Documentation Project
#
#    Build the FreeBSD FAQ in the German translation
#
#    $FreeBSD$
#    $FreeBSDde: de-docproj/books/faq/Makefile,v 1.4 2001/02/01 21:24:28 alex Exp $
#

MAINTAINER=de-bsd-translators@DE.FreeBSD.org

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

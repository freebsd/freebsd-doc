#
#    The FreeBSD Documentation Project
#    The FreeBSD German Documentation Project
#
#    Build the FreeBSD FAQ in the German translation
#
#    $FreeBSD: doc/de_DE.ISO_8859-1/books/faq/Makefile,v 1.1 2001/02/01 21:29:56 alex Exp $
#    $FreeBSDde: de-docproj/books/faq/Makefile,v 1.5 2001/05/20 22:15:47 ue Exp $
#

MAINTAINER=de-bsd-translators@DE.FreeBSD.org

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

JADEFLAGS+=-Vbiblio-xref-title

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml 

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

#
#    The FreeBSD Documentation Project
#    The FreeBSD German Documentation Project
#
#    Build the FreeBSD FAQ in the German translation
#
#    $FreeBSD$
#    $FreeBSDde: de-docproj/books/faq/Makefile,v 1.9 2003/04/23 22:36:36 mheinen Exp $
#    basiert auf: 1.10
#

MAINTAINER=de-bsd-translators@DE.FreeBSD.org

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

WITH_BIBLIOXREF_TITLE?=YES
#
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

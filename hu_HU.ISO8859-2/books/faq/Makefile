# 
# $FreeBSD$
# %SOURCE%    en_US.ISO8859-1/books/faq/Makefile
# %SRCID%     1.12
#
# Build the FreeBSD FAQ
#

MAINTAINER=doc@FreeBSD.org

NO_TIDY = yes

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

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# 
# $FreeBSD: doc/en_US.ISO_8859-1/articles/committers-guide/Makefile,v 1.3 1999/09/06 06:52:35 peter Exp $
#

MAINTAINER=grog@FreeBSD.org

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  article.sgml

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

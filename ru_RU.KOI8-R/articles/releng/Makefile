# Article: FreeBSD Release Engineering
#
# The FreeBSD Russian Documentation Project
# 
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/articles/releng/Makefile,v 1.1 2004/02/21 05:38:41 andy Exp $
#
# Original revision: 1.11
#

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

WITH_ARTICLE_TOC?=YES

# SGML content
EXTRA_SRCS= branches.ascii

CLEANFILES+= ${EXTRA_SRCS}

SRCS= article.sgml ${EXTRA_SRCS}

${EXTRA_SRCS}:
	${CP} ${DOC_PREFIX}/en_US.ISO8859-1/articles/releng/${.TARGET} ${.OBJDIR}/

# IMAGES
IMAGES_EN= branches.pic

CSS_SHEET_ADDITIONS= extra.css

DOC_PREFIX?= ${.CURDIR}/../../..

afterinstall:
	${INSTALL_DOCS} ${EXTRA_SRCS} ${DESTDIR}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

#
# $FreeBSD$
# $FreeBSDes: doc/es_ES.ISO8859-1/articles/releng/Makefile,v 1.1 2004/10/15 01:30:12 carvay Exp $
# Version: 1.14
#
# Article: FreeBSD Release Engineering

DOC?= article

FORMATS?= html
WITH_ARTICLE_TOC?= YES

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

SRCS=		article.xml
IMAGES_EN=	branches-head.pic
IMAGES_EN+=	branches-releng3.pic
IMAGES_EN+=	branches-releng4.pic

CSS_SHEET_ADDITIONS= extra.css

URL_RELPREFIX?=	../../../..
DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

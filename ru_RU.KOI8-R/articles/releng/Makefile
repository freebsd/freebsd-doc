# Article: FreeBSD Release Engineering
#
# The FreeBSD Russian Documentation Project
# 
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/articles/releng/Makefile,v 1.3 2004/08/10 09:02:08 den Exp $
#
# Original revision: 1.14
#

DOC?= article

FORMATS?= html
WITH_ARTICLE_TOC?=YES

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

SRCS=		article.sgml
IMAGES_EN=	branches-head.pic
IMAGES_EN+=	branches-releng3.pic
IMAGES_EN+=	branches-releng4.pic

CSS_SHEET_ADDITIONS= extra.css

URL_RELPREFIX?=	../../../..
DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

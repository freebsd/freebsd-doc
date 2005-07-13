# Article: FreeBSD Release Engineering
#
# The FreeBSD Russian Documentation Project
# 
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/articles/releng/Makefile,v 1.4 2005/07/01 06:51:22 gad Exp $
#
# Original revision: 1.15
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
IMAGES_EN+=	branches-releng5.pic

CSS_SHEET_ADDITIONS= extra.css

URL_RELPREFIX?=	../../../..
DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

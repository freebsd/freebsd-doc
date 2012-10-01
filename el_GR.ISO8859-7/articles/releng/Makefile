# $FreeBSD$
#
# %SOURCE%	en_US.ISO8859-1/articles/releng/Makefile
# %SRCID%	1.18

DOC?= article

FORMATS?= html
WITH_ARTICLE_TOC?= YES

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

SRCS=		article.xml
IMAGES_EN=      branches-head.pic
IMAGES_EN+=     branches-releng3.pic
IMAGES_EN+=     branches-releng4.pic
IMAGES_EN+=     branches-releng5.pic
IMAGES_EN+=     branches-releng6.pic

CSS_SHEET_ADDITIONS= extra.css

URL_RELPREFIX?= ../../../..
DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

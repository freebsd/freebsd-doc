# 
# $FreeBSD$
#
# Article: FreeBSD Quickstart for Linux Users
#
# %SOURCE%    en_US.ISO8859-1/articles/linux-users/Makefile
# %SRCID%     1.1
#

#
# Tidy messes up iso-8859-2 characters
#

NO_TIDY = yes

MAINTAINER = doc@FreeBSD.org

DOC?= article

FORMATS?= html
WITH_ARTICLE_TOC?= YES

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

SRCS=	article.sgml

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

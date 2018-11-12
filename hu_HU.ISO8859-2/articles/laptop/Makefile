# $FreeBSD$
#
# Article: FreeBSD on Laptops
#
# %SOURCE%    en_US.ISO8859-1/articles/laptop/Makefile
# %SRCID%     1.4
#

#
# Tidy messes up iso-8859-2 characters
#

NO_TIDY= yes

MAINTAINER= doc@FreeBSD.org

DOC?= article

FORMATS?= html
INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

SRCS=	article.sgml

URL_RELPREFIX?=	../../../..
DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

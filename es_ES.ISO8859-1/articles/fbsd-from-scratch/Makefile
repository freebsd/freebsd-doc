#
# $FreeBSD$
#
# Article: FreeBSD From Scratch

DOC?= article

FORMATS?= html

MAINTAINER= schweikh@FreeBSD.org

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# 
#WITH_ARTICLE_TOC?=YES

# SGML content
SRCS= article.sgml fase_1.sh fase_2.sh fase_3.mk

DOC_PREFIX?= ${.CURDIR}/../../..

afterinstall:
	${INSTALL_DOCS} ${.CURDIR}/fase_1.sh ${.CURDIR}/fase_2.sh \
	    ${.CURDIR}/fase_3.mk ${DESTDIR}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

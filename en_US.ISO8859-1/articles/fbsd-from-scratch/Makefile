#
# $FreeBSD$
#
# Article: FreeBSD From Scratch

DOC?= article

FORMATS?= html

MAINTAINER= schweikh@FreeBSD.org

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

WITH_DOCFORMAT_NAVI_LINK?=YES

# SGML content
SRCS= article.sgml stage_1.sh stage_2.sh stage_3.mk

DOC_PREFIX?= ${.CURDIR}/../../..

afterinstall:
	${INSTALL_DOCS} ${.CURDIR}/stage_1.sh ${.CURDIR}/stage_2.sh \
	    ${.CURDIR}/stage_3.mk ${DESTDIR}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

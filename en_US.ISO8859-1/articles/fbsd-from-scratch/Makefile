#
# $FreeBSD$
#
# Article: FreeBSD From Scratch

DOC?= article

FORMATS?= html

MAINTAINER= schweikh@FreeBSD.org

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# SGML content
SRCS= article.sgml stage_1.sh stage_2.sh stage_3.mk

DOC_PREFIX?= ${.CURDIR}/../../..

afterinstall:
	${INSTALL_DOCS} stage_1.sh stage_2.sh stage_3.mk ${DESTDIR}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

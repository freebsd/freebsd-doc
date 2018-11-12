#
# $FreeBSD$
#
# Article: FreeBSD From Scratch

DOC?= article

FORMATS?= html

MAINTAINER= schweikh@FreeBSD.org

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

EXTRAS=		stage_1.conf.default
EXTRAS+=	stage_1.sh
EXTRAS+=	stage_2.conf.default
EXTRAS+=	stage_2.sh
EXTRAS+=	stage_3.mk

SRCS=		article.sgml
SRCS+=		${EXTRAS}

afterinstall:
.for entry in ${EXTRAS}
	${INSTALL_DOCS} ${.CURDIR}/${entry} ${DESTDIR}
.endfor

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

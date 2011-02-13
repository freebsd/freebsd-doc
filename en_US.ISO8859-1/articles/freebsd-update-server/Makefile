# $FreeBSD$
#
# Article: FreeBSD Update Server

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

WITH_ARTICLE_TOC?=YES

EXTRAS=		init.txt
EXTRAS+=	diff.txt

SRCS=		article.sgml
SRCS+=		${EXTRAS}

afterinstall:
.for entry in ${EXTRAS}
	${INSTALL_DOCS} ${.CURDIR}/${entry} ${DESTDIR}
.endfor

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

#
# The FreeBSD Documentation Project
# The FreeBSD Brazilian Portuguese Documentation Project
#
# $FreeBSD$
#
# Original revision: r38826
#
# Article: FreeBSD Update Server

DOC?= article

FORMATS?= html html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

WITH_ARTICLE_TOC?=YES

EXTRAS=		init.txt
EXTRAS+=	diff.txt

SRCS=		article.xml
SRCS+=		${EXTRAS}

IMAGES_LIB=	callouts/1.png
IMAGES_LIB+=	callouts/2.png
IMAGES_LIB+=	callouts/3.png
IMAGES_LIB+=	callouts/4.png
IMAGES_LIB+=	callouts/5.png

afterinstall:
.for entry in ${EXTRAS}
	${INSTALL_DOCS} ${.CURDIR}/${entry} ${DESTDIR}
.endfor

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

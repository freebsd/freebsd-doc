#
# $FreeBSD$
#
# Article: Contributors to FreeBSD

DOC?= article

FORMATS?= html
WITH_ARTICLE_TOC?= YES

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

SRCS=	article.sgml
SRCS+=	contrib.ent
SRCS+=	contrib.386bsd.sgml
SRCS+=	contrib.additional.sgml
SRCS+=	contrib.committers.sgml
SRCS+=	contrib.core.sgml
SRCS+=	contrib.corealumni.sgml
SRCS+=	contrib.develalumni.sgml

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

#
# $FreeBSD$
#
# Article: Contributors to FreeBSD

DOC?= article

FORMATS?= html
WITH_ARTICLE_TOC?= YES

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

SRCS=	article.xml
SRCS+=	contrib.ent
SRCS+=	contrib.386bsd.xml
SRCS+=	contrib.additional.xml
SRCS+=	contrib.committers.xml
SRCS+=	contrib.corealumni.xml
SRCS+=	contrib.develalumni.xml
SRCS+=	contrib.develinmemoriam.xml
SRCS+=	contrib.portmgralumni.xml

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

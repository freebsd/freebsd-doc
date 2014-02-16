#
# $FreeBSD$
#
# Article: Contributors to FreeBSD
#
# Original revision: r39631

DOC?= article

FORMATS?= html
WITH_ARTICLE_TOC?= YES

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

ORGDIR=	${DOC_PREFIX}/en_US.ISO8859-1/articles/contributors

SRCS=	article.xml
SRCS+=	${ORGDIR}/contrib.ent
SRCS+=	${ORGDIR}/contrib.386bsd.xml
SRCS+=	${ORGDIR}/contrib.additional.xml
SRCS+=	${ORGDIR}/contrib.committers.xml
SRCS+=	${ORGDIR}/contrib.corealumni.xml
SRCS+=	${ORGDIR}/contrib.develalumni.xml
SRCS+=	${ORGDIR}/contrib.develinmemoriam.xml
SRCS+=	${ORGDIR}/contrib.portmgralumni.xml

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

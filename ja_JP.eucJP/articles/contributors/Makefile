# $FreeBSD$
# Original revision: 1.4

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

WITH_ARTICLE_TOC?=YES

ORGDIR=${DOC_PREFIX}/en_US.ISO8859-1/articles/contributors

SRCS= article.sgml
SRCS+=${ORGDIR}/contrib.386bsd.sgml
SRCS+=${ORGDIR}/contrib.additional.sgml
SRCS+=${ORGDIR}/contrib.committers.sgml
SRCS+=${ORGDIR}/contrib.core.sgml
SRCS+=${ORGDIR}/contrib.corealumni.sgml
SRCS+=${ORGDIR}/contrib.develalumni.sgml

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

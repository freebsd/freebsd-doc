#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/articles/fbsd-from-scratch/Makefile,v 1.1 2004/02/01 17:20:25 andy Exp $
#
# Article: FreeBSD From Scratch
#
# Original revision: 1.5
#

DOC?= article

FORMATS?= html

MAINTAINER= schweikh@FreeBSD.org

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

# SGML content
SRCS= article.sgml \
	${DOC_PREFIX}/en_US.ISO8859-1/articles/fbsd-from-scratch/stage_1.conf.default \
	${DOC_PREFIX}/en_US.ISO8859-1/articles/fbsd-from-scratch/stage_1.sh \
	${DOC_PREFIX}/en_US.ISO8859-1/articles/fbsd-from-scratch/stage_2.conf.default \
	${DOC_PREFIX}/en_US.ISO8859-1/articles/fbsd-from-scratch/stage_2.sh \
	${DOC_PREFIX}/en_US.ISO8859-1/articles/fbsd-from-scratch/stage_3.mk

DOC_PREFIX?= ${.CURDIR}/../../..

afterinstall:
	${INSTALL_DOCS} \
	${DOC_PREFIX}/en_US.ISO8859-1/articles/fbsd-from-scratch/stage_1.sh \
	${DOC_PREFIX}/en_US.ISO8859-1/articles/fbsd-from-scratch/stage_1.conf.default \
	${DOC_PREFIX}/en_US.ISO8859-1/articles/fbsd-from-scratch/stage_2.sh \
	${DOC_PREFIX}/en_US.ISO8859-1/articles/fbsd-from-scratch/stage_2.conf.default \
	${DOC_PREFIX}/en_US.ISO8859-1/articles/fbsd-from-scratch/stage_3.mk \
	${DESTDIR}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

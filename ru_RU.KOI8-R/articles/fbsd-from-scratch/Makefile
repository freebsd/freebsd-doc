#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/articles/fbsd-from-scratch/Makefile,v 1.2 2004/02/20 17:57:24 phantom Exp $
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
EXTRA_SRCS= stage_1.sh stage_1.conf.default \
	stage_2.sh stage_2.conf.default stage_3.mk

CLEANFILES+= ${EXTRA_SRCS}

SRCS= article.sgml ${EXTRA_SRCS}

${EXTRA_SRCS}:
	${CP} ${DOC_PREFIX}/en_US.ISO8859-1/articles/fbsd-from-scratch/${.TARGET} ${.OBJDIR}/

DOC_PREFIX?= ${.CURDIR}/../../..

afterinstall:
	${INSTALL_DOCS} ${EXTRA_SRCS} ${DESTDIR}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

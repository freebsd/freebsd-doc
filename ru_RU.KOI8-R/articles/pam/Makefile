#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/articles/pam/Makefile,v 1.3 2003/12/28 08:03:56 andy Exp $
#
# Original revision: r16655
#

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

WITH_ARTICLE_TOC?=YES
WITH_INLINE_LEGALNOTICE?=YES

SRCS= article.xml

EXTRAS=pam_app.c pam_conv.c pam_module.c
CLEANFILES+= ${EXTRAS}

index.html article.html: ${EXTRAS}

DOC_PREFIX?= ${.CURDIR}/../../..

pam_app.c: ${DOC_PREFIX}/en_US.ISO8859-1/articles/pam/su.c
	sed -e '/^[\/ ]\*/d' ${.ALLSRC} >${.TARGET}

pam_conv.c: ${DOC_PREFIX}/en_US.ISO8859-1/articles/pam/converse.c
	sed -e '/^[\/ ]\*/d' ${.ALLSRC} >${.TARGET}

pam_module.c: ${DOC_PREFIX}/en_US.ISO8859-1/articles/pam/pam_unix.c
	sed -e '/^[\/ ]\*/d' ${.ALLSRC} >${.TARGET}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

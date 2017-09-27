# $FreeBSD$

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

pam_app.c: su.c
	sed -e '/^[\/ ]\*/d' ${.ALLSRC} >${.TARGET}

pam_conv.c: converse.c
	sed -e '/^[\/ ]\*/d' ${.ALLSRC} >${.TARGET}

pam_module.c: pam_unix.c
	sed -e '/^[\/ ]\*/d' ${.ALLSRC} >${.TARGET}

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

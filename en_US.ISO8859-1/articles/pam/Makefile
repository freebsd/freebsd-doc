# $FreeBSD$

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

JADEFLAGS+=	-V %generate-article-toc%

SRCS= article.sgml pam_app.c pam_module.c

CLEANFILES+= pam_app.c pam_module.c

pam_app.c: su.c
	sed -e '/^[\/ ]\*/d' ${.ALLSRC} >${.TARGET}

pam_module.c: pam_unix.c
	sed -e '/^[\/ ]\*/d' ${.ALLSRC} >${.TARGET}

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

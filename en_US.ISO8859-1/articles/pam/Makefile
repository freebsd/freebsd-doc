# $FreeBSD$

DOC?= article

FORMATS?= html

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

JADEFLAGS+=	-V %generate-article-toc%

SRCS= article.sgml pam_app.c

CLEANFILES+= pam_app.c

pam_app.c: su.c
	perl -ne 'print unless m|^[/ ]\*|' su.c >${.TARGET}

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

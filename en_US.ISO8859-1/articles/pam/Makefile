#
# $FreeBSD$
#
# Article: Pluggable Authentication Modules

DOC?= article

FORMATS?= html
WITH_ARTICLE_TOC?= YES
WITH_INLINE_LEGALNOTICE?= YES

INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

EXTRAS=		pam_app.c
EXTRAS+=	pam_conv.c
EXTRAS+=	pam_module.c
CLEANFILES+=	${EXTRAS}

SRCS=	article.sgml
SRCS+=	${EXTRAS}

pam_app.c: su.c
	sed -e '/^[\/ ]\*/d' ${.ALLSRC} >${.TARGET}

pam_conv.c: converse.c
	sed -e '/^[\/ ]\*/d' ${.ALLSRC} >${.TARGET}

pam_module.c: pam_unix.c
	sed -e '/^[\/ ]\*/d' ${.ALLSRC} >${.TARGET}

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# $FreeBSD$

DOC_PREFIX?=	${.CURDIR}/../../../../..
RELN_ROOT?=	${.CURDIR}/../../../relnotes

.if exists(${RELN_ROOT}/Makefile.inc)
.include "${RELN_ROOT}/Makefile.inc"
.endif
.if exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif

FORMATS?=	html
INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

JADEFLAGS+=	-V %generate-article-toc%

DOC=		article
SRCS+=		article.xml
SRCS+=		${DEV-AUTODIR}/catalog-auto
SRCS+=		${DEV-AUTODIR}/dev-auto.ent

CATALOGS+=	-c ${DEV-AUTODIR}/catalog-auto

URL_RELPREFIX?=	../../../..

HWNOTES_MI=	1

.include "${RELN_ROOT}/share/mk/doc.relnotes.mk"
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

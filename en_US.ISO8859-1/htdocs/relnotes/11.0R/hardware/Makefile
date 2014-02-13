# $FreeBSD$

DOC_PREFIX?=	${.CURDIR}/../../../../..
RELN_ROOT?=	${.CURDIR}/../..

DOC=		hardware

.ifdef NO_LANGCODE_IN_DESTDIR
DESTDIR?=	${DOCDIR}/${DOC}
.else
DESTDIR?=	${DOCDIR}/en_US.ISO8859-1/${DOC}
.endif

FORMATS?=	html
INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

JADEFLAGS+=	-V %generate-article-toc%

# SGML content
SRCS+=		${DOC}.xml
SRCS+=		${DEV-AUTODIR}/catalog-auto
SRCS+=		${DEV-AUTODIR}/dev-auto.ent

CATALOGS+=	-c ${DEV-AUTODIR}/catalog-auto

URL_RELPREFIX?=	../../../..

HWNOTES_MI=	1

.include "${RELN_ROOT}/share/mk/doc.relnotes.mk"
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# $FreeBSD$

DOC_PREFIX?=	${.CURDIR}/../../../../..
RELN_ROOT?=	${.CURDIR}/../../../relnotes

DOC=		relnotes

.if exists(${RELN_ROOT}/Makefile.inc)
.include "${RELN_ROOT}/Makefile.inc"
.endif
.if exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif

DESTDIR?=	${DOCDIR}/relnotes/${BRANCH}/${DOC}

FORMATS?=	html
INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

# XML content
SRCS+=		${DOC}.xml

.include "${RELN_ROOT}/share/mk/doc.relnotes.mk"
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# $FreeBSD$

DOC_PREFIX?=	${.CURDIR}/../../../../..
RELN_ROOT?=	${.CURDIR}/../..

DOC=		readme

.ifdef NO_LANGCODE_IN_DESTDIR
DESTDIR?= ${DOCDIR}/${DOC}
.else
DESTDIR?= ${DOCDIR}/en_US.ISO8859-1/${DOC}
.endif

FORMATS?=	html
INSTALL_COMPRESSED?=gz
INSTALL_ONLY_COMPRESSED?=

# XML content
SRCS+=		${DOC}.xml

.include "${RELN_ROOT}/share/mk/doc.relnotes.mk"
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

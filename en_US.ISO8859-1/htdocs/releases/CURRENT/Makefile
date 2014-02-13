# $FreeBSD$

DOC_PREFIX?=	${.CURDIR}/../../../..
RELN_ROOT?=	${.CURDIR}/../../relnotes

.if exists(${RELN_ROOT}/Makefile.inc)
.include "${RELN_ROOT}/Makefile.inc"
.endif
.if exists(${.CURDIR}/Makefile.inc)
.include "${.CURDIR}/Makefile.inc"
.endif

MAN4DIR?=	${DOC_PREFIX}/../src/share/man/man4

SUBDIR=		errata \
		hardware \
		readme \
		relnotes

.include "${DOC_PREFIX}/share/mk/doc.subdir.mk"

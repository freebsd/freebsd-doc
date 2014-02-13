# $FreeBSD$

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

BRANCH?=	CURRENT
WEBBASE?=	/data/releases
DOC_PREFIX?=	${.CURDIR}/../../../..
RELN_ROOT?=	${.CURDIR}/../../relnotes

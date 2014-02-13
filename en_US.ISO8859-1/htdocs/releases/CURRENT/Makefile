# $FreeBSD$

DOC_PREFIX?=	${.CURDIR}/../../../..
RELN_ROOT?=	${.CURDIR}/../../relnotes

.if exists(${.CURDIR}/Makefile.inc)
.include "${.CURDIR}/Makefile.inc"
.endif

DOCS?=	errata.xml \
	readme.xml \
	relnotes.xml

#SUBDIR=	hardware

.include "${RELN_ROOT}/share/mk/doc.relnotes.mk"
.include "${DOC_PREFIX}/share/mk/web.site.mk"

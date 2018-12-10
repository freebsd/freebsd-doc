# $FreeBSD$

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOC=			relnotes
FORMATS?=		html txt
INSTALL_COMPRESSED?=	gz
INSTALL_ONLY_COMPRESSED=

XSLTPROCFLAGS+=		--param toc.section.depth "'3'"

.PHONY:			${DOC}.parsed.xml
.PHONY:			${DOC}.html

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

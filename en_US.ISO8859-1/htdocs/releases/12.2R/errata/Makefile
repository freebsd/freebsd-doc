# $FreeBSD$

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOC?=			errata
FORMATS?=		html txt
INSTALL_COMPRESSED?=	gz
INSTALL_ONLY_COMPRESSED=

.PHONY:			${DOC}.parsed.xml
.PHONY:			${DOC}.html

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

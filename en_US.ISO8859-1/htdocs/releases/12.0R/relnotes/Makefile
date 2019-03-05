# $FreeBSD$

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOC=			relnotes
FORMATS?=		html txt
INSTALL_COMPRESSED?=	gz
INSTALL_ONLY_COMPRESSED=

XSLTPROCFLAGS+=		--param toc.section.depth "'3'"
XSLXHTML=	http://www.FreeBSD.org/XML/share/xml/freebsd-xhtml-release.xsl

.PHONY:			${DOC}.parsed.xml
.PHONY:			${DOC}.html

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# $FreeBSD$

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOC=			relnotes
FORMATS?=		html txt
INSTALL_COMPRESSED?=	gz
INSTALL_ONLY_COMPRESSED=

RELEASEBRANCH!=		grep -o 'release.branch "\([^"]*\)"' \
			${.CURDIR}/../share/xml/release.ent | \
			sed 's|[^ ]* "\([^"]*\)"|\1|'
RELEASEMAILLIST!=	grep -o 'release.maillist "\([^"]*\)"' \
			${.CURDIR}/../share/xml/release.ent | \
			sed 's|[^ ]* "\([^"]*\)"|\1|'
RELEASEURL!=		grep -o 'release.url \"[^\"]*\"' \
			${.CURDIR}/../share/xml/release.ent | \
			sed 's|[^ ]* "\([^"]*\)"|\1|'

XSLTPROCFLAGS+=		--param toc.section.depth "'3'"
XSLTPROCFLAGS+=		--param release.branch "'${RELEASEBRANCH}'"
XSLTPROCFLAGS+=		--param release.maillist "'${RELEASEMAILLIST}'"
XSLTPROCFLAGS+=		--param release.url "'${RELEASEURL}'"
XSLXHTML=	http://www.FreeBSD.org/XML/share/xml/freebsd-xhtml-release.xsl

.PHONY:			${DOC}.parsed.xml
.PHONY:			${DOC}.html

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# $FreeBSD$
.if !defined(_HTDOCS_RELEASES_12_1R_INC)
_HTDOCS_RELEASES_12_1R_INC=1
DOC_PREFIX?=	${.CURDIR}/../../../../..
WEBDIR?=	/data/releases/12.1R
.if defined(DESTDIR)
DESTDIR:=	${DESTDIR}/${WEBDIR}
.else
DESTDIR=	${HOME}/public_html/${WEBDIR}
.endif
DOCBOOK_DEPS_DISABLE=	YES
.endif

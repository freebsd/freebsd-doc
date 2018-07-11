# $FreeBSD$
.if !defined(_HTDOCS_RELEASES_12_0R_INC)
_HTDOCS_RELEASES_12_0R_INC=1
DOC_PREFIX?=	${.CURDIR}/../../../../..
WEBDIR?=	/data/releases/12.0R
.if defined(DESTDIR)
DESTDIR:=	${DESTDIR}/${WEBDIR}
.else
DESTDIR=	${HOME}/public_html/${WEBDIR}
.endif
DOCBOOK_DEPS_DISABLE=	YES
.endif
.include "${DOC_PREFIX}/share/mk/doc.commands.mk"

_OS?=		FreeBSD
_REVMAJOR?=	12
_REVMINOR?=	0
_REVISION?=	${REVMAJOR}.${REVMINOR}
_BRANCH?=	CURRENT
THISRELEASE?=	${_OS}-${_REVISION}-${_BRANCH}

HOSTNAME!=	hostname
.if (${_BRANCH:MCURRENT*} != "" || ${_BRANCH:MALPHA*} != "")
SRCBRANCH=	head
.elif (${_BRANCH:MPRERELEASE} != "" || ${_BRANCH:MBETA*} != "" || ${_BRANCH:MSTABLE*} != "")
SRCBRANCH=	stable/${_REVMAJOR}
.elif (${_BRANCH:MRC*} != "" || ${_BRANCH:MRELEASE*} != "")
SRCBRANCH=	releng/${_REVMAJOR}.${_REVMINOR}
.endif

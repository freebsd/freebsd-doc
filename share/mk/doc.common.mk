#
# $FreeBSD$
#
# This include file <doc.common.mk> provides targets and variables for
# documents commonly used in doc/ and www/ tree.
#

# ------------------------------------------------------------------------
#
# Work out the language and encoding used for this document.
#
# Liberal default of maximum of 10 directories below to find it.
#

.if defined(DOC_PREFIX) && !empty(DOC_PREFIX)
DOC_PREFIX_NAME!=	${REALPATH} ${DOC_PREFIX}
DOC_PREFIX_NAME:=	${DOC_PREFIX_NAME:T}
.else
DOC_PREFIX_NAME?=	head
.endif

.if (!defined(LANGCODE) || empty(LANGCODE))
LANGCODE!=	echo ${.CURDIR} | grep -o '[a-z]*_[A-Z]*\.[-A-Za-z0-9]*' || echo "."
.endif

# normalize DOC_PREFIX
DOC_PREFIX!=	${REALPATH} ${DOC_PREFIX}

# Used for &base;
DOC_PREFIX_REL=	${.CURDIR:S,^${DOC_PREFIX}/${LANGCODE},,:C,/[^/]+,/..,g:S,^/..,,:S,^/,,:S,^$,.,}

.if !defined(URL_RELPREFIX)
URLS_ABSOLUTE=	YES
.elif !defined(URLS_ABSOLUTE)
_URL_RELPREFIX_LEVEL!=	set -- ${URL_RELPREFIX:S,/$,,:S,/, ,g}; echo "$$\#"
URL_RELPREFIX_ENT=	freebsd.urls.relprefix.${_URL_RELPREFIX_LEVEL}
.endif

#
# when URLS_ABSOLUTE is specified, make
# %freebsd.urls.absolute; "INCLUDE".
#
.if defined(URLS_ABSOLUTE)
HTMLFLAGS+=	-ifreebsd.urls.absolute
SGMLNORMFLAGS+=	-ifreebsd.urls.absolute
NSGMLSFLAGS+=	-ifreebsd.urls.absolute
.elif defined(URL_RELPREFIX_ENT) && !empty(URL_RELPREFIX_ENT)
HTMLFLAGS+=	-i${URL_RELPREFIX_ENT}
SGMLNORMFLAGS+=	-i${URL_RELPREFIX_ENT}
NSGMLSFLAGS+=	-i${URL_RELPREFIX_ENT}
.endif

# for ascii and printable format, always use URLS_ABSOLUTE.
PRINTFLAGS+=	-ifreebsd.urls.absolute
HTMLTXTFLAGS+=	-ifreebsd.urls.absolute
OTHERFLAGS+=	-ifreebsd.urls.absolute

# for packages, always use URLS_ABSOLUTE.
PKGMAKEFLAGS+=	URLS_ABSOLUTE=yes

#
# $FreeBSD$
#
# This include file <doc.common.mk> provides targets and variables for
# documents commonly used in doc/ and www/ tree.
#

AWK?=		/usr/bin/awk
GREP?=		/usr/bin/grep
REALPATH?=	/bin/realpath

.if defined(DOC_PREFIX) && !empty(DOC_PREFIX)
WEB_PREFIX?=	${DOC_PREFIX}/../www
.elif defined(WEB_PREFIX) && !empty(WEB_PREFIX)
DOC_PREFIX?=	${WEB_PREFIX}/../doc
.else
.error "You must define either WEB_PREFIX or DOC_PREFIX!"
.endif

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
DOC_PREFIX_NAME?=	doc
.endif

.if defined(WEB_PREFIX) && !empty(WEB_PREFIX)
WWW_PREFIX_NAME!=	${REALPATH} ${WEB_PREFIX}
WWW_PREFIX_NAME:=	${WWW_PREFIX_NAME:T}
.else
WWW_PREFIX_NAME?=	www
.endif

.if (!defined(LANGCODE) || empty(LANGCODE)) && (!defined(WWW_LANGCODE) || empty(WWW_LANGCODE))
# Calculate _LANGCODE.
_LANGCODE:=	${.CURDIR}
.for _ in 1 2 3 4 5 6 7 8 9 10
.if !(${_LANGCODE:H:T} == ${DOC_PREFIX_NAME}) && !(${_LANGCODE:H:T} == ${WWW_PREFIX_NAME})
_LANGCODE:=	${_LANGCODE:H}
.endif
.endfor
.if (${_LANGCODE:H:T} == ${DOC_PREFIX_NAME})
# We are in doc/.
_LANGCODE:=	${_LANGCODE:T}
_WWW_LANGCODE:=	.
.else
# We are in www/.
_WWW_LANGCODE:=	${_LANGCODE:T}
_LANGCODE:=	.
.endif
.else
# when LANGCODE or WWW_LANGCODE is defined, use the value.
.if defined(LANGCODE) && !empty(LANGCODE)
_LANGCODE?=	${LANGCODE}
.else
_LANGCODE?=	.
.endif
.if defined(WWW_LANGCODE) && !empty(WWW_LANGCODE)
_WWW_LANGCODE?=	${WWW_LANGCODE}
.else
_WWW_LANGCODE?=	.
.endif
.endif

# fixup _LANGCODE
.if (${_LANGCODE} == .)
# We have a short name such as `en' in ${_WWW_LANGCODE} now.
# Guess _LANGCODE using _WWW_LANGCODE.
_LANGCODE:=	${_WWW_LANGCODE}
.if (${_LANGCODE} != .)
_LANGCODE!=	${ECHO} ${DOC_PREFIX}/${_WWW_LANGCODE}*
.for _ in 1 2 3 4 5 6 7 8 9 10
.if !(${_LANGCODE:H:T} == ${DOC_PREFIX_NAME})
_LANGCODE:=	${_LANGCODE:H}
.endif
.endfor
_LANGCODE:=	${_LANGCODE:T}
.endif
.endif
LANGCODE?=	${_LANGCODE}

# fixup _WWW_LANGCODE
.if (${_WWW_LANGCODE} == .)
# We have a long name such as `en_US.ISO8859-1' in ${LANGCODE} now.
# Guess _WWW_LANGCODE using _LANGCODE.
_WWW_LANGCODE!=	${ECHO} ${WEB_PREFIX}/*
_WWW2_LANGCODE!=	${ECHO} ${_WWW_LANGCODE:T} |\
		${SED} -e 's,.*\(${LANGCODE:R:C,(..)_.*,\1,}[^. ]*\).*,\1,'
.if ${_WWW_LANGCODE:T} == "*"
_WWW_LANGCODE:= .
.elif ${_WWW_LANGCODE:T} == ${_WWW2_LANGCODE}
_WWW_LANGCODE:= .
.else
_WWW_LANGCODE:= ${_WWW2_LANGCODE}
.endif
.undef _WWW2_LANGCODE
.endif
WWW_LANGCODE?=	${_WWW_LANGCODE}

# normalize DOC_PREFIX and WEB_PREFIX
DOC_PREFIX!=	${REALPATH} ${DOC_PREFIX}
WEB_PREFIX!=	${REALPATH} ${WEB_PREFIX}

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

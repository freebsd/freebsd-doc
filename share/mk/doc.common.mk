#
# $FreeBSD$
#
# This include file <doc.common.mk> provides targets and variables for
# documents commonly used in doc/ and www/ tree.
#

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
DOC_PREFIX_NAME!=	realpath ${DOC_PREFIX}
DOC_PREFIX_NAME:=	${DOC_PREFIX_NAME:T}
.else
DOC_PREFIX_NAME?=	doc
.endif

.if defined(WEB_PREFIX) && !empty(WEB_PREFIX)
WWW_PREFIX_NAME!=	realpath ${WEB_PREFIX}
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
.if ${_WWW_LANGCODE:T} == ${_WWW2_LANGCODE}
_WWW_LANGCODE:= .
.else
_WWW_LANGCODE:= ${_WWW2_LANGCODE}
.endif
.undef _WWW2_LANGCODE
.endif
WWW_LANGCODE?=	${_WWW_LANGCODE}

# ------------------------------------------------------------------------
#
# advisories.xml dependency.
#

XML_ADVISORIES=		${WEB_PREFIX}/share/sgml/advisories.xml

# ------------------------------------------------------------------------
#
# mirrors.xml dependency.
#

XML_MIRRORS_MASTER=	${DOC_PREFIX}/share/sgml/mirrors.xml
XML_MIRRORS=		${.OBJDIR}/${DOC_PREFIX:S,^${.CURDIR}/,,}/${LANGCODE}/share/sgml/mirrors.xml

XSL_MIRRORS_MASTER=	${DOC_PREFIX}/share/sgml/mirrors-master.xsl

.if exists(${DOC_PREFIX}/${LANGCODE}/share/sgml/mirrors-local.xsl)
XSL_MIRRORS=		${DOC_PREFIX}/${LANGCODE}/share/sgml/mirrors-local.xsl
.else
XSL_MIRRORS=		${DOC_PREFIX}/share/sgml/mirrors-local.xsl
.endif

XSL_TRANSTABLE_MASTER=	${DOC_PREFIX}/share/sgml/transtable-master.xsl

.if exists(${DOC_PREFIX}/${LANGCODE}/share/sgml/transtable-local.xsl)
XSL_TRANSTABLE=		${DOC_PREFIX}/${LANGCODE}/share/sgml/transtable-local.xsl
.else
XSL_TRANSTABLE=		${DOC_PREFIX}/share/sgml/transtable-local.xsl
.endif

.if exists(${DOC_PREFIX}/${LANGCODE}/share/sgml/transtable.xml)
XML_TRANSTABLE=		${DOC_PREFIX}/${LANGCODE}/share/sgml/transtable.xml
.else
XML_TRANSTABLE=		${DOC_PREFIX}/share/sgml/transtable.xml
.endif

${XSL_MIRRORS}: ${XSL_MIRRORS_MASTER}

${XML_MIRRORS}: ${XML_MIRRORS_MASTER} ${XSL_TRANSTABLE} ${XSL_TRANSTABLE_MASTER}
	${MKDIR} -p ${@:H}
	${XSLTPROC} ${XSLTPROCOPTS} -o $@ \
	    --param 'transtable.xml' "'${XML_TRANSTABLE}'" \
	    --param 'transtable-conv-element' "'country'" \
	    ${XSL_TRANSTABLE} ${XML_MIRRORS_MASTER}

CLEANFILES+= ${XML_MIRRORS}

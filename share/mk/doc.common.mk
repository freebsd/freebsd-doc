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

DOC_PREFIX_NAME?=	doc
WWW_PREFIX_NAME?=	www

.if !defined(LANGCODE) || empty(LANGCODE) || !defined(WWW_LANGCODE) || empty(WWW_LANGCODE)
# Calculate LANGCODE.
LANGCODE:=	${.CURDIR}
.for _ in 1 2 3 4 5 6 7 8 9 10
.if !(${LANGCODE:H:T} == ${DOC_PREFIX_NAME}) && !(${LANGCODE:H:T} == ${WWW_PREFIX_NAME})
LANGCODE:=	${LANGCODE:H}
.endif
.endfor
.if (${LANGCODE:H:T} == ${DOC_PREFIX_NAME})
# We are in doc/.
LANGCODE:=	${LANGCODE:T}
WWW_LANGCODE:=	.
.else
# We are in www/.
WWW_LANGCODE:=	${LANGCODE:T}
LANGCODE:=	.
.endif
.endif

# fixup LANGCODE
.if (${LANGCODE} == .)
# We have a short name such as `en' in ${WWW_LANGCODE} now.
# Guess LANGCODE using WWW_LANGCODE.
LANGCODE:=	${WWW_LANGCODE}
.if (${LANGCODE} != .)
LANGCODE!=	${ECHO} ${DOC_PREFIX}/${WWW_LANGCODE}*
.for _ in 1 2 3 4 5 6 7 8 9 10
.if !(${LANGCODE:H:T} == ${DOC_PREFIX_NAME})
LANGCODE:=	${LANGCODE:H}
.endif
.endfor
LANGCODE:=	${LANGCODE:T}
.endif
.endif

# fixup WWW_LANGCODE
.if (${WWW_LANGCODE} == .)
# We have a long name such as `en_US.ISO8859-1' in ${LANGCODE} now.
# Guess WWW_LANGCODE using LANGCODE.
WWW_LANGCODE!=	${ECHO} ${WEB_PREFIX}/*
WWW2_LANGCODE!=	${ECHO} ${WWW_LANGCODE:T} |\
		${SED} -e 's,.*\(${LANGCODE:R:C,(..)_.*,\1,}[^. ]*\).*,\1,'
.if ${WWW_LANGCODE:T} == ${WWW2_LANGCODE}
WWW_LANGCODE:= .
.else
WWW_LANGCODE:= ${WWW2_LANGCODE}
.endif
.undef WWW2_LANGCODE
.endif

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

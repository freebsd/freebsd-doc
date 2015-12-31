# doc.xml.mk
# $FreeBSD$

XML_CATALOG_FILES=	file://${.OBJDIR}/catalog-cwd.xml \
			file://${DOC_PREFIX}/${LANGCODE}/share/xml/catalog.xml \
			file://${DOC_PREFIX}/share/xml/catalog.xml \
			file://${LOCALBASE}/share/xml/catalog
.if defined(EXTRA_CATALOGS)
XML_CATALOG_FILES+=	${EXTRA_CATALOGS}
.endif

.if exists(${DOC_PREFIX}/share/xml/catalog-cwd.xml)
XML_CATALOG_CWD=	${DOC_PREFIX}/share/xml/catalog-cwd.xml
.endif

# Variables used in DEPENDSET

_DEPENDSET.all=	wwwstd transtable mirrors usergroups commercial \
		news press events advisories notices

# DEPENDSET: wwwstd  .........................................................
_DEPENDSET.wwwstd=	${XML_INCLUDES}
_XML_INCLIST=	libcommon.l10n.xsl \
		libcommon.xsl \
		navibar.l10n.ent \
		navibar.ent \
		common.ent \
		header.ent \
		header.l10n.ent \
		iso8879.ent \
		l10n.ent \
		release.ent \
		release.l10n.ent \
		authors.ent
.for F in ${_XML_INCLIST}
.if exists(${DOC_PREFIX}/${LANGCODE}/share/xml/${F})
XML_INCLUDES+=	${DOC_PREFIX}/${LANGCODE}/share/xml/${F}
.endif
.if exists(${DOC_PREFIX}/share/xml/${F})
XML_INCLUDES+=	${DOC_PREFIX}/share/xml/${F}
.endif
.endfor

.if defined(XML_CATALOG_CWD)
XML_INCLUDES+=	${.OBJDIR}/catalog-cwd.xml
CLEANFILES+=	${.OBJDIR}/catalog-cwd.xml
${.OBJDIR}/catalog-cwd.xml: ${XML_CATALOG_CWD}
	${INSTALL} ${.ALLSRC} ${.TARGET}
.endif

XML_INCLUDES+=	${.OBJDIR}/autogen.ent
CLEANFILES+=	${.OBJDIR}/autogen.ent
${.OBJDIR}/autogen.ent:
.if ${LANGCODE} != en_US.ISO8859-1
	${ECHO_CMD} '<!ENTITY enbase "${DOC_PREFIX_REL}/..">' > ${.TARGET}
.endif
	${ECHO_CMD} '<!ENTITY base "${DOC_PREFIX_REL}">' >> ${.TARGET}

DEPENDSET.DEFAULT+=	wwwstd

# DEPENDSET: transtable  ......................................................
_DEPENDSET.transtable=	${XML_TRANSTABLE} ${XSL_TRANSTABLE} \
			${XSL_TRANSTABLE_MASTER} ${XSL_TRANSTABLE_COMMON}
_PARAMS.transtable=	--param transtable.xml "'${XML_TRANSTABLE}'"
XSL_TRANSTABLE_MASTER=	${DOC_PREFIX}/share/xml/transtable-master.xsl
XSL_TRANSTABLE_COMMON=	${DOC_PREFIX}/share/xml/transtable-common.xsl

.if exists(${DOC_PREFIX}/${LANGCODE}/share/xml/transtable-local.xsl)
XSL_TRANSTABLE=		${DOC_PREFIX}/${LANGCODE}/share/xml/transtable-local.xsl
.else
XSL_TRANSTABLE=		${DOC_PREFIX}/share/xml/transtable-local.xsl
.endif

.if exists(${DOC_PREFIX}/${LANGCODE}/share/xml/transtable.xml)
XML_TRANSTABLE=		${DOC_PREFIX}/${LANGCODE}/share/xml/transtable.xml
.else
XML_TRANSTABLE=		${DOC_PREFIX}/share/xml/transtable.xml
.endif

# DEPENDSET: mirrors .....................................................
_DEPENDSET.mirrors=	${XSL_MIRRORS} ${XML_MIRRORS}
_PARAMS.mirrors=	--param mirrors.xml "'${XML_MIRRORS}'"
XML_MIRRORS_MASTER=	${DOC_PREFIX}/share/xml/mirrors.xml
XML_MIRRORS=		${DOC_PREFIX}/${LANGCODE}/share/xml/mirrors.xml
XSL_MIRRORS_MASTER=	${DOC_PREFIX}/share/xml/mirrors-master.xsl
.if exists(${DOC_PREFIX}/${LANGCODE}/share/xml/mirrors-local.xsl)
XSL_MIRRORS=		${DOC_PREFIX}/${LANGCODE}/share/xml/mirrors-local.xsl
.else
XSL_MIRRORS=		${DOC_PREFIX}/share/xml/mirrors-local.xsl
.endif
${XSL_MIRRORS}: ${XSL_MIRRORS_MASTER} \
		${XSL_TRANSTABLE_COMMON}

${XML_MIRRORS}: ${XML_MIRRORS_MASTER} \
		${XSL_TRANSTABLE} ${XSL_TRANSTABLE_MASTER} ${XSL_TRANSTABLE_COMMON}
	${MKDIR} -p ${@:H}
	${XSLTPROC} ${XSLTPROCOPTS} \
		--param 'transtable.xml' "'${XML_TRANSTABLE}'" \
		--param 'transtable-target-element' "'country'" \
		--param 'transtable-word-group' "'country'" \
		--param 'transtable-mode' "'sortkey'" \
		${XSL_TRANSTABLE} ${XML_MIRRORS_MASTER} \
		| env -i LANG="${LANGCODE}" ${SORT} -f > $@.sort.tmp
	env -i ${GREP} "^<?xml" < $@.sort.tmp > $@.sort
	${ECHO} "<sortkeys>" >> $@.sort
	env -i ${AWK} '/@sortkey@/ {sub(/@sortkey@/, ++line); print;}' < $@.sort.tmp >> $@.sort
	${ECHO} '</sortkeys>' >> $@.sort
	${XSLTPROC} ${XSLTPROCOPTS} -o $@ \
		--param 'transtable.xml' "'${XML_TRANSTABLE}'" \
		--param 'transtable-target-element' "'country'" \
		--param 'transtable-word-group' "'country'" \
		--param 'transtable-sortkey.xml' "'$@.sort'" \
		${XSL_TRANSTABLE} ${XML_MIRRORS_MASTER}
	${RM} -f $@.sort $@.sort.tmp
.if ${LANGCODE} != .
CLEANFILES+=	${XML_MIRRORS}
CLEANFILES+=	${XML_MIRRORS}.sort
CLEANFILES+=	${XML_MIRRORS}.sort.tmp
.endif

# DEPENDSET: usergroups ......................................................
_DEPENDSET.usergroups=	${XML_USERGROUPS} ${XML_USERGROUPS_LOCAL} \
			${XSL_USERGROUPS_MASTER} ${XSL_USERGROUPS} \
			${XML_INCLUDES}
_PARAMS.usergroups=	--param usergroups.xml "'${XML_USERGROUPS}'" \
			--param usergroups-local.xml "'${XML_USERGROUPS_LOCAL}'"
XML_USERGROUPS=		${DOC_PREFIX}/share/xml/usergroups.xml
.if exists(${DOC_PREFIX}/${LANGCODE}/share/xml/usergroups.xml)
XML_USERGROUPS_LOCAL=	${DOC_PREFIX}/${LANGCODE}/share/xml/usergroups.xml
.else
XML_USERGROUPS_LOCAL=	${DOC_PREFIX}/share/xml/usergroups.xml
.endif
XSL_USERGROUPS_MASTER=	${DOC_PREFIX}/share/xml/templates.usergroups.xsl
.if exists(${DOC_PREFIX}/${LANGCODE}/share/xml/templates.usergroups.xsl)
XSL_USERGROUPS=	${DOC_PREFIX}/${LANGCODE}/share/xml/templates.usergroups.xsl
.else
XSL_USERGROUPS=	${DOC_PREFIX}/share/xml/templates.usergroups.xsl
.endif

# DEPENDSET: news ............................................................
_DEPENDSET.news=	${XML_NEWS_NEWS_MASTER} ${XML_NEWS_NEWS} \
			${XSL_NEWS_NEWSFLASH} \
			${XSL_NEWS_NEWS_RDF} \
			${XSL_NEWS_NEWS_RSS} \
			${XML_INCLUDES}
_PARAMS.news=		--param news.project.xml-master "'${XML_NEWS_NEWS_MASTER}'" \
			--param news.project.xml "'${XML_NEWS_NEWS}'"
XML_NEWS_NEWS_MASTER=	${DOC_PREFIX}/share/xml/news.xml
.if exists(${DOC_PREFIX}/${LANGCODE}/share/xml/news.xml)
XML_NEWS_NEWS=		${DOC_PREFIX}/${LANGCODE}/share/xml/news.xml
.else
XML_NEWS_NEWS=		${DOC_PREFIX}/share/xml/news.xml
.endif

XSL_NEWS_NEWSFLASH=	${DOC_PREFIX}/share/xml/templates.newsflash.xsl
XSL_NEWS_NEWSFLASH_OLD=	${DOC_PREFIX}/share/xml/templates.oldnewsflash.xsl
XSL_NEWS_NEWS_RDF=	${DOC_PREFIX}/share/xml/templates.news-rdf.xsl
XSL_NEWS_NEWS_RSS=	${DOC_PREFIX}/share/xml/templates.news-rss.xsl

# DEPENDSET: press  ..........................................................
_DEPENDSET.press=	${XML_NEWS_PRESS_MASTER} ${XML_NEWS_PRESS} \
			${XSL_NEWS_PRESS} \
			${XML_INCLUDES}
_PARAMS.press=		--param news.press.xml-master "'${XML_NEWS_PRESS_MASTER}'" \
			--param news.press.xml "'${XML_NEWS_PRESS}'"
XML_NEWS_PRESS_MASTER=	${DOC_PREFIX}/share/xml/press.xml
.if exists(${DOC_PREFIX}/${LANGCODE}/share/xml/press.xml)
XML_NEWS_PRESS=		${DOC_PREFIX}/${LANGCODE}/share/xml/press.xml
.else
XML_NEWS_PRESS=		${DOC_PREFIX}/share/xml/press.xml
.endif
XSL_NEWS_PRESS=		${DOC_PREFIX}/share/xml/templates.press.xsl
XSL_NEWS_PRESS_RSS=	${DOC_PREFIX}/share/xml/templates.press-rss.xsl
XSL_NEWS_PRESS_OLD=	${DOC_PREFIX}/share/xml/templates.oldpress.xsl

# DEPENDSET: events  ..........................................................
_DEPENDSET.events=	${XML_EVENTS_EVENTS_MASTER} ${XML_EVENTS_EVENTS} \
			${XML_EVENTS_EVENTS_MASTER_SUBFILES} \
			${XML_EVENTS_EVENTS_SUBFILES} \
			${XSL_EVENTS} \
			${XSL_EVENTS_ICS} \
			${XML_INCLUDES}
_PARAMS.events=		--param events.xml-master "'${XML_EVENTS_EVENTS_MASTER}'" \
			--param events.xml "'${XML_EVENTS_EVENTS}'"
XML_EVENTS_EVENTS_MASTER=${DOC_PREFIX}/share/xml/events.xml
XML_EVENTS_EVENTS_MASTER_SUBFILES=
.for Y in 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016
XML_EVENTS_EVENTS_MASTER_SUBFILES+=	${DOC_PREFIX}/share/xml/events${Y}.xml
.endfor
.if exists(${DOC_PREFIX}/${LANGCODE}/share/xml/events.xml)
XML_EVENTS_EVENTS=	${DOC_PREFIX}/${LANGCODE}/share/xml/events.xml
.else
XML_EVENTS_EVENTS=	${XML_EVENTS_EVENTS_MASTER}
.endif
XML_EVENTS_EVENTS_SUBFILES=
.for Y in 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016
.if exists(${DOC_PREFIX}/${LANGCODE}/share/xml/events${Y}.xml)
XML_EVENTS_EVENTS_SUBFILES+=	${DOC_PREFIX}/${LANGCODE}/share/xml/events${Y}.xml
.endif
.endfor
XSL_EVENTS=		${DOC_PREFIX}/share/xml/templates.events.xsl
XSL_EVENTS_ICS=		${DOC_PREFIX}/share/xml/templates.events2ics.xsl
XSL_EVENTS_PAST=	${DOC_PREFIX}/share/xml/templates.pastevents.xsl

# DEPENDSET: commercial ........................................................
_DEPENDSET.commercial=	${XML_COMMERCIAL_CONSULT} \
			${XML_COMMERCIAL_HARDWARE} \
			${XML_COMMERCIAL_ISP} \
			${XML_COMMERCIAL_MISC} \
			${XML_COMMERCIAL_SOFTWARE} \
			${XSL_ENTRIES} \
			${XML_INCLUDES}
_PARAMS.commercial=
XML_COMMERCIAL_CONSULT=	${DOC_PREFIX}/share/xml/commercial.consult.xml
XML_COMMERCIAL_HARDWARE=${DOC_PREFIX}/share/xml/commercial.hardware.xml
XML_COMMERCIAL_ISP=	${DOC_PREFIX}/share/xml/commercial.isp.xml
XML_COMMERCIAL_MISC=	${DOC_PREFIX}/share/xml/commercial.misc.xml
XML_COMMERCIAL_SOFTWARE=${DOC_PREFIX}/share/xml/commercial.software.xml

XSL_ENTRIES=		${DOC_PREFIX}/share/xml/templates.entries.xsl

# DEPENDSET: advisories  .....................................................
_DEPENDSET.advisories=	${XML_ADVISORIES} ${XML_INCLUDES}
_PARAMS.advisories=	--param advisories.xml "'${XML_ADVISORIES}'"
XML_ADVISORIES=		${DOC_PREFIX}/share/xml/advisories.xml

# DEPENDSET: notices  ........................................................
_DEPENDSET.notices=	${XML_NOTICES} ${XML_INCLUDES}
_PARAMS.notices=	--param notices.xml "'${XML_NOTICES}'"
XML_NOTICES=		${DOC_PREFIX}/share/xml/notices.xml

# ---
# .xml -> .html rendering rule
#
# The following variables are available:
#
# XMLDOCS: (ex. XMLDOCS= doc1 doc2 doc3)
#   Target document identifier, which is usually the same as the
#   base part of the filenames.  {XSLT,XML,TARGET}.<id> described below
#   can be specified in a short form like the following:
#   "docid:stylesheet:xml:target".
#
# TARGET.<id>: (ex. TARGET.doc1= doc1.html)
#   The target filename.  This is optional and <id>.html is defined
#   by default.
#
# XSLT.<id>: (ex. XSLT.doc1= doc1.xsl)
#   Filename of the XSLT stylesheet.  This is optional and <id>.xsl is
#   defined by default.  The following keywords are interpreted specially:
#
#    `xsl'             - <id>.xsl
#
# XSLT.DEFAULT:
#   The default filename or keyword of XSLT stylesheet.
#   When XSLT.<id> and one in the quadruplet are not specified,
#   this value is used.
#
# XML.<id>: (ex. XML.doc1= doc1.xml data.xml)
#   Filename of the XML document.  This is optional and /dev/null is
#   defined by default.  XML.DEFAULT is XML document for all <id>s.
#
# SRCS.<id>: (ex. SRCS.doc1= includes.xsl)
#   Dependencies.  SRCS.DEFAULT is dependencies for all <id>s.
#
# DEPENDSET.<id>: (ex. DEPENDSET.doc1= mirror)
#   Depencencies predefined as keywords listed in ${_DEPENDSET.all}.
#   DEPENDSET.DEFAULT is DEPENDSET for all <id>s.
#
# PARAMS.<id>: (ex. PARAMS.doc1= --params "foo" "'textproc/foo'")
#   Parameters passed to xsltproc(1).
#
# XSLTPROCOPTS.<id>: (ex. XSLTPROCOPTS.doc1= --nonet)
#   Parameters passed to xsltproc(1).
#
# NO_DATA.<id>
#   The ${TARGET.<id>} file will not be listed in $DATA if defined.
#   NO_DATA.DEFAULT is the setting for all <id>s.
#
XSLTPROC_ENV+=	XML_CATALOG_FILES="${XML_CATALOG_FILES}"

XSLTPROCOPTS=	${XSLTPROCFLAGS}
XSLTPROCOPTS+=	--xinclude --nonet --maxvars 20000
.if defined(WWWFREEBSDORG)
XSLTPROCOPTS+=	--param "html.header.script.google" "'INCLUDE'"
.endif
XSLTPROC=	env ${XSLTPROC_ENV} ${LOCALBASE}/bin/xsltproc

XMLLINTOPTS=	${XMLLINTFLAGS}
XMLLINTOPTS+=	--xinclude --valid --noout --nonet
XMLLINT=	env ${XSLTPROC_ENV} ${PREFIX}/bin/xmllint

.for D in ${XMLDOCS}
# parse "docid:xslt:xml:target".
# XXX: ${__ID} is used because ${A}=B does not work except
#      for the iterate variable in the .for statement.
__ID=${D:C,:.*$,,}

.for _ID in ${__ID}
_tmpD=	${D:M*\:*}
.if !empty(_tmpD)
XSLT.${_ID}=	${D:C,^[^:]*,,:M*\:*:C,^:,,:C,:.*$,,}
XML.${_ID}=	${D:C,^[^:]*,,:M*\:*:C,^:,,:C,^[^:]*,,:M*\:*:C,^:,,:C,:.*$,,}
TARGET.${_ID}=	${D:C,^[^:]*,,:M*\:*:C,^:,,:C,^[^:]*,,:M*\:*:C,^:,,:C,^[^:]*,,:M*\:*:C,^:,,:C,:.*$,,}
.endif

# Use default value if parameter not specified.
.if !defined(XSLT.${_ID}) || empty(XSLT.${_ID})
.if defined(XSLT.DEFAULT)
XSLT.${_ID}=	${XSLT.DEFAULT}
.else
XSLT.${_ID}=	${_ID}.xsl
.endif
.endif
.if !defined(XML.${_ID}) || empty(XML.${_ID})
.if defined(XML.DEFAULT)
XML.${_ID}=	${XML.DEFAULT}
.else
XML.${_ID}=	${_ID}.xml
.endif
.endif
.if !defined(TARGET.${_ID}) || empty(TARGET.${_ID})
TARGET.${_ID}=	${_ID}.html
.endif
.if !defined(DEPENDSET.${_ID}) || empty(DEPENDSET.${_ID})
.if defined(DEPENDSET.DEFAULT)
DEPENDSET.${_ID}=	${DEPENDSET.DEFAULT}
.else
DEPENDSET.${_ID}=
.endif
.endif
.if !defined(NO_DATA.${_ID}) || empty(NO_DATA.${_ID})
.if defined(NO_DATA.DEFAULT)
NO_DATA.${_ID}=	${NO_DATA.DEFAULT}
.else
NO_DATA.${_ID}=
.endif
.endif

XSLTPROCOPTS.${_ID}?=	${XSLTPROCOPTS}
GENDOCS+=	${TARGET.${_ID}}
SRCS+=		${TARGET.${_ID}}
.if !defined(NO_DATA.${_ID}) || empty(NO_DATA.${_ID})
DATA+=		${TARGET.${_ID}}
.endif
CLEANFILES+=	${TARGET.${_ID}}

.if ${XSLT.${_ID}} == xsl
XSLT.${_ID}=	${_ID}.xsl
DEPENDS.${_ID}+=	${XSLT.${_ID}}
.elif ${XSLT.${_ID}:Mhttp\://*} != ""
DEPENDS.${_ID}+=	${XSLT.${_ID}}
.else
DEPENDS.${_ID}+=	${XSLT.${_ID}}
.endif

.for S in ${_DEPENDSET.all}
. if ${DEPENDSET.${_ID}:M${S}} != ""
DEPENDS.${_ID}+=${_DEPENDSET.${S}}
PARAMS.${_ID}+=	${_PARAMS.${S}}
. endif
.endfor

.for S in ${SRCS.DEFAULT} ${SRCS.${_ID}}
DEPENDS.${_ID}+=	${S}
.endfor
${TARGET.${_ID}}: ${XML.${_ID}} ${DEPENDS.${_ID}}
	${XSLTPROC} ${XSLTPROCOPTS.${_ID}} \
		-o ${.TARGET} ${PARAMS.${_ID}} \
		${XSLT.${_ID}} ${XML.${_ID}}

VALIDATE_DOCS+=	VALIDATE.${_ID}
VALIDATE.${_ID}:
	@${ECHO} "==>[xmllint] ${XML.${_ID}}"
	-@${XMLLINT} ${XMLLINTOPTS} ${XML.${_ID}} 2>&1  \
		| ${SED} -e 's/^/ | /'
.  endfor
.endfor

lint: ${VALIDATE_DOCS}

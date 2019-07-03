# $FreeBSD$

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.xml
DOCS+= administration.xml
DOCS+= applications.xml
DOCS+= art.xml
DOCS+= docs.xml
DOCS+= features.xml
DOCS+= logo.xml
DOCS+= mailto.xml
DOCS+= privacy.xml
DOCS+= publish.xml
DOCS+= relnotes.xml
DOCS+= send-pr.xml
DOCS+= support.xml
DOCS+= where.xml
DOCS+= 4xx.xml
DOCS+= 5xx.xml

XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=transtable mirrors news press events \
		advisories notices

XMLDOCS+=	usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
DEPENDSET.usergroups=transtable usergroups
PARAMS.usergroups=	--param pagename "'FreeBSD User Groups'"

XMLDOCS+=	community::${XML_EVENTS_EVENTS}:
DEPENDSET.community=usergroups events

# These will be directly installed.

DATA=	favicon.ico
DATA+=	google6bb24ed0b804d5e9.html
DATA+=	google96eb5b100ed66487.html
DATA+=	robots.txt

# Subdirectories
# XML
SUBDIR+= advocacy
SUBDIR+= commercial
SUBDIR+= community
SUBDIR+= copyright
SUBDIR+= developers
SUBDIR+= docproj
SUBDIR+= docs
SUBDIR+= donations
SUBDIR+= events
SUBDIR+= gnome
SUBDIR+= internal
SUBDIR+= ipv6
SUBDIR+= java
SUBDIR+= marketing
SUBDIR+= multimedia
SUBDIR+= news
SUBDIR+= platforms
SUBDIR+= portmgr
SUBDIR+= projects
SUBDIR+= prstats
SUBDIR+= releases
SUBDIR+= releng
SUBDIR+= search
SUBDIR+= security
SUBDIR+= snapshots
SUBDIR+= support
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
SUBDIR+= ports
.endif
.if defined(BUILD_RELNOTES)
SUBDIR+= relnotes
.endif

# Non-XML
SUBDIR+= cgi
SUBDIR+= gifs
SUBDIR+= layout
SUBDIR+= logo

.if !defined(WEB_LANG) || empty(WEB_LANG)
WEB_LANG=	da_DK.ISO8859-1 \
		de_DE.ISO8859-1 \
		el_GR.ISO8859-7 \
		es_ES.ISO8859-1 \
		fr_FR.ISO8859-1 \
		hu_HU.ISO8859-2 \
		it_IT.ISO8859-15 \
		ja_JP.eucJP \
		mn_MN.UTF-8 \
		nl_NL.ISO8859-1 \
		pt_BR.ISO8859-1 \
		ru_RU.KOI8-R \
		zh_CN.UTF-8 \
		zh_TW.UTF-8
.endif
.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.for _D in ${WEB_LANG}
SUBDIR+=	../../${_D}/htdocs
.endfor
.endif

WEBDIR?=	data

.include "${DOC_PREFIX}/share/mk/web.site.mk"

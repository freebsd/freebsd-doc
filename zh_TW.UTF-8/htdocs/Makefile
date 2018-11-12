# $FreeBSD$
# Original revision:

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.xml
DOCS+= applications.xml
DOCS+= art.xml
DOCS+= availability.xml
#DOCS+= community.xml
DOCS+= docs.xml
DOCS+= logo.xml
DOCS+= send-pr.xml
DOCS+= support.xml
DOCS+= where.xml

XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=transtable mirrors news press events \
		advisories notices

XMLDOCS+=	usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
DEPENDSET.usergroups=transtable usergroups
PARAMS.usergroups=	--param pagename "'FreeBSD User Groups'"

XMLDOCS+=       community::${XML_EVENTS_EVENTS}:
DEPENDSET.community=usergroups events

# Subdirectories
# XML
SUBDIR+= docs
SUBDIR+= news
SUBDIR+= platforms

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+=	doc
.endif

# Non-XML
#SUBDIR+= layout

WEBDIR?=	data/zh_TW

DATESUBST?=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"上次更新： \1">/'

.include "${DOC_PREFIX}/share/mk/web.site.mk"

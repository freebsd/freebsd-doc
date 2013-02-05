# $FreeBSD$

###################################################
# The FreeBSD Hungarian Documentation Project     #
###################################################

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=	about.xml
DOCS+=	administration.xml
DOCS+=	applications.xml
DOCS+=	art.xml
DOCS+=	docs.xml
DOCS+=	features.xml
DOCS+=	internet.xml
DOCS+=	logo.xml
DOCS+=	mailto.xml
DOCS+=	send-pr.xml
DOCS+=	support.xml
DOCS+=	where.xml

# Subdirectories
# XML
SUBDIR+=	advocacy
SUBDIR+=	community
SUBDIR+=	copyright
SUBDIR+=	developers
SUBDIR+=	docproj
SUBDIR+=	docs
SUBDIR+=	events
SUBDIR+=	news
SUBDIR+=	platforms
SUBDIR+=	projects
SUBDIR+=	search
SUBDIR+=	security
SUBDIR+=	support
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+=	doc
.endif

WEBDIR?=	data/hu

## index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=	transtable mirrors news press events \
			advisories notices

XMLDOCS+=	community::${XML_EVENTS_EVENTS}:
DEPENDSET.community=usergroups events

DATESUBST=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"Utols\&oacute\; m\&oacute\;dos\&iacute\;t\&aacute\;s: \1">/'

.include "${DOC_PREFIX}/share/mk/web.site.mk"

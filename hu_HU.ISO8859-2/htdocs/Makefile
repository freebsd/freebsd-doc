# $FreeBSD: www/hu/Makefile,v 1.7 2008/05/02 08:56:08 pgj Exp $

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

DOCS=	about.sgml
DOCS+=	administration.sgml
DOCS+=	applications.sgml
DOCS+=	art.sgml
DOCS+=	docs.sgml
DOCS+=	features.sgml
DOCS+=	internet.sgml
DOCS+=	logo.sgml
DOCS+=	mailto.sgml
DOCS+=	send-pr.sgml
DOCS+=	support.sgml
DOCS+=	where.sgml

# Subdirectories
# SGML
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

.include "${WEB_PREFIX}/share/mk/web.site.mk"

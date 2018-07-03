# $FreeBSD$
# The FreeBSD Simplified Chinese Documentation Project
# Original Revision: 1.135
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
DOCS+= docs.xml
DOCS+= features.xml
DOCS+= logo.xml
DOCS+= mailto.xml
# DOCS+= publish.xml
DOCS+= relnotes.xml
DOCS+= send-pr.xml
DOCS+= support.xml
DOCS+= where.xml

XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=transtable mirrors news press events \
		advisories notices

XMLDOCS+=	usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
DEPENDSET.usergroups=transtable usergroups
PARAMS.usergroups=	--param pagename "'FreeBSD User Groups'"

XMLDOCS+=	community::${XML_EVENTS_EVENTS}:
DEPENDSET.community=usergroups events

# Subdirectories
# XML
# SUBDIR= FAQ
SUBDIR+= advocacy
# SUBDIR+= commercial
# SUBDIR+= community
SUBDIR+= copyright
# SUBDIR+= developers
# SUBDIR+= docproj
# SUBDIR+= docs
# SUBDIR+= donations
# SUBDIR+= events
# SUBDIR+= gnome
# SUBDIR+= handbook
# SUBDIR+= internal
# SUBDIR+= java
# SUBDIR+= kse
# SUBDIR+= marketing
SUBDIR+= news
SUBDIR+= platforms
# SUBDIR+= portmgr
# SUBDIR+= projects
# SUBDIR+= prstats
SUBDIR+= releases
# SUBDIR+= releng
# SUBDIR+= search
SUBDIR+= security
# SUBDIR+= smp
# SUBDIR+= snapshots
# SUBDIR+= support
# SUBDIR+= tutorials
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+=	doc
#SUBDIR+= ports
.endif
# .if defined(BUILD_RELNOTES)
# SUBDIR+= relnotes
# .endif

# # Non-XML
# SUBDIR+= cgi
# SUBDIR+= gifs
# SUBDIR+= layout
#SUBDIR+= logo

WEBDIR?=	data/zh_CN

DATESUBST?=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"上次更新： \1">/'

.include "${DOC_PREFIX}/share/mk/web.site.mk"

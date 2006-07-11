# $FreeBSD: www/zh_CN/Makefile,v 1.1.1002.14 2006/06/26 05:13:33 delphij Exp $
# The FreeBSD Simplified Chinese Documentation Project
# Original Revision: 1.135
.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml
DOCS+= applications.sgml
DOCS+= art.sgml
DOCS+= availability.sgml
DOCS+= community.sgml
DOCS+= docs.sgml
DOCS+= features.sgml
DOCS+= internet.sgml
DOCS+= logo.sgml
DOCS+= mailto.sgml
# DOCS+= publish.sgml
DOCS+= relnotes.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml
DOCS+= y2kbug.sgml

XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=transtable mirrors news press events \
		advisories notices

XMLDOCS+=	usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
DEPENDSET.usergroups=transtable usergroups
PARAMS.usergroups=	--param pagename "'FreeBSD User Groups'"

# Subdirectories
# SGML
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

# # Non-SGML
# SUBDIR+= cgi
# SUBDIR+= gifs
SUBDIR+= layout
#SUBDIR+= logo

WEBBASE?=	/data/zh_CN

DATESUBST?=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"上次更新： \1">/'

.include "${WEB_PREFIX}/share/mk/web.site.mk"

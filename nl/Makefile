# $FreeBSD: www/nl/Makefile,v 1.4 2011/06/12 20:36:07 rene Exp $
# %SOURCE%	en/Makefile
# %SRCID%	1.148

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml
DOCS+= administration.sgml
DOCS+= applications.sgml
DOCS+= art.sgml
DOCS+= availability.sgml
DOCS+= docs.sgml
DOCS+= features.sgml
DOCS+= internet.sgml
DOCS+= logo.sgml
DOCS+= mailto.sgml
DOCS+= privacy.sgml
DOCS+= publish.sgml
DOCS+= relnotes.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml
#DOCS+= y2kbug.sgml

XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=transtable mirrors news press events \
		advisories notices

XMLDOCS+=	usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
DEPENDSET.usergroups=transtable usergroups
PARAMS.usergroups=	--param pagename "'FreeBSD Gebruikersgroepen'"

XMLDOCS+=	community::${XML_EVENTS_EVENTS}:
DEPENDSET.community=usergroups events

# These will be directly installed.

#DATA=	favicon.ico
#DATA+=	freebsd.css
#DATA+=	index.css
#DATA+=	robots.txt
DATA+=	vendors.html

# Subdirectories
# SGML
#SUBDIR= FAQ
#SUBDIR+= advocacy
#SUBDIR+= commercial
#SUBDIR+= community
#SUBDIR+= copyright
#SUBDIR+= developers
#SUBDIR+= docproj
#SUBDIR+= docs
#SUBDIR+= donations
#SUBDIR+= events
#SUBDIR+= gnome
#SUBDIR+= handbook
#SUBDIR+= internal
#SUBDIR+= ipv6
#SUBDIR+= java
#SUBDIR+= kse
#SUBDIR+= marketing
#SUBDIR+= multimedia
#SUBDIR+= news
#SUBDIR+= platforms
#SUBDIR+= portmgr
#SUBDIR+= projects
#SUBDIR+= prstats
#SUBDIR+= releases
#SUBDIR+= releng
#SUBDIR+= search
#SUBDIR+= security
#SUBDIR+= smp
#SUBDIR+= snapshots
#SUBDIR+= support
#SUBDIR+= tutorials
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
#SUBDIR+= ports
.endif
.if defined(BUILD_RELNOTES)
#SUBDIR+= relnotes
.endif

WEBDIR?=	data/nl

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD: www/ja/Makefile,v 1.81 2011/06/17 12:52:33 ryusuke Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.147

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml
#DOCS+= administration.sgml
DOCS+= applications.sgml
#DOCS+= art.sgml
DOCS+= availability.sgml
DOCS+= docs.sgml
DOCS+= features.sgml
DOCS+= internet.sgml
#DOCS+= logo.sgml
DOCS+= mailto.sgml
DOCS+= publish.sgml
DOCS+= relnotes.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml
DOCS+= y2kbug.sgml

# Japanese-only file
DOCS+= jabout.sgml

XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=transtable mirrors news press events \
		advisories notices

XMLDOCS+=       usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
DEPENDSET.usergroups=transtable usergroups
PARAMS.usergroups=      --param pagename "'FreeBSD User Groups'"

XMLDOCS+=	community::${XML_EVENTS_EVENTS}:
DEPENDSET.community=usergroups events

# These will be directly installed.

#DATA=	favicon.ico
DATA+=	freebsd.css
#DATA+=	robots.txt
#DATA+= vendors.html

# Subdirectories
# SGML
SUBDIR= FAQ
#SUBDIR+= advocacy
SUBDIR+= commercial
SUBDIR+= community
SUBDIR+= copyright
SUBDIR+= developers
SUBDIR+= docproj
SUBDIR+= docs
#SUBDIR+= donations
SUBDIR+= events
#SUBDIR+= gnome
SUBDIR+= handbook
SUBDIR+= internal
#SUBDIR+= ipv6
SUBDIR+= java
#SUBDIR+= kse
#SUBDIR+= layout
#SUBDIR+= marketing
#SUBDIR+= multimedia
SUBDIR+= news
SUBDIR+= platforms
#SUBDIR+= portmgr
SUBDIR+= projects
SUBDIR+= prstats
SUBDIR+= releases
#SUBDIR+= releng
SUBDIR+= search
SUBDIR+= security
SUBDIR+= smp
SUBDIR+= snapshots
SUBDIR+= support
SUBDIR+= tutorials

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
SUBDIR+= ports
# .endif
# .if defined(BUILD_RELNOTES)
# SUBDIR+= relnotes
.endif

# Non-SGML
#SUBDIR+= cgi
#SUBDIR+= gifs
#SUBDIR+= layout
#SUBDIR+= logo

WEBDIR?=	data/ja

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

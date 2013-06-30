# $FreeBSD$
# %SOURCE%	en_US.ISO8859-1/htdocs/Makefile
# %SRCID%	41060

# XXX rene r40275 (Google Analytics) not merged in (yet)

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
DOCS+= internet.xml
DOCS+= logo.xml
DOCS+= mailto.xml
DOCS+= privacy.xml
DOCS+= publish.xml
DOCS+= relnotes.xml
DOCS+= send-pr.xml
DOCS+= support.xml
DOCS+= where.xml
DOCS+= 4xx.xml

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

# Subdirectories
# XML
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
#SUBDIR+= snapshots
#SUBDIR+= support
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
#SUBDIR+= ports
.endif
.if defined(BUILD_RELNOTES)
#SUBDIR+= relnotes
.endif

WEBDIR?=	data/nl

.include "${DOC_PREFIX}/share/mk/web.site.mk"

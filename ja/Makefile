# $FreeBSD: www/ja/Makefile,v 1.70 2005/10/04 16:21:45 hrs Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.114

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=	about.sgml
DOCS+=	applications.sgml
#DOCS+= art.sgml
DOCS+= availability.sgml
DOCS+=	community.sgml
DOCS+= docs.sgml 
DOCS+= features.sgml
DOCS+= register.sgml
DOCS+= internet.sgml 
DOCS+= mailto.sgml 
DOCS+= publish.sgml
DOCS+= relnotes.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
#DOCS+= usergroups.sgml
DOCS+= where.sgml 
DOCS+= y2kbug.sgml 

# Japanese-only file
DOCS+= jabout.sgml

XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=transtable mirrors news press events \
		navigation advisories notices

XMLDOCS+=       usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
DEPENDSET.usergroups=transtable usergroups
PARAMS.usergroups=      --param pagename "'FreeBSD User Groups'"

# These will be directly installed.

#DATA=	favicon.ico
#DATA+=	robots.txt
DATA+=	freebsd.css
#DATA+=  vendors.html

# Subdirectories
# SGML
SUBDIR=	 security
SUBDIR+= commercial
SUBDIR+= docproj
SUBDIR+= news
#SUBDIR+= advocacy

#SUBDIR+= events
SUBDIR+= FAQ
SUBDIR+= handbook
SUBDIR+= tutorials
SUBDIR+= internal
SUBDIR+= java
SUBDIR+= copyright
SUBDIR+= search
SUBDIR+= projects
SUBDIR+= prstats
SUBDIR+= platforms
SUBDIR+= releases
#SUBDIR+= releng
SUBDIR+= smp
#SUBDIR+= kse
#SUBDIR+= gnome
#SUBDIR+= donations
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
SUBDIR+= doc
# .endif
# .if defined(BUILD_RELNOTES)
# SUBDIR+= relnotes
.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

WEBDIR?=	data/ja

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

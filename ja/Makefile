# $FreeBSD: www/ja/Makefile,v 1.69 2005/09/18 06:25:00 hrs Exp $
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
DOCS+= auditors.sgml
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

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

index.html: index.xsl ${XML_INCLUDES}\
		${XML_NEWS_INCLUDES} \
		${XML_NEWS_NEWS} ${XML_NEWS_NEWS_MASTER} \
		${XML_NEWS_PRESS} ${XML_NEWS_PRESS_MASTER} \
		${XML_EVENTS_EVENTS_MASTER} ${XML_EVENTS_CURDATE} \
		${XML_MIRRORS} ${XML_TRANSTABLE} \
		${XML_ADVISORIES} ${XML_NOTICES} \
		${XML_NAVIGATION}
	${XSLTPROC} ${XSLTPROCOPTS} \
		-o $@ \
		--param mirrors.xml "'${XML_MIRRORS}'" \
		--param advisories.xml "'${XML_ADVISORIES}'" \
		--param notices.xml "'${XML_NOTICES}'" \
		--param news.press.xml-master "'${XML_NEWS_PRESS_MASTER}'" \
		--param news.press.xml "'${XML_NEWS_PRESS}'" \
		--param news.project.xml-master "'${XML_NEWS_NEWS_MASTER}'" \
		--param news.project.xml "'${XML_NEWS_NEWS}'" \
		--param events.xml-master "'${XML_EVENTS_EVENTS_MASTER}'" \
		--param curdate.xml "'${XML_EVENTS_CURDATE}'" \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		--param navigation.xml "'${XML_NAVIGATION}'" \
		${.CURDIR}/index.xsl ${XML_NEWS_NEWS} ${XML_EVENTS_EVENTS_MASTER} ${XML_EVENTS_CURDATE}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

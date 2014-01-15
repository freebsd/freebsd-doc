# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.107

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.xml
DOCS+= applications.xml
DOCS+= art.xml
DOCS+= auditors.xml
DOCS+= availability.xml
DOCS+= community.xml
DOCS+= docs.xml
DOCS+= features.xml
DOCS+= internet.xml
DOCS+= logo.xml
DOCS+= mailto.xml
DOCS+= publish.xml
DOCS+= relnotes.xml
DOCS+= send-pr.xml
DOCS+= support.xml
DOCS+= where.xml

# These will be directly installed.

DATA=	favicon.ico
DATA+=	robots.txt
DATA+=	freebsd.css
DATA+=  vendors.html

# Subdirectories
# XML
SUBDIR=	 security
SUBDIR+= commercial
SUBDIR+= community
SUBDIR+= docproj
SUBDIR+= docs
SUBDIR+= news
SUBDIR+= advocacy

SUBDIR+= events
SUBDIR+= FAQ
SUBDIR+= handbook
SUBDIR+= tutorials
SUBDIR+= internal
SUBDIR+= java
SUBDIR+= copyright
SUBDIR+= developers
SUBDIR+= search
SUBDIR+= projects
SUBDIR+= prstats
SUBDIR+= platforms
SUBDIR+= releases
SUBDIR+= releng
SUBDIR+= snapshots
SUBDIR+= support
SUBDIR+= gnome
SUBDIR+= donations
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
# SUBDIR+= ports
SUBDIR+= doc
.endif
.if defined(BUILD_RELNOTES)
#SUBDIR+= relnotes
.endif

WEBDIR?=	data/fr

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

.include "${DOC_PREFIX}/share/mk/web.site.mk"

index.html: index.xsl ${XML_INCLUDES}\
		${XML_NEWS_INCLUDES} \
		${XML_NEWS_NEWS} ${XML_NEWS_NEWS_MASTER} \
		${XML_NEWS_PRESS} ${XML_NEWS_PRESS_MASTER} \
		${XML_EVENTS_EVENTS} ${XML_EVENTS_EVENTS_MASTER} ${XML_EVENTS_CURDATE} \
		${XML_MIRRORS} ${XML_TRANSTABLE} \
		${XML_ADVISORIES} ${XML_NOTICES}
	${XSLTPROC} ${XSLTPROCOPTS} \
		-o $@ \
		--param mirrors.xml "'${XML_MIRRORS}'" \
		--param advisories.xml "'${XML_ADVISORIES}'" \
		--param news.press.xml-master "'${XML_NEWS_PRESS_MASTER}'" \
		--param news.press.xml "'${XML_NEWS_PRESS}'" \
		--param news.project.xml-master "'${XML_NEWS_NEWS_MASTER}'" \
		--param news.project.xml "'${XML_NEWS_NEWS}'" \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		--param events.xml-master "'${XML_EVENTS_EVENTS_MASTER}'" \
		--param events.xml "'${XML_EVENTS_EVENTS}'" \
		--param curdate.xml "'${XML_EVENTS_CURDATE}'" \
		--param notices.xml "'${XML_NOTICES}'" \
		${.CURDIR}/index.xsl ${XML_NEWS_NEWS} ${XML_EVENTS_EVENTS} ${XML_EVENTS_CURDATE}

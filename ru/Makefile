#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD: www/ru/Makefile,v 1.47 2005/10/05 20:39:12 simon Exp $
# $FreeBSDru: frdp/www/ru/Makefile,v 1.49 2005/11/03 21:27:23 gad Exp $
#
# Original revision: 1.122
#

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml
DOCS+=  applications.sgml
DOCS+= art.sgml
DOCS+= availability.sgml
DOCS+= community.sgml
DOCS+= docs.sgml
DOCS+= features.sgml
DOCS+= internet.sgml
DOCS+= mailto.sgml
DOCS+= publish.sgml
DOCS+= relnotes.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml
DOCS+= y2kbug.sgml

# These will be directly installed.

#DATA=	favicon.ico
#DATA+=	freebsd.css
#DATA+=	index.css
#DATA+=	robots.txt
#DATA+=	vendors.html

# Subdirectories
# SGML
SUBDIR= FAQ
#SUBDIR+= advocacy
SUBDIR+= commercial
SUBDIR+= community
SUBDIR+= copyright
SUBDIR+= docproj
SUBDIR+= donations
SUBDIR+= events
#SUBDIR+= gnome
SUBDIR+= handbook
SUBDIR+= internal
SUBDIR+= java
SUBDIR+= kse
SUBDIR+= marketing
SUBDIR+= news
SUBDIR+= platforms
SUBDIR+= portmgr
SUBDIR+= projects
#SUBDIR+= prstats
SUBDIR+= releases
SUBDIR+= releng
SUBDIR+= search
SUBDIR+= security
SUBDIR+= smp
SUBDIR+= snapshots
SUBDIR+= support
SUBDIR+= tutorials
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
SUBDIR+= ports
.endif
.if defined(BUILD_RELNOTES)
SUBDIR+= relnotes
.endif

# Non-SGML
#SUBDIR+= cgi
#SUBDIR+= gifs

XMLDOCS=       usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
DEPENDSET.usergroups=transtable usergroups
PARAMS.usergroups=      --param pagename "'FreeBSD User Groups'"

WEBDIR?=	data/ru

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

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
		--param advisories.xml "'${XML_ADVISORIES}'" \
		--param mirrors.xml "'${XML_MIRRORS}'" \
		--param navigation.xml "'${XML_NAVIGATION}'" \
		--param news.press.xml-master "'${XML_NEWS_PRESS_MASTER}'" \
		--param news.press.xml "'${XML_NEWS_PRESS}'" \
		--param news.project.xml-master "'${XML_NEWS_NEWS_MASTER}'" \
		--param news.project.xml "'${XML_NEWS_NEWS}'" \
		--param events.xml-master "'${XML_EVENTS_EVENTS_MASTER}'" \
		--param curdate.xml "'${XML_EVENTS_CURDATE}'" \
		--param notices.xml "'${XML_NOTICES}'" \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		${.CURDIR}/index.xsl ${XML_NEWS_NEWS} ${XML_EVENTS_EVENTS_MASTER} ${XML_EVENTS_CURDATE}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

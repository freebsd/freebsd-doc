# $FreeBSD: www/es/Makefile,v 1.20 2005/12/06 23:09:33 jcamou Exp $
# $FreeBSDes: www/es/Makefile,v 1.3 2004/09/07 21:43:32 jcamou Exp $

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml
DOCS+=  applications.sgml
DOCS+= auditors.sgml
DOCS+= availability.sgml
DOCS+= community.sgml
DOCS+= docs.sgml
DOCS+= features.sgml
DOCS+= index.sgml
DOCS+= internet.sgml
DOCS+= mailto.sgml
DOCS+= publish.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml
DOCS+= y2kbug.sgml

CLEANFILES+=atoz.sgml site.sgml

# Subdirectories
# SGML
SUBDIR=  security
#SUBDIR+= commercial
SUBDIR+= docproj
SUBDIR+= news
SUBDIR+= alpha
SUBDIR+= internal
SUBDIR+= copyright
SUBDIR+= search
#SUBDIR+= gallery
SUBDIR+= projects
SUBDIR+= releases
#SUBDIR+= doc-es
SUBDIR+= gnome

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
SUBDIR+= doc
.endif

WEBDIR?=	data/es

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
		${XML_ADVISORIES} ${XML_NOTICES}
	${XSLTPROC} ${XSLTPROCOPTS} \
		-o $@ \
		--param advisories.xml "'${XML_ADVISORIES}'" \
		--param mirrors.xml "'${XML_MIRRORS}'" \
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

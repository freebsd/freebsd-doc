# $FreeBSD: /usr/local/www/cvsroot/FreeBSD/www/en/Makefile,v 1.135 2006/05/08 23:15:37 kuriyama Exp $

###################################################
# The FreeBSD Hungarian Documentation Project     #
###################################################

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=	about.sgml
DOCS+=	applications.sgml
DOCS+=	art.sgml
DOCS+=	community.sgml
DOCS+=	docs.sgml
DOCS+=	features.sgml
DOCS+=	internet.sgml
DOCS+=	logo.sgml
DOCS+=	mailto.sgml
DOCS+=	send-pr.sgml
DOCS+=	support.sgml
DOCS+=	where.sgml

# Subdirectories
# SGML
SUBDIR+=	advocacy
SUBDIR+=	community
SUBDIR+=	copyright
SUBDIR+=	developers
SUBDIR+=	docproj
SUBDIR+=	docs
SUBDIR+=	platforms
SUBDIR+=	search
SUBDIR+=	projects
SUBDIR+=	support

WEBDIR?=	data/hu

## index.html is special, and generated from index.xsl and news/news.xml
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

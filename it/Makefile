# $FreeBSD: www/it/Makefile,v 1.12 2005/11/01 14:18:01 blackend Exp $
.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml
DOCS+= community.sgml
DOCS+= docs.sgml
DOCS+= mailto.sgml
DOCS+= support.sgml
DOCS+= where.sgml

# Subdirectories
# SGML
SUBDIR=  copyright
SUBDIR+= docs
SUBDIR+= platforms
SUBDIR+= ports
SUBDIR+= releases
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
.endif

WEBDIR?=	data/it

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

index.html: index.xsl ${XML_INCLUDES} \
		${XML_NEWS_INCLUDES_MASTER} \
		${XML_NEWS_NEWS_MASTER} ${XML_NEWS_PRESS_MASTER} \
		${XML_EVENTS_EVENTS_MASTER} ${XML_EVENTS_CURDATE} \
		${XML_MIRRORS} ${XML_TRANSTABLE} \
		${XML_ADVISORIES} ${XML_NOTICES}
	${XSLTPROC} ${XSLTPROCOPTS} \
		-o $@ \
		--param advisories.xml "'${XML_ADVISORIES}'" \
		--param curdate.xml "'${XML_EVENTS_CURDATE}'" \
		--param events.xml "'${XML_EVENTS_EVENTS_MASTER}'" \
		--param mirrors.xml "'${XML_MIRRORS}'" \
		--param news.press.xml "'${XML_NEWS_PRESS_MASTER}'" \
		--param news.project.xml "'${XML_NEWS_NEWS_MASTER}'" \
		--param notices.xml "'${XML_NOTICES}'" \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		${.CURDIR}/index.xsl ${XML_NEWS_NEWS_MASTER}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

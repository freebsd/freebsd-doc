# $FreeBSD: www/it/Makefile,v 1.2 2003/11/10 00:14:49 simon Exp $
.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  docs.sgml
DOCS+= mailto.sgml

# Subdirectories
# SGML
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR=  doc
.endif

WEBDIR?=	data/it

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

index.html: index.xsl ${XML_INCLUDES} \
		${XML_NEWS_INCLUDES_MASTER} ${XML_NEWS_NEWS_MASTER} ${XML_NEWS_PRESS_MASTER} \
		${XML_MIRRORS} ${XML_ADVISORIES}
	${XSLTPROC} ${XSLTPROCOPTS} \
		-o $@ \
		--param mirrors.xml "'${XML_MIRRORS}'" \
		--param advisories.xml "'${XML_ADVISORIES}'" \
		--param news.press.xml "'${XML_NEWS_PRESS_MASTER}'" \
		--param news.project.xml "'${XML_NEWS_NEWS_MASTER}'" \
		${.CURDIR}/index.xsl ${XML_NEWS_NEWS_MASTER}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

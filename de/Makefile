# The FreeBSD Documentation Project
# The FreeBSD German Documentation Project
# $FreeBSD: www/de/Makefile,v 1.15 2004/04/06 11:41:17 phantom Exp $
# $FreeBSDde: de-www/Makefile,v 1.23 2004/05/03 22:58:44 brueffer Exp $
# basiert auf: 1.111

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  applications.sgml
DOCS+= availability.sgml
DOCS+= features.sgml
DOCS+= internet.sgml
DOCS+= mailto.sgml
DOCS+= relnotes.sgml
DOCS+= where.sgml

# These will be directly installed.

#DATA=	favicon.ico
#DATA+=	robots.txt
#DATA+=	freebsd.css
#DATA+=	vendors.html

# Subdirectories
# SGML
SUBDIR= news
SUBDIR+= FAQ
SUBDIR+= handbook
SUBDIR+= platforms
SUBDIR+= releases
SUBDIR+= security
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
#SUBDIR+= ports
SUBDIR+= doc
.endif
.if defined(BUILD_RELNOTES)
SUBDIR+= relnotes
.endif

# Non-SGML
SUBDIR+= gifs

WEBDIR?=	data/de

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

index.html: index.xsl ${XML_INCLUDES}\
		${XML_NEWS_INCLUDES} ${XML_NEWS_NEWS} ${XML_NEWS_PRESS}\
		${XML_MIRRORS} ${XML_TRANSTABLE} ${XML_ADVISORIES} ${XML_NAVIGATION}
	${XSLTPROC} ${XSLTPROCOPTS} \
		-o $@ \
		--param mirrors.xml "'${XML_MIRRORS}'" \
		--param advisories.xml "'${XML_ADVISORIES}'" \
		--param news.press.xml "'${XML_NEWS_PRESS}'" \
		--param news.project.xml "'${XML_NEWS_NEWS}'" \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		--param navigation.xml "'${XML_NAVIGATION}'" \
		${.CURDIR}/index.xsl ${XML_NEWS_NEWS}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

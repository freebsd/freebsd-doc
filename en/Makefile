# $FreeBSD: www/en/Makefile,v 1.108 2004/04/05 14:21:26 phantom Exp $

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  applications.sgml
DOCS+= auditors.sgml
DOCS+= availability.sgml
DOCS+= docs.sgml 
DOCS+= features.sgml
DOCS+= register.sgml
DOCS+= internet.sgml 
DOCS+= mailto.sgml 
DOCS+= publish.sgml
DOCS+= relnotes.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml 
DOCS+= y2kbug.sgml 

# These will be directly installed.

DATA=	favicon.ico
DATA+=	robots.txt
DATA+=	freebsd.css
DATA+=  vendors.html

# Subdirectories
# SGML
SUBDIR=	 security
SUBDIR+= commercial
SUBDIR+= docproj
SUBDIR+= news
SUBDIR+= advocacy

SUBDIR+= events
SUBDIR+= FAQ
SUBDIR+= handbook
SUBDIR+= tutorials
SUBDIR+= internal
SUBDIR+= java
SUBDIR+= copyright
SUBDIR+= search
SUBDIR+= gallery
SUBDIR+= projects
SUBDIR+= prstats
SUBDIR+= platforms
SUBDIR+= releases
SUBDIR+= releng
SUBDIR+= smp
SUBDIR+= kse
SUBDIR+= gnome
SUBDIR+= donations
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
SUBDIR+= doc
.endif
.if defined(BUILD_RELNOTES)
SUBDIR+= relnotes
.endif

# Non-SGML
SUBDIR+= gifs
SUBDIR+= cgi

WEB_LANG?=	da de es fr it ja pt_BR ru tr zh

# Non-English

.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.for DIR in ${WEB_LANG}
SUBDIR+=	../${DIR}
.endfor
.endif

WEBDIR?=	data

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

#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD: www/ru/Makefile,v 1.41 2004/11/02 08:53:08 den Exp $
# $FreeBSDru: frdp/www/ru/Makefile,v 1.38 2004/10/22 12:33:49 den Exp $
#
# Original revision: 1.114
#

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  applications.sgml
DOCS+= art.sgml
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

# Subdirectories
# SGML
SUBDIR=  security
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
#SUBDIR+= prstats
SUBDIR+= platforms
SUBDIR+= releases
SUBDIR+= releng
SUBDIR+= smp
SUBDIR+= kse
#SUBDIR+= gnome
SUBDIR+= donations
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
SUBDIR+= doc
.endif
.if defined(BUILD_RELNOTES)
SUBDIR+= relnotes
.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

WEBDIR?=	data/ru

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# Use English versions for index.html (see also index.xsl and includes.xsl)
XML_NEWS_PRESS=		${XML_NEWS_PRESS_MASTER}

index.html: index.xsl ${XML_INCLUDES}\
		${XML_NEWS_INCLUDES} \
		${XML_NEWS_NEWS} ${XML_NEWS_NEWS_MASTER} \
		${XML_NEWS_PRESS} ${XML_NEWS_PRESS_MASTER} \
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
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		--param navigation.xml "'${XML_NAVIGATION}'" \
		${.CURDIR}/index.xsl ${XML_NEWS_NEWS}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

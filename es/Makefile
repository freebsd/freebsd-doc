# $FreeBSD$

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

index.html: index.xsl ${XML_INCLUDES} \
		${XML_NEWS_INCLUDES_MASTER} ${XML_NEWS_NEWS_MASTER} ${XML_NEWS_PRESS_MASTER} \
		${XML_MIRRORS} ${XML_TRANSTABLE} ${XML_ADVISORIES}
	${XSLTPROC} ${XSLTPROCOPTS} \
		-o $@ \
		--param mirrors.xml "'${XML_MIRRORS}'" \
		--param advisories.xml "'${XML_ADVISORIES}'" \
		--param news.press.xml "'${XML_NEWS_PRESS_MASTER}'" \
		--param news.project.xml "'${XML_NEWS_NEWS_MASTER}'" \
		--param transtable.xml "'${XML_TRANSTABLE}'" \
		${.CURDIR}/index.xsl ${XML_NEWS_NEWS_MASTER}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

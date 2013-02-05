# $FreeBSD$

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.xml
DOCS+= applications.xml
DOCS+= availability.xml
DOCS+= community.xml
DOCS+= docs.xml
DOCS+= features.xml
DOCS+= internet.xml
DOCS+= mailto.xml
DOCS+= publish.xml
DOCS+= send-pr.xml
DOCS+= support.xml
DOCS+= where.xml

CLEANFILES+=atoz.xml site.xml

# Subdirectories
# XML
SUBDIR=  security
SUBDIR+= docproj
SUBDIR+= news
SUBDIR+= internal
SUBDIR+= copyright
SUBDIR+= search
SUBDIR+= platforms
SUBDIR+= projects
SUBDIR+= releases

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
.endif

WEBDIR?=	data/es

# index.html is special, and generated from index.xsl and news/news.xml
DATA+=		index.html
CLEANFILES+=	index.html

XMLDOCS=		index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=	transtable mirrors news press events \
			advisories notices

.include "${DOC_PREFIX}/share/mk/web.site.mk"

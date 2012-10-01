# $FreeBSD$
# The FreeBSD Russian Documentation Project
# $FreeBSDru: frdp/www/ru/search/Makefile,v 1.3 2003/09/22 09:27:00 den Exp $
# Original revision: 1.9

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= index-site.xml
DOCS+= search.xml
DOCS+= searchhints.xml
DOCS+= search-mid.xml

INDEXLINK=	search.html

XMLDOCS=	index-site:xsl:sitemap.xml

.include "${DOC_PREFIX}/share/mk/web.site.mk"

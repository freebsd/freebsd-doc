# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= search.xml
DOCS+= searchhints.xml
DOCS+=	search-mid.xml

INDEXLINK=	search.html

XMLDOCS=	index-site:xsl:sitemap.xml
.include "${DOC_PREFIX}/share/mk/web.site.mk"

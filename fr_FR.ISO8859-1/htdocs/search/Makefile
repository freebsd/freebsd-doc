# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.9

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= index-site.sgml
DOCS+= search.sgml
DOCS+= searchhints.sgml
DOCS+=	search-mid.sgml

INDEXLINK=	search.html

XMLDOCS=	index-site:xsl:sitemap.xml

.include "${DOC_PREFIX}/share/mk/web.site.mk"

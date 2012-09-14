# $FreeBSD$
# The FreeBSD Japanese Documentation Project
# Original revision: 1.10

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS+= index-site.sgml
DOCS+= search.sgml
DOCS+= searchhints.sgml
DOCS+= search-mid.sgml

#SUBDIR+= opensearch

INDEXLINK=      search.html

XMLDOCS=	index-site:xsl:sitemap.xml

.include "${DOC_PREFIX}/share/mk/web.site.mk"

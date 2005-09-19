# $FreeBSD$
# $FreeBSDde: de-www/news/Makefile,v 1.9 2005/09/18 10:33:54 jkois Exp $
# basiert auf: 1.42

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= news.sgml

INDEXLINK= news.html

SRCS.DEFAULT=           includes.xsl
DEPENDSET.DEFAULT=      transtable news
 
XMLDOCS=        newsflash::news.xml:
XMLDOCS+=       news-rdf::news.xml:news.rdf
XMLDOCS+=       press

SUBDIR= 	2002

.include "${WEB_PREFIX}/share/mk/web.site.mk"


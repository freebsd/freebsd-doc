# $FreeBSD$
# $FreeBSDde: de-www/news/Makefile,v 1.10 2005/09/20 04:16:39 jkois Exp $
# basiert auf: 1.43

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= news.sgml

INDEXLINK= news.html

SRCS.DEFAULT=           includes.xsl
DEPENDSET.DEFAULT=      transtable news press

XMLDOCS=        newsflash::news.xml:
XMLDOCS+=       news-rdf::news.xml:news.rdf
XMLDOCS+=       press

SUBDIR= 	2002

.include "${WEB_PREFIX}/share/mk/web.site.mk"


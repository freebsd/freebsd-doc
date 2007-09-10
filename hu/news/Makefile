# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= news.sgml
DOCS+= pressreleases.sgml

INDEXLINK= news.html

DEPENDSET.DEFAULT=	transtable news press

XMLDOCS=	newsflash:${XSL_NEWS_NEWSFLASH}:${XML_NEWS_NEWS_MASTER}:
XMLDOCS+=	news-rdf:${XSL_NEWS_NEWS_RDF}:${XML_NEWS_NEWS_MASTER}:news.rdf
XMLDOCS+=	press:${XSL_NEWS_PRESS}:${XML_NEWS_PRESS_MASTER}:

.include "${WEB_PREFIX}/share/mk/web.site.mk"

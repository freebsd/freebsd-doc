# $FreeBSD$
# $FreeBSDde: de-www/news/Makefile,v 1.14 2008/08/23 13:20:15 jkois Exp $
# basiert auf: 1.50

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= news.sgml

#Subdirs fuer alte News
SUBDIR=  2006
SUBDIR+= 2005
SUBDIR+= 2004
SUBDIR+= 2003
SUBDIR+= 2002

INDEXLINK= news.html

DEPENDSET.DEFAULT=	transtable news press

XMLDOCS=	newsflash:${XSL_NEWS_NEWSFLASH}:${XML_NEWS_NEWS_MASTER}:
XMLDOCS+=	news-rdf:${XSL_NEWS_NEWS_RDF}:${XML_NEWS_NEWS_MASTER}:news.rdf
XMLDOCS+=	news-rss:${XSL_NEWS_NEWS_RSS}:${XML_NEWS_NEWS_MASTER}:rss.xml
XMLDOCS+=	press:${XSL_NEWS_PRESS}:${XML_NEWS_PRESS_MASTER}:
XMLDOCS+=	press-rss:${XSL_NEWS_PRESS_RSS}:${XML_NEWS_PRESS_MASTER}:press-rss.xml

.include "${WEB_PREFIX}/share/mk/web.site.mk"


#
# %SOURCE%  en/news/Makefile
# %SRCID%   1.53
#
# $FreeBSD: www/hu/news/Makefile,v 1.2 2009/04/06 17:56:08 pgj Exp $

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

XMLDOCS=	newsflash:../share/sgml/templates.newsflash.xsl:${XML_NEWS_NEWS}:
XMLDOCS+=	news-rdf:../share/sgml/templates.news-rdf.xsl:${XML_NEWS_NEWS}:news.rdf
XMLDOCS+=	news-rss:../share/sgml/templates.news-rss.xsl:${XML_NEWS_NEWS}:rss.xml
XMLDOCS+=	press:../share/sgml/templates.press.xsl:${XML_NEWS_PRESS}:
XMLDOCS+=	press-rss:../share/sgml/templates.press-rss.xsl:${XML_NEWS_PRESS}:press-rss.xml

SUBDIR+=	2008
SUBDIR+=	2009

.include "${WEB_PREFIX}/share/mk/web.site.mk"

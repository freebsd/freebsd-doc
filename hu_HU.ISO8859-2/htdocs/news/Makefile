#
# %SOURCE%  en/news/Makefile
# %SRCID%   1.53
#
# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= news.xml
DOCS+= pressreleases.xml

INDEXLINK= news.html

DEPENDSET.DEFAULT=	transtable news press

XMLDOCS=	newsflash:${DOC_PREFIX}/${LANGCODE}/share/xml/templates.newsflash.xsl:${XML_NEWS_NEWS}:
XMLDOCS+=	news-rdf:${DOC_PREFIX}/${LANGCODE}/share/xml/templates.news-rdf.xsl:${XML_NEWS_NEWS}:news.rdf
XMLDOCS+=	news-rss:${DOC_PREFIX}/${LANGCODE}/share/xml/templates.news-rss.xsl:${XML_NEWS_NEWS}:rss.xml
XMLDOCS+=	press:${DOC_PREFIX}/${LANGCODE}/share/xml/templates.press.xsl:${XML_NEWS_PRESS}:
XMLDOCS+=	press-rss:${DOC_PREFIX}/${LANGCODE}/share/xml/templates.press-rss.xsl:${XML_NEWS_PRESS}:press-rss.xml

SUBDIR+=	2008
SUBDIR+=	2009

.include "${DOC_PREFIX}/share/mk/web.site.mk"

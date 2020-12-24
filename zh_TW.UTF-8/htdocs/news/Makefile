# $FreeBSD$
# Original Revision: 241f52fcf4 (r40052)

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS+= news.xml

# press releases
#DOCS+= pressreleases.xml
#DOCS+= press-rel-1.xml
#DOCS+= press-rel-2.xml
#DOCS+= press-rel-3.xml
#DOCS+= press-rel-4.xml
#DOCS+= press-rel-5.xml
#DOCS+= press-rel-6.xml
#DOCS+= press-rel-7.xml
#DOCS+= press-rel-8.xml
#DOCS+= press-rel-9.xml

# The yearly State of the Union address
#DOCS+=	sou1999.xml

# Details of the FreeBSD.org 2012 Infrastructure compromise
#DOCS+=	2012-compromise.xml

#INDEXLINK= news.html

DEPENDSET.DEFAULT=	transtable news press

XMLDOCS=	newsflash:${XSL_NEWS_NEWSFLASH}:${XML_NEWS_NEWS_MASTER}:
XMLDOCS+=	news-rdf:${XSL_NEWS_NEWS_RDF}:${XML_NEWS_NEWS_MASTER}:news.rdf
#XMLDOCS+=	news-rss:${DOC_PREFIX}/${LANGCODE}/share/xml/templates.news-rss.xsl:${DOC_PREFIX}/${LANGCODE}/share/xml/news.xml:rss.xml
XMLDOCS+=	press:${XSL_NEWS_PRESS}:${XML_NEWS_PRESS_MASTER}:
XMLDOCS+=	press-rss:${XSL_NEWS_PRESS_RSS}:${XML_NEWS_PRESS_MASTER}:press-rss.xml

#SUBDIR= 	1993
#SUBDIR+= 	1996
#SUBDIR+= 	1997
#SUBDIR+= 	1998
#SUBDIR+= 	1999
#SUBDIR+= 	2000
#SUBDIR+= 	2001
#SUBDIR+= 	2002
#SUBDIR+= 	2003
#SUBDIR+= 	2004
#SUBDIR+= 	2005
#SUBDIR+= 	2006
#SUBDIR+= 	2007
#SUBDIR+=	2008
#SUBDIR+=	2009
#SUBDIR+=	status

.include "${DOC_PREFIX}/share/mk/web.site.mk"


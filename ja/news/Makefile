# $FreeBSD: www/ja/news/Makefile,v 1.39 2010/06/04 17:35:53 ryusuke Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.38

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= news.sgml

# press releases
DOCS+= pressreleases.sgml
DOCS+= press-rel-1.sgml
DOCS+= press-rel-2.sgml
DOCS+= press-rel-3.sgml
DOCS+= press-rel-4.sgml
DOCS+= press-rel-5.sgml
#DOCS+= press-rel-6.sgml
#DOCS+= press-rel-7.sgml

# The yearly State of the Union address
#DOCS+=	sou1999.sgml

INDEXLINK= news.html

DEPENDSET.DEFAULT=	transtable news press

XMLDOCS=	newsflash:${XSL_NEWS_NEWSFLASH}:${XML_NEWS_NEWS_MASTER}:
XMLDOCS+=	news-rdf:${XSL_NEWS_NEWS_RDF}:${XML_NEWS_NEWS_MASTER}:news.rdf
XMLDOCS+=	news-rss:../share/sgml/templates.news-rss.xsl:../share/sgml/news.xml:rss.xml
XMLDOCS+=	press:${XSL_NEWS_PRESS}:${XML_NEWS_PRESS_MASTER}:
XMLDOCS+=	press-rss:${XSL_NEWS_PRESS_RSS}:${XML_NEWS_PRESS_MASTER}:press-rss.xml

#SUBDIR= 	1993
SUBDIR+= 	1996
SUBDIR+= 	1997
#SUBDIR+= 	1998
#SUBDIR+= 	1999
#SUBDIR+= 	2000
SUBDIR+= 	2001
#SUBDIR+= 	2002
#SUBDIR+=	status

### Revision checking
REVCHECK=	YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"


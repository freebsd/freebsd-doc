# $FreeBSD: www/ja/news/2001/Makefile,v 1.1 2010/06/04 17:35:53 ryusuke Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#XMLDOCS+=	index:${XSL_NEWS_NEWSFLASH_OLD}:news.xml:
XMLDOCS+=	index:${DOC_PREFIX}/${LANGCODE}/share/sgml/templates.oldnewsflash.xsl:news.xml:
DEPENDSET.index=transtable news

XMLDOCS+=	press:${DOC_PREFIX}/${LANGCODE}/share/sgml/templates.oldpress.xsl::
DEPENDSET.press=transtable press

.include "${DOC_PREFIX}/share/mk/web.site.mk"

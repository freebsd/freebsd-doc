# $FreeBSD$
# The FreeBSD Japanese Documentation Project
# Original revision: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#XMLDOCS+=	index:${XSL_NEWS_NEWSFLASH_OLD}:news.xml:
XMLDOCS+=	index:${DOC_PREFIX}/${LANGCODE}/share/xml/templates.oldnewsflash.xsl:news.xml:
DEPENDSET.index=transtable news

XMLDOCS+=	press:${DOC_PREFIX}/${LANGCODE}/share/xml/templates.oldpress.xsl::
DEPENDSET.press=transtable press

.include "${DOC_PREFIX}/share/mk/web.site.mk"

# $FreeBSD$
# $FreeBSDde: de-www/news/2008/Makefile,v 1.2 2009/03/18 22:05:56 jkois Exp $
# basiert auf: 1.2

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XMLDOCS+=	index:${XSL_NEWS_NEWSFLASH_OLD}:news.xml:
DEPENDSET.index=transtable news

#XMLDOCS+=	press:${XSL_NEWS_PRESS_OLD}::
#DEPENDSET.press=transtable press

.include "${WEB_PREFIX}/share/mk/web.site.mk"

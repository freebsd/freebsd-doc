# $FreeBSD$
# $FreeBSDde: de-www/news/2009/Makefile,v 1.1 2010/03/05 08:47:25 jkois Exp $
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

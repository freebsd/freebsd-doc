# $FreeBSD: www/de/news/2002/Makefile,v 1.3 2005/09/19 16:55:28 jkois Exp $
# $FreeBSDde: de-www/news/2002/Makefile,v 1.3 2005/09/18 10:33:54 jkois Exp $
# basiert auf: 1.5

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XMLDOCS+=	index:${XSL_NEWS_NEWSFLASH_OLD}:news.xml:
DEPENDSET.index=transtable news

.include "${WEB_PREFIX}/share/mk/web.site.mk"

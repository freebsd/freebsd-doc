# $FreeBSD: www/en/news/2008/Makefile,v 1.1 2009/02/11 17:15:28 pgj Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XMLDOCS+=	index:${XSL_NEWS_NEWSFLASH_OLD}:news.xml:
DEPENDSET.index=transtable news

.include "${WEB_PREFIX}/share/mk/web.site.mk"

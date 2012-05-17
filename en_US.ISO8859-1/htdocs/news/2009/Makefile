# $FreeBSD: www/en/news/2009/Makefile,v 1.1 2010/03/05 00:17:57 danger Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XMLDOCS+=	index:${XSL_NEWS_NEWSFLASH_OLD}:news.xml:
DEPENDSET.index=transtable news

.include "${DOC_PREFIX}/share/mk/web.site.mk"
DEPENDSET.press=transtable press

.include "${WEB_PREFIX}/share/mk/web.site.mk"

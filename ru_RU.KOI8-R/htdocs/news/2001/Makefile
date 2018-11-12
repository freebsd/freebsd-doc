# $FreeBSD$
# $FreeBSDru: frdp/www/ru/news/2001/Makefile,v 1.4 2004/04/09 11:16:51 phantom Exp $
# Original revision: 1.3

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XMLDOCS+=	index:${XSL_NEWS_NEWSFLASH_OLD}:news.xml:
DEPENDSET.index=transtable news

XMLDOCS+=	press:${XSL_NEWS_PRESS_OLD}::
DEPENDSET.press=transtable press

.include "${DOC_PREFIX}/share/mk/web.site.mk"

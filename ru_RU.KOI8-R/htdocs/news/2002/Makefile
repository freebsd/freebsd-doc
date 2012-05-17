#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD: www/ru/news/2002/Makefile,v 1.3 2004/04/09 12:03:23 phantom Exp $
# $FreeBSDru: frdp/www/ru/news/2002/Makefile,v 1.4 2004/04/09 11:16:52 phantom Exp $
#
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

.include "${WEB_PREFIX}/share/mk/web.site.mk"

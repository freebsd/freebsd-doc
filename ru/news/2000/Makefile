# $FreeBSD: www/ru/news/2000/Makefile,v 1.2 2004/04/09 12:03:23 phantom Exp $
# The FreeBSD Russian Documentation Project
# $FreeBSDru: frdp/www/ru/news/2000/Makefile,v 1.3 2004/04/09 11:16:51 phantom Exp $
# Original revision: 1.3

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif
 
DOCS=	index.sgml

XMLDOCS+=	press:${XSL_NEWS_PRESS_OLD}::
DEPENDSET.press=transtable press

.include "${WEB_PREFIX}/share/mk/web.site.mk"

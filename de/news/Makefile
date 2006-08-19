# $FreeBSD: www/de/news/Makefile,v 1.7 2005/09/20 04:39:37 jkois Exp $
# $FreeBSDde: de-www/news/Makefile,v 1.10 2005/09/20 04:16:39 jkois Exp $
# basiert auf: 1.43

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= news.sgml

INDEXLINK= news.html

DEPENDSET.DEFAULT=	transtable news press

XMLDOCS=	newsflash:${XSL_NEWS_NEWSFLASH}:${XML_NEWS_NEWS_MASTER}:
XMLDOCS+=	press:${XSL_NEWS_PRESS}:${XML_NEWS_PRESS_MASTER}:

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD$
# $FreeBSDde: de-www/news/Makefile,v 1.13 2008/01/12 20:51:38 jkois Exp $
# basiert auf: 1.48

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= news.sgml

#Subdirs fuer alte News
SUBDIR=  2006
SUBDIR+= 2005
SUBDIR+= 2004
SUBDIR+= 2003
SUBDIR+= 2002

INDEXLINK= news.html

DEPENDSET.DEFAULT=	transtable news press

XMLDOCS=	newsflash:${XSL_NEWS_NEWSFLASH}:${XML_NEWS_NEWS_MASTER}:
XMLDOCS+=	press:${XSL_NEWS_PRESS}:${XML_NEWS_PRESS_MASTER}:

.include "${WEB_PREFIX}/share/mk/web.site.mk"


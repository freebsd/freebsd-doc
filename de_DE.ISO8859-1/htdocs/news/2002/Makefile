# $FreeBSD$
# $FreeBSDde: de-www/news/2002/Makefile,v 1.4 2006/10/19 19:26:02 jkois Exp $
# basiert auf: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XMLDOCS+=	index:${XSL_NEWS_NEWSFLASH_OLD}:news.xml:
DEPENDSET.index=transtable news

.include "${DOC_PREFIX}/share/mk/web.site.mk"

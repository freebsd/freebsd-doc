# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.1

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XMLDOCS+=	index:${XSL_NEWS_NEWSFLASH_OLD}:news.xml:
DEPENDSET.index=transtable news

.include "${DOC_PREFIX}/share/mk/web.site.mk"

#
# %SOURCE%  en/news/2009/Makefile
# %SRCID%   1.1
#
# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XMLDOCS+=	index:${DOC_PREFIX}/${LANGCODE}/share/xml/templates.oldnewsflash.xsl:news.xml:
DEPENDSET.index=transtable news

.include "${DOC_PREFIX}/share/mk/web.site.mk"

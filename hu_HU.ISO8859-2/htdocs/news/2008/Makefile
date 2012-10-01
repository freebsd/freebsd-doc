#
# %SOURCE%  en/news/2008/Makefile
# %SRCID%   1.3
#
# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XMLDOCS+=	press:${DOC_PREFIX}/${LANGCODE}/share/xml/templates.oldpress.xsl::
DEPENDSET.press=transtable press

.include "${DOC_PREFIX}/share/mk/web.site.mk"

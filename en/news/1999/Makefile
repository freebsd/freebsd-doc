# $FreeBSD: www/en/news/1999/Makefile,v 1.3 2004/04/07 11:41:47 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	index.sgml

XMLDOCS=	press:../oldpress.xsl::
SRCS.press=	../includes.xsl
DEPENDSET.press=	transtable

.include "${WEB_PREFIX}/share/mk/web.site.mk"

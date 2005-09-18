# $FreeBSD: www/en/news/2003/Makefile,v 1.1 2005/04/19 21:19:03 brueffer Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XMLDOCS=	index:../oldpress.xsl:news.xml:
SRCS.index=	../includes.xsl
DEPENDSET.index=	transtable

XMLDOCS+=	press:../oldpress.xsl::
SRCS.press=	../includes.xsl
DEPENDSET.press=	transtable

.include "${WEB_PREFIX}/share/mk/web.site.mk"

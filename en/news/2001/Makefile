# $FreeBSD: www/en/news/2001/Makefile,v 1.5 2005/09/18 04:33:46 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=		index.html
CLEANFILES+=	index.html

XMLDOCS=	index:../oldnewsflash.xsl:news.xml:
SRCS.index=	../includes.xsl
DEPENDSET.index=	transtable

XMLDOCS+=	press:../oldpress.xsl::
SRCS.press=	../includes.xsl
DEPENDSET.press=	transtable

.include "${WEB_PREFIX}/share/mk/web.site.mk"

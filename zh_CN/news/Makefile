# The FreeBSD Simplified Chinese Documentation Project
# Original Revision: 1.45
#
# $FreeBSD: www/zh_CN/news/Makefile,v 1.1.1002.5 2006/01/28 18:27:53 delphij Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= news.sgml

# press releases
DOCS+= pressreleases.sgml

INDEXLINK= news.html

SRCS.DEFAULT=		includes.xsl
DEPENDSET.DEFAULT=	transtable news press

XMLDOCS=	newsflash::news.xml:
XMLDOCS+=	news-rdf::news.xml:news.rdf
XMLDOCS+=	press

.include "${WEB_PREFIX}/share/mk/web.site.mk"

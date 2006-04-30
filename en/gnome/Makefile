# $FreeBSD: www/en/gnome/Makefile,v 1.23 2006/01/01 20:32:17 adamw Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=		docs
SUBDIR+=	images

DOCS=	screenshots.sgml
DOCS+=	contact.sgml

DATA=	gnomelogalyzer.sh

SGML_INCLUDES+=	includes.navgnome.sgml

SRCS.DEFAULT=	includes.xsl
SRCS.DEFAULT+=	includes.navgnome.xsl
XML.DEFAULT=	news.xml

XMLDOCS=	index
XSLTPROCOPTS.index=	${XSLTPROCOPTS:N--nonet}

XMLDOCS+=	newsflash
XMLDOCS+=	news:rss.xsl::news.rdf

.include "${WEB_PREFIX}/share/mk/web.site.mk"

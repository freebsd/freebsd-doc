# $FreeBSD: www/en/gnome/Makefile,v 1.20 2004/11/25 04:29:18 marcus Exp $

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

DATA=	gnome_upgrade.sh
DATA+=	gnomelogalyzer.sh

SRCS.DEFAULT=	includes.xsl
XML.DEFAULT=	news.xml

XMLDOCS=	index
XSLTPROCOPTS.index=	${XSLTPROCOPTS:N--nonet}

XMLDOCS+=	newsflash
XMLDOCS+=	news:rss.xsl::news.rdf

.include "${WEB_PREFIX}/share/mk/web.site.mk"

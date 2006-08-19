# $FreeBSD: www/en/gnome/Makefile,v 1.24 2006/04/30 19:27:32 marcus Exp $

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

XML.DEFAULT=	news.xml

XMLDOCS=	index
XSLTPROCOPTS.index=	${XSLTPROCOPTS:N--nonet}

XMLDOCS+=	newsflash
XMLDOCS+=	news:rss.xsl::news.rdf

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD: www/en/gnome/Makefile,v 1.21 2005/09/18 04:33:45 hrs Exp $

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
SRCS.DEFAULT+=	includes.navgnome.xsl
XML.DEFAULT=	news.xml

XMLDOCS=	index
XSLTPROCOPTS.index=	${XSLTPROCOPTS:N--nonet}

XMLDOCS+=	newsflash
XMLDOCS+=	news:rss.xsl::news.rdf

.include "${WEB_PREFIX}/share/mk/web.site.mk"

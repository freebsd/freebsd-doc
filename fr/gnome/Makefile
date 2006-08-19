# $FreeBSD: www/fr/gnome/Makefile,v 1.2 2006/01/09 19:54:30 blackend Exp $

# The FreeBSD French Documentation Project
# Original revision: 1.23

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=		docs
# SUBDIR+=	images

DOCS=	screenshots.sgml
DOCS+=	contact.sgml

# DATA=	gnome_upgrade.sh
# DATA+=	gnomelogalyzer.sh

XML.DEFAULT=	news.xml

XMLDOCS=	index
XSLTPROCOPTS.index=	${XSLTPROCOPTS:N--nonet}

XMLDOCS+=	newsflash
XMLDOCS+=	news:rss.xsl::news.rdf

.include "${WEB_PREFIX}/share/mk/web.site.mk"

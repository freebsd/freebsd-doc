# $FreeBSD: www/es/gnome/Makefile,v 1.2 2004/03/04 16:36:12 jesusr Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR=		docs
#SUBDIR+=	images

DOCS=	screenshots.sgml
DOCS+=	contact.sgml

DATA=	index.html newsflash.html

CLEANFILES=	index.html
CLEANFILES+=	newsflash.html

XML.DEFAULT=	news.xml

XMLDOCS=	index
XSLTPROCOPTS.index=	${XSLTPROCOPTS:N--nonet}

XMLDOCS+=	newsflash

.include "${WEB_PREFIX}/share/mk/web.site.mk"

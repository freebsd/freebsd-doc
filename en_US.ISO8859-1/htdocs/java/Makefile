# $FreeBSD: www/en/java/Makefile,v 1.4 2004/05/13 20:52:49 simon Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR =	dists
SUBDIR+=	docs
SUBDIR+=	links

DOCS =  advocacy.sgml
DOCS+=  howhelp.sgml
DOCS+=  index.sgml
DOCS+=  install.sgml

DATA=	j2j.gif

XML.DEFAULT=	news.xml
XMLDOCS=	newsflash
XMLDOCS+=	news:java-rss.xsl::rss.xml

.include "${DOC_PREFIX}/share/mk/web.site.mk"

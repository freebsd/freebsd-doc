# $FreeBSD: www/ja/java/Makefile,v 1.13 2011/03/13 05:15:29 ryusuke Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.5

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR =	dists
#SUBDIR+=	docs
SUBDIR+=	links

DOCS =  advocacy.sgml
DOCS+=  howhelp.sgml
DOCS+=  index.sgml
DOCS+=  install.sgml

XML.DEFAULT=	news.xml
XMLDOCS=	newsflash
XMLDOCS+=	news:java-rss.xsl::rss.xml

### Revision checking
REVCHECK= YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"

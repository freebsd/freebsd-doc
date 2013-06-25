# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR =	dists

DOCS =  advocacy.xml
DOCS+=  howhelp.xml
DOCS+=  index.xml
DOCS+=  install.xml
DOCS+=	links.xml

DATA=	j2j.gif

XML.DEFAULT=	news.xml
XMLDOCS=	newsflash
XMLDOCS+=	news:java-rss.xsl::rss.xml

.include "${DOC_PREFIX}/share/mk/web.site.mk"

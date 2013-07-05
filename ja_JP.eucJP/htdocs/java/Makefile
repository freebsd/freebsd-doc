# $FreeBSD$
# The FreeBSD Japanese Documentation Project
# Original revision: r42048

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR =	dists

DOCS+=  howhelp.xml
DOCS+=  index.xml
DOCS+=  install.xml
DOCS+=	links.xml

XML.DEFAULT=	news.xml
XMLDOCS=	newsflash
XMLDOCS+=	news:java-rss.xsl::rss.xml

.include "${DOC_PREFIX}/share/mk/web.site.mk"

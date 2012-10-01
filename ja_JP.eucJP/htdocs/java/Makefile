# $FreeBSD$
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

DOCS =  advocacy.xml
DOCS+=  howhelp.xml
DOCS+=  index.xml
DOCS+=  install.xml

XML.DEFAULT=	news.xml
XMLDOCS=	newsflash
XMLDOCS+=	news:java-rss.xsl::rss.xml

.include "${DOC_PREFIX}/share/mk/web.site.mk"

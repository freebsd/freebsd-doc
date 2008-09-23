# $FreeBSD: www/en/search/opensearch/Makefile,v 1.2 2008/09/22 20:00:09 wosch Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= 		opensearch.sgml 
INDEXLINK=	opensearch.html

DATA=
DATA+=	opensearch.js

DATA+=	man.xml
DATA+=	ports.xml 
DATA+=	query-pr.xml
DATA+=	web.xml
DATA+=	web-all.xml

# external sites
DATA+=	markmail.xml
DATA+=	rambler.xml

.include "${WEB_PREFIX}/share/mk/web.site.mk"

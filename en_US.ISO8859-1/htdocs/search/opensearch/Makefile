# $FreeBSD: www/en/search/opensearch/Makefile,v 1.6 2009/03/22 14:53:36 wosch Exp $

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
DATA+=	man-freebsd-release-ports.xml
DATA+=	ports.xml 
DATA+=	query-pr.xml
DATA+=	web.xml
DATA+=	web-all.xml
DATA+=	message-id.xml
DATA+=	cvsweb.xml

# external sites
DATA+=	markmail.xml
DATA+=	rambler.xml
DATA+=	portoverview.xml

.include "${WEB_PREFIX}/share/mk/web.site.mk"

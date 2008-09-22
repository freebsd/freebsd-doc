# $FreeBSD: www/en/cgi/Makefile,v 1.34 2007/03/19 05:44:58 dougb Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DATA=
DATA+=	opensearch.js

DATA+=	man.xml
DATA+=	ports.xml 
DATA+=	query-pr.xml

.include "${WEB_PREFIX}/share/mk/web.site.mk"

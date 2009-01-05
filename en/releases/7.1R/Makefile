# $FreeBSD: www/en/releases/7.1R/Makefile,v 1.2 2008/12/31 06:17:26 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml schedule.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	hardware.html
DATA+=	readme.html
DATA+=	relnotes.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

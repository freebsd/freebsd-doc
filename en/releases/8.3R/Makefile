# $FreeBSD: www/en/releases/8.3R/Makefile,v 1.3 2012/04/18 08:29:52 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+=	announce.sgml \
	schedule.sgml

DATA=	docbook.css \
	errata.html \
	installation.html \
	hardware.html \
	readme.html \
	relnotes-detailed.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

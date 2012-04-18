# $FreeBSD: www/en/releases/8.3R/Makefile,v 1.2 2012/03/18 12:09:03 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS+=	announce.sgml
DOCS+=	schedule.sgml

DATA=	docbook.css \
	errata.html \
	installation.html \
	hardware.html \
	readme.html \
	relnotes-detailed.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

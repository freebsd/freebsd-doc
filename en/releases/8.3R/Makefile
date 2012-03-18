# $FreeBSD: www/en/releases/8.3R/Makefile,v 1.1 2012/02/05 11:12:40 bz Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS+=	announce.sgml
DOCS+=	schedule.sgml
#DOCS+=	relnotes.sgml

DATA=	docbook.css \
	errata.html \
	hardware.html \
	readme.html \
	relnotes-detailed.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD: www/en/releases/8.0R/Makefile,v 1.1 2009/08/05 14:29:00 rwatson Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS=	announce.sgml
DOCS+=	relnotes.sgml
DOCS+=	schedule.sgml

DATA=	docbook.css \
	errata.html \
	hardware.html \
	readme.html \
	relnotes-detailed.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

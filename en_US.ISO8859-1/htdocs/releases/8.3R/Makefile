# $FreeBSD: www/en/releases/8.3R/Makefile,v 1.4 2012/04/18 14:06:05 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+=	announce.sgml \
	relnotes.sgml \
	schedule.sgml

DATA=	docbook.css \
	errata.html \
	installation.html \
	hardware.html \
	readme.html \
	relnotes-detailed.html

.include "${DOC_PREFIX}/share/mk/web.site.mk"

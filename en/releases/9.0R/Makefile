# $FreeBSD: www/en/releases/9.0R/Makefile,v 1.5 2012/01/12 05:14:26 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	schedule.sgml \
	relnotes.sgml \
	announce.sgml

DATA=	docbook.css \
	hardware.html \
	readme.html \
	installation.html \
	errata.html \
	relnotes-detailed.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

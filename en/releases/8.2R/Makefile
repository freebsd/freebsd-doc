# $FreeBSD: www/en/releases/8.2R/Makefile,v 1.1 2010/10/22 14:30:49 kensmith Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS=	announce.sgml \
DOCS=	schedule.sgml \
	relnotes.sgml

DATA=	docbook.css \
	errata.html \
	hardware.html \
	readme.html \
	relnotes-detailed.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

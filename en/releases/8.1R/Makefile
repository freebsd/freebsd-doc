# $FreeBSD: www/en/releases/8.1R/Makefile,v 1.2 2010/07/22 01:19:31 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS=	announce.sgml
DOCS=	schedule.sgml \
	relnotes.sgml

DATA=	docbook.css \
	errata.html \
	hardware.html \
	readme.html \
	relnotes-detailed.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

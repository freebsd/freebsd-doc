# $FreeBSD: www/en/releases/8.2R/Makefile,v 1.3 2011/02/24 19:56:46 hrs Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS+=	announce.sgml
DOCS+=	schedule.sgml
#DOCS+=	relnotes.sgml

DATA=	docbook.css
#DATA+=	errata.html \
#	hardware.html \
#	readme.html \
#	relnotes-detailed.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

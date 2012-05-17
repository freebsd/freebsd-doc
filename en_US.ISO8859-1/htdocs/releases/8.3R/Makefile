# $FreeBSD$

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

# $FreeBSD$

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

.include "${DOC_PREFIX}/share/mk/web.site.mk"

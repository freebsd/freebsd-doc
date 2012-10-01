# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.xml \
	schedule.xml \
	relnotes.xml

DATA=	docbook.css \
	errata.html \
	hardware.html \
	readme.html \
	relnotes-detailed.html

.include "${DOC_PREFIX}/share/mk/web.site.mk"

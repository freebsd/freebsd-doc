# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.xml
DOCS+=	pressrelease.xml
DOCS+=	relnotes.xml
DOCS+=	schedule.xml

DATA=	docbook.css \
	errata.html \
	hardware.html \
	readme.html \
	relnotes-detailed.html

.include "${DOC_PREFIX}/share/mk/web.site.mk"

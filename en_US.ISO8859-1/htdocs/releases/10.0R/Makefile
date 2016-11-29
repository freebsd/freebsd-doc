# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.xml
DOCS+=	schedule.xml

DATA=	docbook.css \
	errata.html \
	hardware.html \
	installation.html \
	readme.html \
	relnotes.html


.include "${DOC_PREFIX}/share/mk/web.site.mk"

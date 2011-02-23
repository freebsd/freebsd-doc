# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS=	announce.sgml \
#	relnotes.sgml
DOCS=	schedule.sgml

DATA=	docbook.css \
	errata.html \
	hardware.html \
	readme.html
#	relnotes-detailed.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

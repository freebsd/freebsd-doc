# $FreeBSD: www/en/releases/4.8R/Makefile,v 1.3 2003/04/04 03:49:08 bmah Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml hardware.sgml relnotes.sgml schedule.sgml qa.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

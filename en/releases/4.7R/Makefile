# $FreeBSD: www/en/releases/4.7R/Makefile,v 1.4 2002/10/06 23:58:33 bmah Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml schedule.sgml qa.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD: www/en/releases/4.6R/Makefile,v 1.2 2002/04/11 11:12:54 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml qa.sgml schedule.sgml

DATA+=	docbook.css
DATA+=	errata.html
DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

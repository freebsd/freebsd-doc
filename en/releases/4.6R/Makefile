# $FreeBSD: www/en/releases/4.6R/Makefile,v 1.4 2002/06/15 23:44:07 bmah Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml contents.sgml
DOCS+=	hardware.sgml relnotes.sgml qa.sgml schedule.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	installation-alpha.html installation-i386.html
DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html
DATA+=	cd1.txt cd2.txt cd3.txt cd4.txt mini.txt

.include "${WEB_PREFIX}/share/mk/web.site.mk"

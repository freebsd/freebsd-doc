# $FreeBSD: www/en/releases/4.6R/Makefile,v 1.5 2004/04/05 23:52:12 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml contents.sgml
DOCS+=	hardware.sgml relnotes.sgml qa.sgml schedule.sgml
DOCS+=	installation.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	installation-alpha.html installation-i386.html
DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html
DATA+=	cd1.txt cd2.txt cd3.txt cd4.txt mini.txt

.include "${WEB_PREFIX}/share/mk/web.site.mk"

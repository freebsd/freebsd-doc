# $FreeBSD: www/en/releases/4.6R/Makefile,v 1.6 2004/04/05 23:57:54 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml
DOCS+=	contents.sgml
DOCS+=	hardware.sgml
DOCS+=	installation.sgml
DOCS+=	qa.sgml
DOCS+=	relnotes.sgml
DOCS+=	schedule.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	installation-alpha.html
DATA+=	installation-i386.html
DATA+=	hardware-alpha.html
DATA+=	hardware-i386.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

DATA+=	cd1.txt cd2.txt cd3.txt cd4.txt mini.txt

.include "${WEB_PREFIX}/share/mk/web.site.mk"

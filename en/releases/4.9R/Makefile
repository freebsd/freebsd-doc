# $FreeBSD: www/en/releases/4.9R/Makefile,v 1.5 2004/04/05 23:52:12 phantom Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml schedule.sgml todo.sgml qa.sgml
DOCS+=	announce.sgml installation.sgml


DATA=	docbook.css
DATA+=	errata.html
DATA+=	installation-alpha.html installation-i386.html
DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html
DATA+=	readme.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

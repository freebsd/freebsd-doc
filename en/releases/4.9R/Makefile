# $FreeBSD: www/en/releases/4.9R/Makefile,v 1.4 2003/10/29 07:30:30 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml schedule.sgml todo.sgml qa.sgml
DOCS+=	announce.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	installation-alpha.html installation-i386.html
DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html
DATA+=	readme.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

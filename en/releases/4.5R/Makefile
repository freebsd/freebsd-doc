# $FreeBSD: www/en/releases/4.5R/Makefile,v 1.3 2002/01/25 22:38:08 bmah Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml notes.sgml qa.sgml announce.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	hardware-alpha.html
DATA+=	hardware-i386.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

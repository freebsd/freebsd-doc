# $FreeBSD: www/en/releases/4.7R/Makefile,v 1.7 2002/10/11 06:29:47 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml relnotes.sgml schedule.sgml qa.sgml announce.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	installation-alpha.html installation-i386.html
DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html
DATA+=	readme.html
DATA+=  CHECKSUM-i386.MD5

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD: www/en/releases/4.4R/Makefile,v 1.3 2001/09/20 00:15:00 bmah Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml notes.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD: www/en/releases/4.10R/Makefile,v 1.1 2004/03/29 23:18:19 scottl Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	hardware.sgml
DOCS+=	qa.sgml
DOCS+=	relnotes.sgml
DOCS+=	schedule.sgml
DOCS+=	todo.sgml

DATA=	docbook.css

.include "${WEB_PREFIX}/share/mk/web.site.mk"

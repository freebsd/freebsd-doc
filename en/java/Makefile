# $FreeBSD: www/en/java/Makefile,v 1.3 2000/11/07 04:05:16 kuriyama Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

SUBDIR =	dists
SUBDIR+=	docs
SUBDIR+=	links

DOCS =  advocacy.sgml
DOCS+=  howhelp.sgml
DOCS+=  index.sgml
DOCS+=  install.sgml
DOCS+=  newsflash.sgml

DATA=	j2j.gif

.include "${WEB_PREFIX}/share/mk/web.site.mk"

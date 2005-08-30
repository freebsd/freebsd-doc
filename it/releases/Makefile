# $FreeBSD: www/it/releases/Makefile,v 1.5 2005/03/31 09:20:01 ale Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS?= index.sgml

SUBDIR = 4.10R 4.11R
SUBDIR+= 5.2R 5.2.1R 5.3R 5.4R

.if defined $(NEW_BUILD)
SUBDIR=
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS?= index.sgml

SUBDIR = 4.10R
SUBDIR+= 5.2R 5.2.1R 5.3R

.if defined $(NEW_BUILD)
SUBDIR=
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"

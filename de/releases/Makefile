# $FreeBSD: www/de/releases/Makefile,v 1.1 2002/12/08 16:46:16 ue Exp $
# $FreeBSDde: de-www/releases/Makefile,v 1.1 2002/12/08 00:05:54 ue Exp $
# basiert auf: 1.35

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS?=	index.sgml snapshots.sgml

SUBDIR=	4.7R 5.0R

.if defined $(NEW_BUILD)
SUBDIR=
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD$
# $FreeBSDde: de-www/releases/Makefile,v 1.8 2005/01/26 01:20:34 mheinen Exp $
# basiert auf: 1.45

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS?=	index.sgml snapshots.sgml

SUBDIR=		4.6.2R 4.7R 4.8R 4.9R 4.11R
SUBDIR+=	5.0R 5.1R 5.2R 5.3R

.if defined $(NEW_BUILD)
SUBDIR=
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"

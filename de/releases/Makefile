# $FreeBSD$
# $FreeBSDde: de-www/releases/Makefile,v 1.3 2003/08/02 09:37:12 mheinen Exp $
# basiert auf: 1.37

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS?=	index.sgml snapshots.sgml

SUBDIR=		4.7R 4.8R
SUBDIR+=	5.0R 5.1R

.if defined $(NEW_BUILD)
SUBDIR=
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"

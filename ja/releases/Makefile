# $FreeBSD: www/ja/releases/Makefile,v 1.23 2000/11/22 20:34:37 hrs Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.28

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS?=	index.sgml snapshots.sgml

#SUBDIR=	1.1 1.1.5 2.0 2.0.5R 2.1R
SUBDIR=	2.1.5R 2.1.6R 2.1.7R 2.2R
SUBDIR+=	2.2.1R 2.2.2R 2.2.5R 2.2.6R 2.2.7R 2.2.8R 3.0R 3.1R 3.2R
SUBDIR+=	3.3R 3.4R 3.5R
SUBDIR+=	4.0R 4.1R 4.1.1R 4.2R 4.3R

.if defined $(NEW_BUILD)
SUBDIR=
.endif

### Revision checking
REVCHECK=	YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"

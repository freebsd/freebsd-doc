# $FreeBSD: www/ja/releases/Makefile,v 1.19 2000/10/02 09:16:11 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.25

LOCALTOP= ..

.if exists(${LOCALTOP}/Makefile.conf)
.include "${LOCALTOP}/Makefile.conf"
.endif

DOCS?=	index.sgml snapshots.sgml

#SUBDIR=	1.1 1.1.5 2.0 2.0.5R 2.1R
SUBDIR=	2.1.5R 2.1.6R 2.1.7R 2.2R
SUBDIR+=	2.2.1R 2.2.2R 2.2.5R 2.2.6R 2.2.7R 2.2.8R 3.0R 3.1R 3.2R
SUBDIR+=	3.3R 3.4R 3.5R
SUBDIR+=	4.0R 4.1R 4.1.1R

.if defined $(NEW_BUILD)
SUBDIR=
.endif

### Revision checking
REVCHECK=	YES

.include "${LOCALTOP}/web.mk"

# $FreeBSD: www/en/releases/Makefile,v 1.24 2000/07/27 13:07:13 jkh Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS?=	index.sgml snapshots.sgml

SUBDIR=	1.1 1.1.5 2.0 2.0.5R 2.1R 2.1.5R 2.1.6R 2.1.7R 2.2R
SUBDIR+=	2.2.1R 2.2.2R 2.2.5R 2.2.6R 2.2.7R 2.2.8R 3.0R 3.1R 3.2R
SUBDIR+=	3.3R 3.4R 3.5R 4.0R 4.1R 4.1.1R

.if defined $(NEW_BUILD)
SUBDIR=
.endif

.include "../web.mk"

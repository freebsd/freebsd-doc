# $Id: Makefile,v 1.7 1999-01-12 15:39:11 motoyuki Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.16

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS?=	index.sgml snapshots.sgml

#SUBDIR=	1.1 1.1.5 2.0 2.0.5R 2.1R
SUBDIR=	2.1.5R 2.1.6R 2.1.7R 2.2R
SUBDIR+=	2.2.1R 2.2.2R 2.2.5R 2.2.6R 2.2.7R 2.2.8R 3.0R

.if defined $(NEW_BUILD)
SUBDIR=
.endif

.include "../../web.mk"

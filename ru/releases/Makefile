#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/releases/Makefile,v 1.7 2005/05/11 10:07:35 den Exp $
#
# Original revision: 1.44
#

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS?=	index.sgml snapshots.sgml

SUBDIR=	5.3R 5.4R

.if defined $(NEW_BUILD)
SUBDIR=
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"

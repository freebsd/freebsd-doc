# $FreeBSD: www/en/projects/Makefile,v 1.10 2001/11/13 09:40:02 kuriyama Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	projects.sgml
DOCS+=	updater.sgml
DOCS+=	newbies.sgml
DOCS+=	libh.sgml

INDEXLINK= projects.html

SUBDIR=	 c99

.include "${WEB_PREFIX}/share/mk/web.site.mk"

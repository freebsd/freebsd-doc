# $FreeBSD: www/en/projects/Makefile,v 1.13 2002/11/08 14:56:50 jmallett Exp $

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
DOCS+=	cvsweb.sgml

INDEXLINK= projects.html

SUBDIR=	 busdma c99 mips

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD: www/en/projects/Makefile,v 1.11 2002/04/12 05:55:20 murray Exp $

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

SUBDIR=	 c99

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD: www/en/projects/Makefile,v 1.12 2002/07/03 20:29:39 scop Exp $

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

SUBDIR=	 c99 mips

.include "${WEB_PREFIX}/share/mk/web.site.mk"

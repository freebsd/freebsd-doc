# $FreeBSD: www/en/projects/Makefile,v 1.14 2002/12/09 17:31:28 rwatson Exp $

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

SUBDIR=	 busdma c99 gnats4 mips

.include "${WEB_PREFIX}/share/mk/web.site.mk"

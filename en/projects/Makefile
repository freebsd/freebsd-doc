# $FreeBSD: www/en/projects/Makefile,v 1.16 2004/05/12 12:10:44 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	projects.sgml
DOCS+=	newbies.sgml
DOCS+=	libh.sgml
DOCS+=	cvsweb.sgml

INDEXLINK= projects.html

SUBDIR=	 busdma c99 gnats4 mips bigdisk

.include "${WEB_PREFIX}/share/mk/web.site.mk"

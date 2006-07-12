# $FreeBSD: www/en/projects/Makefile,v 1.25 2006/04/11 06:03:14 murray Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	projects.sgml
DOCS+=	newbies.sgml
DOCS+=	cvsweb.sgml
DOCS+=	summerofcode.sgml
DOCS+=	summerofcode-2005.sgml

INDEXLINK= projects.html

SUBDIR=	 acpi busdma c99 dingo gnats4 ideas mips bigdisk netperf

.include "${WEB_PREFIX}/share/mk/web.site.mk"

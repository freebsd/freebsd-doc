# $FreeBSD: www/en/projects/Makefile,v 1.19 2004/11/29 04:54:31 gnn Exp $

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

SUBDIR=	 acpi busdma c99 dingo gnats4 mips bigdisk netperf

.include "${WEB_PREFIX}/share/mk/web.site.mk"

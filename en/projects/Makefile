# $FreeBSD: www/en/projects/Makefile,v 1.21 2005/04/13 11:13:27 brueffer Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	projects.sgml
DOCS+=	newbies.sgml
DOCS+=	cvsweb.sgml

INDEXLINK= projects.html

SUBDIR=	 acpi busdma c99 dingo gnats4 mips bigdisk netperf nanobsd

.include "${WEB_PREFIX}/share/mk/web.site.mk"

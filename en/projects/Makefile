# $FreeBSD: www/en/projects/Makefile,v 1.24 2005/12/06 15:09:29 joel Exp $

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

SUBDIR=	 acpi busdma c99 dingo gnats4 ideas mips bigdisk netperf nanobsd

.include "${WEB_PREFIX}/share/mk/web.site.mk"

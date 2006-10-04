# $FreeBSD: www/en/projects/Makefile,v 1.27 2006/07/12 15:27:53 ceri Exp $

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
DOCS+=	summerofcode-2006.sgml

INDEXLINK= projects.html

SUBDIR=	 acpi busdma c99 dingo ideas mips bigdisk netperf

.include "${WEB_PREFIX}/share/mk/web.site.mk"

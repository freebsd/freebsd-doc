# $FreeBSD: www/en/projects/Makefile,v 1.17 2004/09/12 18:38:24 scottl Exp $

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

SUBDIR=	 busdma c99 gnats4 mips bigdisk netperf

.include "${WEB_PREFIX}/share/mk/web.site.mk"

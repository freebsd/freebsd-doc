# $FreeBSD: www/en/projects/Makefile,v 1.15 2004/01/14 20:13:20 ceri Exp $

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

SUBDIR=	 busdma c99 gnats4 mips

.include "${WEB_PREFIX}/share/mk/web.site.mk"

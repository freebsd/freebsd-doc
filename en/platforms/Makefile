# $FreeBSD: www/en/platforms/Makefile,v 1.4 2002/11/08 14:56:49 jmallett Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	alpha.sgml
DOCS+=	ia64.sgml
DOCS+=	index.sgml
DOCS+=	mips.sgml
DOCS+=	ppc.sgml
DOCS+=	sparc.sgml
DOCS+=	x86-64.sgml

SUBDIR=	ia64

.include "${WEB_PREFIX}/share/mk/web.site.mk"

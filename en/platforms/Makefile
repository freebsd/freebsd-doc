# $FreeBSD: www/en/platforms/Makefile,v 1.9 2004/12/15 15:09:01 trhodes Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	alpha.sgml
DOCS+=	amd64.sgml
DOCS+=	arm.sgml
DOCS+=	i386.sgml
DOCS+=	ia64.sgml
DOCS+=	index.sgml
DOCS+=	mips.sgml
DOCS+=	pc98.sgml
DOCS+=	ppc.sgml
DOCS+=	sparc.sgml
DOCS+=	x86-64.sgml

SUBDIR=	amd64
SUBDIR+=ia64

.include "${WEB_PREFIX}/share/mk/web.site.mk"

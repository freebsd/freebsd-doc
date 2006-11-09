# $FreeBSD: www/en/platforms/Makefile,v 1.11 2006/02/05 09:11:47 joel Exp $

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
DOCS+=	sun4v.sgml
DOCS+=	x86-64.sgml
DOCS+=	xbox.sgml

SUBDIR=	amd64
SUBDIR+=ia64

.include "${WEB_PREFIX}/share/mk/web.site.mk"

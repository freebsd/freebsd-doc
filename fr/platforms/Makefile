# $FreeBSD: www/fr/platforms/Makefile,v 1.3 2005/01/24 13:27:22 stephane Exp $

# The FreeBSD French Documentation Project
# Original revision: 1.11

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
DOCS+=	xbox.sgml

#SUBDIR=	amd64
SUBDIR=	ia64

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD$
# $FreeBSDde: de-www/platforms/Makefile,v 1.6 2006/11/09 19:38:06 jkois Exp $
# basiert auf: 1.12

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	alpha.sgml
DOCS+=	amd64.sgml
DOCS+=  arm.sgml
DOCS+=	ia64.sgml
DOCS+=	i386.sgml
DOCS+=	index.sgml
DOCS+=	mips.sgml
DOCS+=	pc98.sgml
DOCS+=	ppc.sgml
DOCS+=	sparc.sgml
DOCS+=  sun4v.sgml
DOCS+=	x86-64.sgml
DOCS+=  xbox.sgml

SUBDIR=	ia64

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD$
# $FreeBSDde: de-www/platforms/Makefile,v 1.2 2003/10/10 22:15:26 mheinen Exp $
# basiert auf: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	alpha.sgml
DOCS+=	amd64.sgml
DOCS+=	ia64.sgml
DOCS+=	index.sgml
DOCS+=	mips.sgml
DOCS+=	pc98.sgml
DOCS+=	ppc.sgml
DOCS+=	sparc.sgml
DOCS+=	x86-64.sgml

SUBDIR=	ia64

.include "${WEB_PREFIX}/share/mk/web.site.mk"

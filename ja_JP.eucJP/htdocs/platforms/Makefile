# $FreeBSD: www/ja/platforms/Makefile,v 1.8 2005/01/10 02:39:55 rushani Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.13

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	alpha.sgml
DOCS+=	amd64.sgml
DOCS+=	arm.sgml
#DOCS+=	i386.sgml
DOCS+=	ia64.sgml
DOCS+=	index.sgml
DOCS+=	mips.sgml
DOCS+=	pc98.sgml
DOCS+=	ppc.sgml
DOCS+=	sparc.sgml
#DOCS+=	sun4v.sgml
DOCS+=	x86-64.sgml
#DOCS+=	xbox.sgml

SUBDIR=	ia64

### Revision checking
REVCHECK=	yes

.include "${DOC_PREFIX}/share/mk/web.site.mk"

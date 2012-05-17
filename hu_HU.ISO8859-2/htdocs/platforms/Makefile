# $FreeBSD: www/hu/platforms/Makefile,v 1.1 2007/01/07 22:44:47 keramida Exp $

###################################################
# The FreeBSD Hungarian Documentation Project     #
###################################################

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
DOCS+=	index.sgml
DOCS+=	mips.sgml
DOCS+=	pc98.sgml
DOCS+=	ppc.sgml
DOCS+=	sparc.sgml
DOCS+=	sun4v.sgml
DOCS+=	xbox.sgml

SUBDIR=	ia64

.include "${DOC_PREFIX}/share/mk/web.site.mk"

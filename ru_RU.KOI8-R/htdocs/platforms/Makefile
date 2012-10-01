#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/platforms/Makefile,v 1.12 2006/06/04 14:07:20 gad Exp $
#
# Original revision: 1.11
#

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	alpha.xml
DOCS+=	amd64.xml
DOCS+=	arm.xml
DOCS+=	i386.xml
DOCS+=	ia64.xml
DOCS+=	index.xml
DOCS+=	mips.xml
DOCS+=	pc98.xml
DOCS+=	ppc.xml
DOCS+=	sparc.xml
DOCS+=	x86-64.xml
DOCS+=  xbox.xml

SUBDIR=	amd64
SUBDIR+=ia64

.include "${DOC_PREFIX}/share/mk/web.site.mk"

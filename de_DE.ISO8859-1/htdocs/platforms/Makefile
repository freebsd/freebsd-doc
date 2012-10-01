# $FreeBSD$
# $FreeBSDde: de-www/platforms/Makefile,v 1.6 2006/11/09 19:38:06 jkois Exp $
# basiert auf: 1.12

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	alpha.xml
DOCS+=	amd64.xml
DOCS+=  arm.xml
DOCS+=	ia64.xml
DOCS+=	i386.xml
DOCS+=	index.xml
DOCS+=	mips.xml
DOCS+=	pc98.xml
DOCS+=	ppc.xml
DOCS+=	sparc.xml
DOCS+=  sun4v.xml
DOCS+=	x86-64.xml
DOCS+=  xbox.xml

SUBDIR=	ia64

.include "${DOC_PREFIX}/share/mk/web.site.mk"

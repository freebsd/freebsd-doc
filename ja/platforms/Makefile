# $FreeBSD: www/ja/platforms/Makefile,v 1.1 2000/12/30 14:25:14 hrs Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.3

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	alpha.sgml
DOCS+=	ia64.sgml
DOCS+=	index.sgml
DOCS+=	ppc.sgml
#DOCS+=	sparc.sgml
DOCS+=	x86-64.sgml

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

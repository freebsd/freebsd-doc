# $FreeBSD: www/ja/platforms/Makefile,v 1.2 2002/02/17 13:20:22 kuriyama Exp $
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
DOCS+=	sparc.sgml
DOCS+=	x86-64.sgml

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

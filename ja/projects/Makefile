# $FreeBSD: www/ja/projects/Makefile,v 1.10 2000/10/02 09:16:11 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	projects.sgml
DOCS+=	mozilla.sgml
DOCS+=	newbies.sgml

INDEXLINK= projects.html

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD: www/ja/internal/Makefile,v 1.15 2000/10/02 09:16:07 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.23

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# DOCS=   photos.sgml     
DOCS+=  internal.sgml   
DOCS+=  about.sgml
DOCS+=  machines.sgml
DOCS+=  mirror.sgml
DOCS+=	statistic.sgml
DOCS+=	developer.sgml

INDEXLINK=	internal.html

# DATA+=  README.mirror

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

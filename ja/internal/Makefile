# $FreeBSD: www/ja/internal/Makefile,v 1.18 2001/05/10 02:03:05 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.28

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
#DOCS+=	bylaws.sgml
#DOCS+=	releng.sgml
#DOCS+=	releng45.sgml

INDEXLINK=	internal.html

# DATA+=  README.mirror

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

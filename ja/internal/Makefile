# $FreeBSD: www/ja/internal/Makefile,v 1.19 2002/01/03 03:30:06 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.30

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
#DOCS+=	new-account.sgml
DOCS+=	statistic.sgml
DOCS+=	developer.sgml
#DOCS+=	bylaws.sgml
#DOCS+=	releng.sgml
#DOCS+=	releng45.sgml
#DOCS+=	expire-bits.sgml

INDEXLINK=	internal.html

# DATA+=  README.mirror

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD: www/ja/internal/Makefile,v 1.20 2002/05/13 20:09:04 hrs Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.38

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
#DOCS+=	expire-bits.sgml
#DOCS+=	core-vote.sgml
#DOCS+=	trb-dispute.sgml
#DOCS+=	doceng.sgml
#DOCS+=	rtp.sgml

INDEXLINK=	internal.html

# DATA+=  README.mirror

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

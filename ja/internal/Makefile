# $FreeBSD: www/ja/internal/Makefile,v 1.14 2000/05/07 01:54:44 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.22

LOCALTOP= ..

.if exists(${LOCALTOP}/Makefile.conf)
.include "${LOCALTOP}/Makefile.conf"
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

.include "${LOCALTOP}/web.mk"

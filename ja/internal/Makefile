# $FreeBSD: www/ja/internal/Makefile,v 1.13 2000/01/22 01:20:37 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.22

.if exists(../Makefile.conf)
.include "../Makefile.conf"
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
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	internal

.include "../../web.mk"

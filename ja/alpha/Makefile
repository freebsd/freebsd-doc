# $FreeBSD: www/ja/alpha/Makefile,v 1.9 1999/09/07 15:15:46 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.6

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
 
DOCS=   alpha.sgml

INDEXLINK=alpha.html

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	alpha

.include "../../web.mk"

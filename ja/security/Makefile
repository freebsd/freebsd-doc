# $FreeBSD: www/ja/security/Makefile,v 1.10 1999/11/23 04:56:41 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.6

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS=  
DOCS+=	security.sgml

INDEXLINK= security.html

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	security

.include "../../web.mk"

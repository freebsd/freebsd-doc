# $FreeBSD: www/ja/news/1997/Makefile,v 1.1 2000/05/12 15:34:41 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.2

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS=	index.sgml

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../../..
DIR_IN_LOCAL=	news/1997

.include "../../web.mk"

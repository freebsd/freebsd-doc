# $FreeBSD: www/ja/projects/Makefile,v 1.8 1999/09/07 15:15:51 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.6

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS=	projects.sgml
DOCS+=	mozilla.sgml
DOCS+=	newbies.sgml

INDEXLINK= projects.html

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	projects

.include "../../web.mk"

# $FreeBSD: www/ja/gallery/Makefile,v 1.7 1999/09/07 15:15:48 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS = gallery.sgml

INDEXLINK= gallery.html

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	gallery

.include "../../web.mk"

# $FreeBSD: www/ja/releases/4.1R/Makefile,v 1.1 2000/08/28 21:40:16 hrs Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.1

DOCS=	announce.sgml
DOCS+=	notes.sgml
DOCS+=	errata.sgml

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../../..
DIR_IN_LOCAL=	releases/4.1R

.include "../../../web.mk"

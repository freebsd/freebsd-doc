# $FreeBSD: www/ja/java/dists/Makefile,v 1.2 2000/09/28 11:58:23 hrs Exp $

# The FreeBSD Japanese Documentation Project
# Original revision: 1.3

LOCALTOP= ../..

DOCS=	10.sgml
DOCS+=	11.sgml
DOCS+=	12.sgml
DOCS+=	13.sgml
DOCS+=	index.sgml

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../../..
DIR_IN_LOCAL=	java/dists

REVCHECK= YES

.include "${LOCALTOP}/web.mk"

# $FreeBSD: www/ja/java/Makefile,v 1.5 2000/04/27 22:47:17 kuriyama Exp $

# The FreeBSD Japanese Documentation Project
# Original revision: 1.2

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

SUBDIR =	dists
#SUBDIR+=	docs
#SUBDIR+=	links

#DOCS =  advocacy.sgml
#DOCS+=  howhelp.sgml
DOCS+=  index.sgml
DOCS+=  install.sgml
DOCS+=  newsflash.sgml
#DOCS+=  press.sgml

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	java

.include "../web.mk"

# $FreeBSD: www/ja/java/Makefile,v 1.6 2000/09/28 11:58:22 hrs Exp $

# The FreeBSD Japanese Documentation Project
# Original revision: 1.2

LOCALTOP= ..

.if exists(${LOCALTOP}/Makefile.conf)
.include "${LOCALTOP}/Makefile.conf"
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

REVCHECK= YES

.include "${LOCALTOP}/web.mk"
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	java

.include "../web.mk"

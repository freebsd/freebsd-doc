# $FreeBSD: www/ja/java/Makefile,v 1.7 2000/10/02 09:16:07 kuriyama Exp $

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

### Revision checking
REVCHECK= YES

.include "${LOCALTOP}/web.mk"

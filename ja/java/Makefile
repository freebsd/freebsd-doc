# $FreeBSD: www/ja/java/Makefile,v 1.8 2000/11/07 05:13:19 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.3

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
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

.include "${WEB_PREFIX}/share/mk/web.site.mk"

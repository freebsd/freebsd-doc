# $FreeBSD: www/ja/docproj/Makefile,v 1.13 2000/11/07 11:37:53 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.9

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=  current.sgml 
DOCS+= doc-set.sgml
#DOCS+=	handbook.sgml
DOCS+= sgml.sgml
DOCS+= submitting.sgml
DOCS+= who.sgml 
DOCS+= translations.sgml
DOCS+= docproj.sgml

INDEXLINK= docproj.html

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

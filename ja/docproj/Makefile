# $FreeBSD: www/ja/docproj/Makefile,v 1.15 2004/01/10 18:37:57 rushani Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.11

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=  current.sgml 
DOCS+= doc-set.sgml
#DOCS+=	handbook.sgml
#DOCS+=	handbook3.sgml
DOCS+= sgml.sgml
DOCS+= submitting.sgml
DOCS+= who.sgml 
DOCS+= translations.sgml
DOCS+= docproj.sgml
#DOCS+=	todo.sgml

INDEXLINK= docproj.html

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

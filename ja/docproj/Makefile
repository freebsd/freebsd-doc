# $FreeBSD: www/ja/docproj/Makefile,v 1.11 1999/12/23 01:15:48 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.7

LOCALTOP= ..

.if exists(${LOCALTOP}/Makefile.conf)
.include "${LOCALTOP}/Makefile.conf"
.endif

DOCS=  current.sgml 
DOCS+= doc-set.sgml
DOCS+= sgml.sgml
DOCS+= submitting.sgml
DOCS+= who.sgml 
DOCS+= translations.sgml
DOCS+= docproj.sgml

INDEXLINK= docproj.html

### Revision checking
REVCHECK=	yes

.include "${LOCALTOP}/web.mk"

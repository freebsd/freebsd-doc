# $FreeBSD: www/ja/docproj/Makefile,v 1.10 1999/09/07 15:15:47 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
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
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	docproj

.include "../../web.mk"

# $FreeBSD: www/ja/internal/Makefile,v 1.12 1999/12/23 01:15:50 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.19

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

# DOCS=   photos.sgml     
DOCS+=  internal.sgml   
DOCS+=  about.sgml
DOCS+=  machines.sgml
DOCS+=  mirror.sgml
DOCS+=	statistic.sgml
DOCS+=	developer.sgml

#.if !defined(WEB_ONLY) || empty(WEB_ONLY)
#LOCAL=  committers-guide.html
#.endif

#committers-guide.html: ../../../doc/en_US.ISO_8859-1/articles/committers-guide/article.sgml
#	(cd ../../../doc/en_US.ISO_8859-1/articles/committers-guide && ${MAKE} FORMATS=html INSTALL_COMPRESSED='')
#	cp ../../../doc/en_US.ISO_8859-1/articles/committers-guide/article.html committers-guide.html

INDEXLINK=	internal.html

# DATA+=  README.mirror

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	internal

.include "../../web.mk"

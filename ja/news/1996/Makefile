# $FreeBSD: www/ja/news/1996/Makefile,v 1.2 2000/09/28 11:58:24 hrs Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.2

LOCALTOP= ../..

.if exists(${LOCALTOP}/Makefile.conf)
.include "${LOCALTOP}/Makefile.conf"
.endif

DOCS=	index.sgml

### Revision checking
#REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
REVCHECK=	YES

.include "${LOCALTOP}/web.mk"
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../../..
DIR_IN_LOCAL=	news/1996

.include "../../web.mk"

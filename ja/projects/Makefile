# $FreeBSD: www/ja/projects/Makefile,v 1.9 1999/12/23 01:15:56 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.6

LOCALTOP= ..

.if exists(${LOCALTOP}/Makefile.conf)
.include "${LOCALTOP}/Makefile.conf"
.endif

DOCS=	projects.sgml
DOCS+=	mozilla.sgml
DOCS+=	newbies.sgml

INDEXLINK= projects.html

### Revision checking
REVCHECK=	yes

.include "${LOCALTOP}/web.mk"

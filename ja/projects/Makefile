# $FreeBSD: www/ja/projects/Makefile,v 1.14 2004/01/17 02:37:43 hrs Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.15

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	projects.sgml
#DOCS+=	updater.sgml
DOCS+=	newbies.sgml
#DOCS+=	libh.sgml
DOCS+=	cvsweb.sgml

INDEXLINK= projects.html

#SUBDIR=  busdma c99 gnats4 mips 

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

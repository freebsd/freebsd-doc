# $FreeBSD: www/ja/commercial/Makefile,v 1.9 1999/12/23 01:15:46 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.12

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

PERL=	perl5

DOCS = 	commercial.sgml
# DOCS+=  consulting.sgml
# DOCS+=  consulting_bycat.sgml
# DOCS+=  hardware.sgml
# DOCS+=  misc.sgml
# DOCS+=  software.sgml
# DOCS+=  software_bycat.sgml

INDEXLINK=commercial.html

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	commercial

.include "../../web.mk"

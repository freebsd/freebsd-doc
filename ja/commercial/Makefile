# $FreeBSD: www/ja/commercial/Makefile,v 1.8 1999/09/07 14:22:58 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.9

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

# $FreeBSD$
# The FreeBSD Japanese Documentation Project
# Original revision: 1.1

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS=   index.sgml 

# not translated yet
#SUBDIR=	stable

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	conspectus

.include "../../web.mk"

#
# $FreeBSD$
#
# Original revision: 1.5
#
# Build the FreeBSD tutorials/articles outside of the www tree, and then
# install them in to the right place.

DOCS = index.sgml

all afterinstall clean:
	(cd ../../../doc/ja_JP.eucJP/articles && ${MAKE} 'FORMATS=html html-split' 'DESTDIR=${DESTDIR}/data/ja/tutorials/$${.CURDIR:T}' ${.TARGET:S/afterinstall/install/})
#	(cd ../../../doc/ja_JP.eucJP/books/fdp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/ja/tutorials/docproj-primer ${.TARGET:S/afterinstall/install/})
#	(cd ../../../doc/ja_JP.eucJP/books/ppp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/ja/tutorials/ppp ${.TARGET:S/afterinstall/install/})

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	tutorials

.include "../web.mk"

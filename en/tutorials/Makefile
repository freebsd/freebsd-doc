#
# $FreeBSD: www/en/tutorials/Makefile,v 1.5 1999/09/17 23:48:29 nik Exp $
#
# Build the FreeBSD tutorials/articles outside of the www tree, and then
# install them in to the right place.

DOCS = index.sgml

DIRS_TO_CLEAN =	../../../doc/en_US.ISO_8859-1/articles \
		../../../doc/en_US.ISO_8859-1/books/fdp-primer \
		../../../doc/en_US.ISO_8859-1/books/ppp-primer

all afterinstall: index.html
	(cd ../../../doc/en_US.ISO_8859-1/articles && ${MAKE} 'FORMATS=html html-split' 'DESTDIR=${DESTDIR}/data/tutorials/$${.CURDIR:T}' ${.TARGET:S/afterinstall/install/})
	(cd ../../../doc/en_US.ISO_8859-1/books/fdp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/tutorials/docproj-primer ${.TARGET:S/afterinstall/install/})
	(cd ../../../doc/en_US.ISO_8859-1/books/ppp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/tutorials/ppp ${.TARGET:S/afterinstall/install/})

.include "../web.mk"

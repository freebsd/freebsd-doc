#
# $FreeBSD: www/en/tutorials/Makefile,v 1.3 1999/09/06 07:02:58 peter Exp $
#
# Build the FreeBSD tutorials/articles outside of the www tree, and then
# install them in to the right place.

DOCS = index.sgml

all afterinstall clean: index.html
	(cd ../../../doc/en_US.ISO_8859-1/articles && ${MAKE} 'FORMATS=html html-split' 'DESTDIR=${DESTDIR}/data/tutorials/$${.CURDIR:T}' ${.TARGET:S/afterinstall/install/})
	(cd ../../../doc/en_US.ISO_8859-1/books/fdp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/tutorials/docproj-primer ${.TARGET:S/afterinstall/install/})

.include "../web.mk"

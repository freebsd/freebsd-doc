#
# $FreeBSD$
# The FreeBSD Russian Documentation Project
# Original revision: 1.5
#
# Build the FreeBSD tutorials/articles outside of the www tree, and then
# install them in to the right place.

DOCS = index.sgml

#all afterinstall clean: index.html
#	(cd ../../../doc/ru_RU.KOI8-R/articles && ${MAKE} 'FORMATS=html html-split' 'DESTDIR=${DESTDIR}/data/tutorials/$${.CURDIR:T}' ${.TARGET:S/afterinstall/install/})
#	(cd ../../../doc/ru_RU.KOI8-R/books/fdp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/tutorials/docproj-primer ${.TARGET:S/afterinstall/install/})
#	(cd ../../../doc/ru_RU.KOI8-R/books/ppp-primer && ${MAKE} 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/tutorials/ppp ${.TARGET:S/afterinstall/install/})

.include "../web.mk"

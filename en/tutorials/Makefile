#
# $Id: Makefile,v 1.1 1999-08-19 20:49:29 nik Exp $
#
# Build the FreeBSD tutorials/articles outside of the www tree, and then
# install them in to the right place.

DOCS = index.sgml

all afterinstall clean: index.html
	(cd ../../../doc/en_US.ISO_8859-1/articles; make 'FORMATS=html html-split' 'DESTDIR=${DESTDIR}/data/tutorials/$${.CURDIR:T}' ${.TARGET:S/afterinstall/install/})
	(cd ../../../doc/en_US.ISO_8859-1/books/fdp-primer; make 'FORMATS=html html-split' DESTDIR=${DESTDIR}/data/tutorials/docproj-primer ${.TARGET:S/afterinstall/install/})

.include "../web.mk"

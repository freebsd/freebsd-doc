#
# $Id: Makefile,v 1.1 1999-08-19 20:53:38 nik Exp $
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/es_ES.ISO_8859-1/books/faq; make 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/es/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/es/FAQ; ln -sf index.html FAQ.html)
.endif

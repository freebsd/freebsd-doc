#
# $FreeBSD: www/es/FAQ/Makefile,v 1.2 1999/09/06 07:03:00 peter Exp $
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/es_ES.ISO_8859-1/books/faq; ${MAKE} 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/es/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/es/FAQ; ln -sf index.html FAQ.html)
.endif

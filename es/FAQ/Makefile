#
# $FreeBSD: www/es/FAQ/Makefile,v 1.3 1999/09/15 20:37:11 wosch Exp $
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/es_ES.ISO8859-1/books/faq; ${MAKE} 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/es/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/es/FAQ; ln -sf index.html FAQ.html)
.endif

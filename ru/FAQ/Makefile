#
# $FreeBSD: www/ru/FAQ/Makefile,v 1.3 1999/09/06 07:03:31 peter Exp $
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/ru_RU.KOI8-R/books/faq; ${MAKE} 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/ru/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/ru/FAQ; ln -sf index.html FAQ.html)
.endif

#
# $FreeBSD$
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/ru_RU.KOI8-R/books/faq; make 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/ru/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/ru/FAQ; ln -sf index.html FAQ.html)
.endif

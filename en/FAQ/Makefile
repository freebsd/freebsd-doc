#
# $FreeBSD: www/en/FAQ/Makefile,v 1.3 1999/09/06 07:02:39 peter Exp $
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/en_US.ISO_8859-1/books/faq && ${MAKE} 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/FAQ; ln -sf index.html FAQ.html)
.endif

#
# $FreeBSDde: de-www/FAQ/Makefile,v 1.1 2001/02/24 17:00:25 alex Exp $
# $FreeBSD: www/de/FAQ/Makefile,v 1.1 2001/02/25 11:54:09 alex Exp $
# Original revision:	1.4
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/de_DE.ISO8859-1/books/faq && ${MAKE} 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/de/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/de/FAQ; ln -sf index.html FAQ.html)
.endif

#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/FAQ/Makefile,v 1.2 2000/10/06 15:53:51 phantom Exp $
# Original revision: 1.4
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/ru_RU.KOI8-R/books/faq; ${MAKE} 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/ru/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/ru/FAQ; ln -sf index.html FAQ.html)
.endif

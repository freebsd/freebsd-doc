#
# $FreeBSD: www/ja/FAQ/Makefile,v 1.5 1999/09/15 20:37:11 wosch Exp $
# Original revision:	1.4
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/ja_JP.eucJP/books/faq && ${MAKE} 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/ja/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/ja/FAQ; ln -sf index.html FAQ.html)
.endif

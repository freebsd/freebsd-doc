#
# $FreeBSD: www/ja/FAQ/Makefile,v 1.4 1999/09/07 15:15:46 kuriyama Exp $
# Original revision:	1.3
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/ja_JP.eucJP/books/faq && ${MAKE} 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/ja/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/ja/FAQ; ln -sf index.html FAQ.html)
.endif

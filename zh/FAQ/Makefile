#
# $FreeBSD: www/zh/FAQ/Makefile,v 1.2 1999/09/06 07:03:31 peter Exp $
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/zh_TW.Big5/books/faq; ${MAKE} 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/zh/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/zh/FAQ; ln -sf index.html FAQ.html)
.endif

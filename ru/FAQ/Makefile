#
# $Id: Makefile,v 1.1 1999-08-29 16:54:44 nik Exp $
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/ru_RU.KOI8-R/books/faq; make 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/zh/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/ru/FAQ; ln -sf index.html FAQ.html)
.endif

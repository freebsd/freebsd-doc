#
# $Id: Makefile,v 1.1 1999-08-19 20:51:34 nik Exp $
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/ja_JP.eucJP/books/faq; make 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/ja/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/ja/FAQ; ln -sf index.html FAQ.html)
.endif

#
# $Id: Makefile,v 1.1 1999-08-19 20:55:58 nik Exp $
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/zh_TW.Big5/books/faq; make 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/zh/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/zh/FAQ; ln -sf index.html FAQ.html)
.endif

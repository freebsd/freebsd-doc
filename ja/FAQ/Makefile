#
# $Id: Makefile,v 1.2 1999-09-03 22:39:48 kuriyama Exp $
# Original revision:	1.2
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/ja_JP.eucJP/books/faq && make 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/ja/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/ja/FAQ; ln -sf index.html FAQ.html)
.endif

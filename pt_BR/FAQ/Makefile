# The FreeBSD Documentation Project
# The FreeBSD Brazilian Portuguese Documentation Project
#
# $FreeBSD$
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

all install clean:
	(cd ../../../doc/pt_BR.ISO8859-1/books/faq; ${MAKE} 'FORMATS=html-split html' DESTDIR=${DESTDIR}/data/pt_BR/FAQ ${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/pt_BR/FAQ; ln -sf index.html FAQ.html)
.endif

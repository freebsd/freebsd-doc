#
# $FreeBSD: www/zh/FAQ/Makefile,v 1.3 1999/09/15 20:37:12 wosch Exp $
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

all install clean:
	(cd ../../../doc/zh_TW.Big5/books/faq; \
		${MAKE} 'FORMATS=html-split html' \
		DESTDIR=${DESTDIR}/data/zh/FAQ \
		${.TARGET})
.if make(install)
	(cd ${DESTDIR}/data/zh/FAQ; ln -sf index.html FAQ.html)
.endif

WEBBASE=        /data/zh/FAQ

.include "${WEB_PREFIX}/share/mk/web.site.mk"


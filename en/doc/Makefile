#
# $FreeBSD: www/en/doc/Makefile,v 1.2 2001/04/17 12:18:20 nik Exp $i
#
# Build the FreeBSD documentation *outside* of the www tree, and install it
# in to the right place as necessary.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#

all:
	(unset DESTDIR || true; cd ${.CURDIR}/../../../doc/en_US.ISO_8859-1 && ${MAKE} FORMATS=html-split\ html all)
	(unset DESTDIR || true; cd ${.CURDIR}/../../../doc/en_US.ISO_8859-1 && ${MAKE} FORMATS=html-split\ html DOCDIR=${.CURDIR} install)
	
install clean:
	(unset DESTDIR || true; cd ${.CURDIR}/../../../doc/en_US.ISO_8859-1 && ${MAKE} FORMATS=html-split\ html DOCDIR=${DESTDIR}/data/doc ${.TARGET})
.if make(clean)
	rm -rf en* handbook faq
.endif

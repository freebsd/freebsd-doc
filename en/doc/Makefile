#
# $FreeBSD: www/en/doc/Makefile,v 1.6 2001/06/11 02:38:59 ache Exp $i
#
# Build the FreeBSD documentation *outside* of the www tree, and install it
# in to the right place as necessary.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#

all:
	(unset DESTDIR || true; cd ${.CURDIR}/../../../doc/en_US.ISO8859-1 && ${MAKE} FORMATS=html-split\ html all)
	(unset DESTDIR || true; cd ${.CURDIR}/../../../doc/en_US.ISO8859-1 && ${MAKE} FORMATS=html-split\ html DOCDIR=${.CURDIR} install)
	(unset DESTDIR || true; cd ${.CURDIR}/../../../doc/en_US.ISO8859-1/books/handbook && ${MAKE} pgpkeyring > ${.CURDIR}/pgpkeyring.txt)

install clean:
	(unset DESTDIR || true; cd ${.CURDIR}/../../../doc/en_US.ISO8859-1 && ${MAKE} FORMATS=html-split\ html DOCDIR=${DESTDIR}/data/doc ${.TARGET})
.if make(install)
	(unset DESTDIR || true; cd ${.CURDIR}/../../../doc/en_US.ISO8859-1/books/handbook && ${MAKE} pgpkeyring > ${DESTDIR}/data/doc/pgpkeyring.txt)	
.endif
.if make(clean)
	rm -rf en* handbook faq pgpkeyring.txt
.endif

obj:
	cd ${.CURDIR}/../../../doc/en_US.ISO8859-1 && ${MAKE} ${.TARGET}

.include "${.CURDIR}/../../share/mk/web.site.mk"

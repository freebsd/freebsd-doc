#
# $FreeBSD: www/en/docs/Makefile,v 1.2 2001/02/23 10:13:49 nik Exp $i
#
# Build the FreeBSD documentation *outside* of the www tree, and install it
# in to the right place as necessary.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#

all install clean:
	(cd ../../../doc/en_US.ISO_8859-1 && unset DESTDIR || ${MAKE} FORMATS=html-split DOCDIR=${DESTDIR}/data/docs ${.TARGET})

#
# $FreeBSD$i
#
# Build the FreeBSD documentation *outside* of the www tree, and install it
# in to the right place as necessary.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#

all install clean:
	echo foo
	(cd ../../../doc/en_US.ISO_8859-1 && unset DESTDIR && ${MAKE} FORMATS=html-split DOCDIR=${DESTDIR}/data/docs ${.TARGET})

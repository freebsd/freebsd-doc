#
# $FreeBSDde: de-www/handbook/Makefile,v 1.1 2001/02/24 17:00:26 alex Exp $
# $FreeBSD: www/de/handbook/Makefile,v 1.1 2001/02/25 11:53:47 alex Exp $
# Original revision:	1.5
#
# Build the FreeBSD Handbook *outside* of the www tree, and install it
# in to the right place as necessary.
#
# The Handbook is no longer completely self contained in 
# doc/de_DE.ISO8859-1/books/handbook, (it requires support files outside of 
# this directory) and it is much simpler to build it outside the web tree 
# than it is to make a nest of symlinks to try and build it inside the tree.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#

all install clean:
	(cd ../../../doc/de_DE.ISO8859-1/books/handbook && ${MAKE} FORMATS=html-split DESTDIR=${DESTDIR}/data/de/handbook ${.TARGET})

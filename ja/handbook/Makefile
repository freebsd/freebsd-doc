#
# $FreeBSD: www/ja/handbook/Makefile,v 1.6 1999/09/07 15:15:48 kuriyama Exp $
# Original revision:	1.4
#
# Build the FreeBSD Handbook *outside* of the www tree, and install it
# in to the right place as necessary.
#
# The Handbook is no longer completely self contained in 
# doc/ja_JP.eucJP/books/handbook, (it requires support files outside of 
# this directory) and it is much simpler to build it outside the web tree 
# than it is to make a nest of symlinks to try and build it inside the tree.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#

all install clean:
	(cd ../../../doc/ja_JP.eucJP/books/handbook && ${MAKE} FORMATS=html-split DESTDIR=${DESTDIR}/data/ja/handbook ${.TARGET})

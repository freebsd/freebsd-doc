#
# $Id: Makefile,v 1.2 1999-08-19 20:40:58 nik Exp $
#
# Build the FreeBSD Handbook *outside* of the www tree, and install it
# in to the right place as necessary.
#
# The Handbook is no longer completely self contained in 
# doc/en_US.ISO_8859-1/books/handbook, (it requires support files outside of 
# this directory) and it is much simpler to build it outside the web tree 
# than it is to make a nest of symlinks to try and build it inside the tree.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#

all install clean:
	(cd ../../../doc/en_US.ISO_8859-1/books/handbook; make FORMATS=html-split DESTDIR=${DESTDIR}/data/handbook ${.TARGET})

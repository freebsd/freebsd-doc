#
# $Id: Makefile,v 1.1 1999-05-03 14:37:25 kuriyama Exp $
# Original Revision:	1.1
#
# Build the FreeBSD Handbook *outside* of the www tree, and install it
# in to the right place as necessary.
#
# The Handbook is no longer completely self contained in doc/en/handbook,
# (it requires support files outside of this directory) and it is much
# simpler to build it outside the web tree than it is to make a nest of
# symlinks to try and build it inside the tree.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#

all install clean:
	(cd ../../../doc/ja/handbook; make FORMATS=html-split DOC_PREFIX=../../../doc DESTDIR=${DESTDIR} DOCDIR=/data VOLUME=handbook ${.TARGET})

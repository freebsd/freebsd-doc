#
# $Id: Makefile,v 1.3 1999-08-19 20:42:40 nik Exp $
# Original Revision:	1.1
#
# Build the FreeBSD Handbook *outside* of the www tree, and install it
# in to the right place as necessary.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#

all install clean:
	(cd ../../../doc/ja_JP.eucJP/books/handbook; make FORMATS=html-split DESTDIR=${DESTDIR}/data/ja/handbook ${.TARGET})

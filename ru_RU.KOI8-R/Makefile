#       $Id: Makefile,v 1.2 1999-08-16 22:09:16 nik Exp $

SUBDIR = FAQ

COMPAT_SYMLINK = ru

# 
# XXX Kludge -- this directory probably doesn't exist yet.  Pull this out 
# when the FAQ is DocBook'ed
beforeinstall:
	[ -d /usr/local/share/doc/fdp/ru_SU.KOI8-R/books/faq ] || \
		mkdir -p /usr/local/share/doc/fdp/ru_SU.KOI8-R/books/faq

#
# Put the compatability symlink in place.
#
afterinstall:
.if !defined(IGNORE_COMPAT_SYMLINK)
	if [ ! -e /usr/local/share/doc/fdp/${COMPAT_SYMLINK} ]; then	\
		rm -rf /usr/local/share/doc/fdp/${COMPAT_SYMLINK};	\
		ln -s /usr/local/share/doc/fdp/ru_SU.KOI8-R	\
		      /usr/local/share/doc/fdp/${COMPAT_SYMLINK};	\
	fi
.endif

.include <bsd.subdir.mk>

#       $Id: Makefile,v 1.4 1999-08-26 19:42:12 nik Exp $

SUBDIR = FAQ

COMPAT_SYMLINK = ru

# 
# XXX Kludge -- this directory probably doesn't exist yet.  Pull this out 
# when the FAQ is DocBook'ed
beforeinstall:
	[ -d ${DOCDIR}/ru_SU.KOI8-R/books/faq ] || 			\
		mkdir -p ${DOCDIR}/ru_SU.KOI8-R/books/faq

#
# Put the compatability symlink in place.
#
afterinstall:
.if !defined(IGNORE_COMPAT_SYMLINK)
	if [ ! -e ${DOCDIR}/${COMPAT_SYMLINK} ]; then			\
		rm -rf ${DOCDIR}/${COMPAT_SYMLINK};			\
		(cd ${DOCDIR} && ln -s ru_RU.KOI8-R ${COMPAT_SYMLINK});	\
	fi
.endif

.include <bsd.subdir.mk>

DOC_PREFIX = ..
.include "../share/mk/docproj.docbook.mk"

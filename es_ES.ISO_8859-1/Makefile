#       $Id: Makefile,v 1.5 1999-08-26 19:42:11 nik Exp $

SUBDIR = books

COMPAT_SYMLINK = es

#
# Put the compatability symlink in place.
#
afterinstall:
.if !defined(IGNORE_COMPAT_SYMLINK)
	if [ ! -e ${DOCDIR}/${COMPAT_SYMLINK} ]; then			\
		rm -rf ${DOCDIR}/${COMPAT_SYMLINK};			\
		(cd ${DOCDIR} && ln -s es_ES.ISO_8859-1 ${COMPAT_SYMLINK}); \
	fi
.endif

.include <bsd.subdir.mk>

DOC_PREFIX = ..
.include "../share/mk/docproj.docbook.mk"

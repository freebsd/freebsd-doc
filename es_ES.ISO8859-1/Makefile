#       $Id: Makefile,v 1.4 1999-08-19 20:35:57 nik Exp $

SUBDIR = books

COMPAT_SYMLINK = es

#
# Put the compatability symlink in place.
#
afterinstall:
.if !defined(IGNORE_COMPAT_SYMLINK)
	if [ ! -e ${DOCDIR}/${COMPAT_SYMLINK} ]; then			\
		rm -rf ${DOCDIR}/${COMPAT_SYMLINK};			\
		ln -s ${DOCDIR}/es_ES.ISO_8859-1 			\
			${DOCDIR}/${COMPAT_SYMLINK}; 			\
	fi
.endif

.include <bsd.subdir.mk>

DOC_PREFIX = ..
.include "../share/mk/docproj.docbook.mk"

#       $Id: Makefile,v 1.4 1999-08-26 19:42:13 nik Exp $

SUBDIR = books

COMPAT_SYMLINK = zh

#
# Put the compatability symlink in place.
#
afterinstall:
.if !defined(IGNORE_COMPAT_SYMLINK)
	if [ ! -e ${DOCDIR}/${COMPAT_SYMLINK} ]; then			\
		rm -rf ${DOCDIR}/${COMPAT_SYMLINK};			\
		(cd ${DOCDIR} && ln -s zh_TW.Big5 ${COMPAT_SYMLINK});	\
	fi
.endif

.include <bsd.subdir.mk>

DOC_PREFIX = ..
.include "../share/mk/docproj.docbook.mk"

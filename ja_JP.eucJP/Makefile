#       $Id: Makefile,v 1.8 1999-08-26 19:42:11 nik Exp $

SUBDIR = books
SUBDIR+= man
SUBDIR+= FAQ

COMPAT_SYMLINK = ja_JP.eucJP

#
# Put the compatability symlink in place.
#
afterinstall:
.if !defined(IGNORE_COMPAT_SYMLINK)
	if [ ! -e ${DOCDIR}/${COMPAT_SYMLINK} ]; then			\
		rm -rf ${DOCDIR}/${COMPAT_SYMLINK};			\
		(cd ${DOCDIR} && ln -s ja ${COMPAT_SYMLINK});		\
	fi
.endif

.include <bsd.subdir.mk>

DOC_PREFIX = ..
.include "../share/mk/docproj.docbook.mk"

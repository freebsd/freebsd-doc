#       $Id: Makefile,v 1.10 1999-08-31 15:00:01 kuriyama Exp $
#
# Original revision: 1.5
#

SUBDIR = books
SUBDIR+= man

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

DOC_PREFIX?= ..
.include "${DOC_PREFIX}/share/mk/docproj.docbook.mk"

#       $Id: Makefile,v 1.5 1999-08-29 00:02:11 jhb Exp $

SUBDIR = articles
SUBDIR+= books

COMPAT_SYMLINK = en

#
# Put the compatability symlink in place.
#
afterinstall:
.if !defined(IGNORE_COMPAT_SYMLINK)
	if [ ! -e ${DOCDIR}/${COMPAT_SYMLINK} ]; then			\
		rm -rf ${DOCDIR}/${COMPAT_SYMLINK};			\
		(cd ${DOCDIR} && ln -s en_US.ISO_8859-1 ${COMPAT_SYMLINK}); \
	fi
.endif

.include <bsd.subdir.mk>

DOC_PREFIX?= ..
.include "${DOC_PREFIX}/share/mk/docproj.docbook.mk"

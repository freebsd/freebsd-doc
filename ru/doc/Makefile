#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/doc/Makefile,v 1.2 2004/01/03 04:36:26 andy Exp $
#
# Original revision: 1.8
#

#
# Build the FreeBSD documentation *outside* of the www tree, and install it
# in to the right place as necessary.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#

all: all-all all-install all-pgpkeyring

all-all:
	@unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/ru_RU.KOI8-R; \
		${MAKE} FORMATS="html-split html" \
			INSTALL_COMPRESSED= all
all-install:
	@unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/ru_RU.KOI8-R; \
		${MAKE} FORMATS="html-split html" DOCDIR=${.OBJDIR} \
			INSTALL_COMPRESSED= install
all-pgpkeyring:
	@unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/ru_RU.KOI8-R/books/handbook; \
		${MAKE} \
			pgpkeyring > ${.OBJDIR}/pgpkeyring.txt

install clean:
	@unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/ru_RU.KOI8-R; \
		${MAKE} FORMATS="html-split html" DOCDIR=${DESTDIR}/data/doc \
			INSTALL_COMPRESSED= ${.TARGET}
#.if make(install)
#	@unset DESTDIR || true; \
#	 cd ${.CURDIR}/../../../doc/ru_RU.KOI8-R/books/handbook; \
#		${MAKE} \
#			pgpkeyring > ${DESTDIR}/data/doc/pgpkeyring.txt
#.endif
.if make(clean)
	${RM} -rf ru* handbook faq
.endif

.include "${.CURDIR}/../../share/mk/web.site.mk"

obj: _OBJUSE

_OBJUSE: .USE
	@unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/ru_RU.KOI8-R; \
		${MAKE} ${.TARGET}

#
# $FreeBSD$
# Original revision: 1.8
#
# Build the FreeBSD documentation *outside* of the www tree, and install it
# in to the right place as necessary.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#

all: all-all all-install

all-all:
	@unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/ja_JP.eucJP; \
		${MAKE} FORMATS="html-split html" \
			INSTALL_COMPRESSED= NO_JPMAN= all
all-install:
	@unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/ja_JP.eucJP; \
		${MAKE} FORMATS="html-split html" DOCDIR=${.OBJDIR} \
			INSTALL_COMPRESSED= NO_JPMAN= install

install clean:
	@unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/ja_JP.eucJP; \
		${MAKE} FORMATS="html-split html" DOCDIR=${DESTDIR}/data/doc \
			INSTALL_COMPRESSED= NO_JPMAN= ${.TARGET}
.if make(clean)
	${RM} -rf ja*
.endif

.include "${.CURDIR}/../../share/mk/web.site.mk"

obj: _OBJUSE

_OBJUSE: .USE
	@unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/ja_JP.eucJP; \
		${MAKE} ${.TARGET}

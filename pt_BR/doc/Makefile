# The FreeBSD Documentation Project
# The FreeBSD Brazilian Portuguese Documentation Project
#
# Original version: 1.8
#
# $FreeBSD$
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
	unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/pt_BR.ISO8859-1; \
		${MAKE} FORMATS="html-split html" \
			INSTALL_COMPRESSED= all
all-install:
	unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/pt_BR.ISO8859-1; \
		${MAKE} FORMATS="html-split html" DOCDIR=${.OBJDIR} \
			INSTALL_COMPRESSED= install

install clean:
	unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/pt_BR.ISO8859-1; \
		${MAKE} FORMATS="html-split html" DOCDIR=${DESTDIR}/data/doc \
			INSTALL_COMPRESSED= ${.TARGET}
.if make(clean)
	${RM} -rf pt* faq
.endif

.include "${.CURDIR}/../../share/mk/web.site.mk"

obj: _OBJUSE

_OBJUSE: .USE
	@unset DESTDIR || true; \
	 cd ${.CURDIR}/../../../doc/pt_BR.ISO8859-1; \
		${MAKE} ${.TARGET}

#
# $FreeBSD$
# $FreeBSDde$
# basiert auf: r44174
#
# Build the FreeBSD documentation *outside* of the www tree, and install it
# in to the right place as necessary.
#
# This assumes that you have the www/ and doc/ trees checked out beside
# one another -- this was always the case anyway, so there are no extra
# requirements here.
#
.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

all: all-all all-install

all-all:
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/${LANGCODE}; \
		${MAKE} FORMATS="html-split html" \
			INSTALL_COMPRESSED= all
all-install:
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/${LANGCODE}; \
		${MAKE} FORMATS="html-split html" DOCDIR=${.OBJDIR} \
			INSTALL_COMPRESSED= install
install clean:
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/${LANGCODE}; \
		${MAKE} FORMATS="html-split html" DOCDIR=${DESTDIR}/data/doc \
			INSTALL_COMPRESSED= ${.TARGET}
.if make(clean)
	${RM} -rf de* handbook faq
.endif

.include "${DOC_PREFIX}/share/mk/web.site.mk"

obj: _OBJUSE

_OBJUSE: .USE
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/${LANGCODE}; \
		${MAKE} ${.TARGET}

#
# $FreeBSD$
# Original revision: r40713
#
# Build the FreeBSD documentation *outside* of the doc/ tree, and install it
# in to the right place as necessary.
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
			INSTALL_COMPRESSED= NO_JPMAN= all
all-install:
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/${LANGCODE}; \
		${MAKE} FORMATS="html-split html" DOCDIR=${.OBJDIR} \
			INSTALL_COMPRESSED= NO_JPMAN= install

install clean:
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/${LANGCODE}; \
		${MAKE} FORMATS="html-split html" DOCDIR=${DESTDIR}/data/doc \
			INSTALL_COMPRESSED= NO_JPMAN= ${.TARGET}
.if make(clean)
	${RM} -rf ja*
.endif

.include "${DOC_PREFIX}/share/mk/web.site.mk"

obj: _OBJUSE

_OBJUSE: .USE
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/${LANGCODE}; \
		${MAKE} ${.TARGET}

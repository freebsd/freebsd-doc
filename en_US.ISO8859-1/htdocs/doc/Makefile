#
# $FreeBSD$
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

all: all-all all-install all-pgpkeyring

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
all-pgpkeyring:
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/share/pgpkeys; \
		${MAKE} \
			pgpkeyring > ${.OBJDIR}/pgpkeyring.txt

install clean:
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/${LANGCODE}; \
		${MAKE} FORMATS="html-split html" DOCDIR=${DESTDIR}/data/doc \
			INSTALL_COMPRESSED= ${.TARGET}
.if make(install)
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/share/pgpkeys; \
		${MAKE} \
			pgpkeyring > ${DESTDIR}/data/doc/pgpkeyring.txt
.endif
.if make(clean)
	${RM} -rf en* handbook faq pgpkeyring.txt
.endif

.include "${DOC_PREFIX}/share/mk/web.site.mk"

obj: _OBJUSE

_OBJUSE: .USE
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/${LANGCODE}; \
		${MAKE} ${.TARGET}

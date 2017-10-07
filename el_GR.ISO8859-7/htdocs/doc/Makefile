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

_DOC_FORMATS?=	html-split html

all: all-all 


all-all:
	${MAKE} -C ${DOC_PREFIX}/${LANGCODE} FORMATS="${_DOC_FORMATS}" all

all-pgpkeyring:
	${MAKE} -C ${DOC_PREFIX}/share/pgpkeys pgpkeyring.txt

clean:
	${MAKE} -C ${DOC_PREFIX}/${LANGCODE} FORMATS="${_DOC_FORMATS}" DOCDIR=${DESTDIR}/data/doc clean

# here are dragons
install:
	unset DESTDIR || true; \
	  ${MAKE} -C ${DOC_PREFIX}/${LANGCODE} FORMATS="${_DOC_FORMATS}" DOCDIR=${DESTDIR}/data/doc install
	${CP} ${DOC_PREFIX}/share/pgpkeys/pgpkeyring.txt ${DESTDIR}/data/doc/pgpkeyring.txt

.include "${DOC_PREFIX}/share/mk/web.site.mk"
.if ${LANGCODE} == en_US.ISO8859-1
all: all-pgpkeyring
.endif


# XXX
obj: _OBJUSE

_OBJUSE: .USE
	@unset DESTDIR || true; \
	 cd ${DOC_PREFIX}/${LANGCODE}; \
		${MAKE} ${.TARGET}

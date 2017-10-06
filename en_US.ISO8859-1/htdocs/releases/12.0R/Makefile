# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

RELN_ROOT?=	${.CURDIR}

_OS?=		FreeBSD
_REVISION?=	12.0
_BRANCH?=	RELEASE
THISRELEASE?=	${_OS}-${_REVISION}-${_BRANCH}

DOCS=	index.xml \
	schedule.xml

DATA=	docbook.css

# PGP-signed checksums

_BIGIRON?=	amd64 \
		i386 \
		powerpc \
		powerpc-powerpc64 \
		sparc64 \
		arm64-aarch64

_VMS?=		amd64 \
		i386 \
		arm64-aarch64

_ARM?=		BANANAPI \
		BEAGLEBONE \
		CUBIEBOARD \
		CUBIEBOARD2 \
		CUBOX-HUMMINGBOARD \
		GUMSTIX \
		PANDABOARD \
		RPI-B \
		RPI2 \
		WANDBOARD

.for CHECKSUM in SHA512 SHA256
. for _B in ${_BIGIRON}
#DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-${_B}.asc
. endfor
. for _V in ${_VMS}
#DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-${_V}-vm.asc
. endfor
. for _A in ${_ARM}
#DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-arm-armv6-${_A}.asc
. endfor
.endfor

_hardware?=	hardware

# The path used on build-web is 'src/share/man/man4'.
.if !defined(MAN4DIR) || empty(MAN4DIR)
. if exists(${DOC_PREFIX}/../src/share/man/man4)
MAN4DIR=	${DOC_PREFIX}/../src/share/man/man4
. elif exists(${DOC_PREFIX}/../share/man/man4)
MAN4DIR=	${DOC_PREFIX}/../share/man/man4
. elif exists(${DOC_PREFIX}/../man/man4)
MAN4DIR=	${DOC_PREFIX}/../man/man4
. elif exists(${DOC_PREFIX}/../man4)
MAN4DIR=	${DOC_PREFIX}/../man4
. else
.  warning "MAN4DIR not found.  Unable to build hardware.html"
_hardware=	# empty
. endif
.endif

D=		errata
D+=		${_hardware}
D+=		readme
D+=		relnotes

MAN4PAGES?=	${MAN4DIR}/*.4 ${MAN4DIR}/man4.*/*.4
ARCHLIST?=	${.CURDIR}/../../share/misc/dev.archlist.txt
CLEANFILES+=	dev-auto.ent \
		index.html \
		schedule.html

MAN2HWNOTES_CMD=${.CURDIR}/../../share/misc/man2hwnotes.pl
.if defined(HWNOTES_MI)
MAN2HWNOTES_FLAGS=
.else
MAN2HWNOTES_FLAGS=	-c
.endif

dev-auto.ent:
	${PERL} ${MAN2HWNOTES_CMD} ${MAN2HWNOTES_FLAGS} -a ${ARCHLIST} -o ${.TARGET}.tmp ${MAN4PAGES}
	${MV} ${.TARGET}.tmp ${.TARGET}

.if make(clean)
beforeclean:
SUBDIR+=	${D}
.include "${DOC_PREFIX}/share/mk/doc.subdir.mk"
.endif

beforeinstall:
.for _SD in ${D}
. if (${_SD:Mhardware} != "")
	${MAKE} -B -C ${.CURDIR} dev-auto.ent
. endif
	${MAKE} -C ${_SD} DOCINSTALLDIR=${DOCINSTALLDIR} all
.endfor

afterinstall:
.for _SD in ${D}
	${MAKE} -C ${_SD} DOCINSTALLDIR=${DOCINSTALLDIR} install
.endfor

.include "${DOC_PREFIX}/share/mk/web.site.mk"

# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif
.if exists(Makefile.inc)
.include "Makefile.inc"
.endif

RELN_ROOT?=	${.CURDIR}

DOCS=	index.xml \
	schedule.xml

DATA=	docbook.css

SUBDIR=	errata readme relnotes

.if exists(${SVN})
SUBDIR+=hardware
.endif

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

_ARM_ARM?=	GUMSTIX

_ARM_ARMV6?=	RPI-B

_ARM_ARMV7?=	BANANAPI \
		BEAGLEBONE \
		CUBIEBOARD \
		CUBIEBOARD2 \
		CUBOX-HUMMINGBOARD \
		GUMSTIX \
		PANDABOARD \
		RPI2 \
		WANDBOARD

_ARM64_AARCH64?=PINE64 \
		RPI3

.for CHECKSUM in SHA512 SHA256
. for _B in ${_BIGIRON}
#DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-${_B}.asc
. endfor
. for _V in ${_VMS}
#DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-${_V}-vm.asc
. endfor
. for _A in ${_ARM_ARM}
#DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-arm-arm-${_A}.asc
. endfor
. for _A in ${_ARM_ARMV6}
#DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-arm-armv6-${_A}.asc
. endfor
. for _A in ${_ARM_ARMV7}
#DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-arm-armv7-${_A}.asc
. endfor
. for _A in ${_ARM64_AARCH64}
#DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-arm64-aarch64-${_A}.asc
. endfor
.endfor

.include "${DOC_PREFIX}/share/mk/web.site.mk"

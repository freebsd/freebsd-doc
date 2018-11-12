# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

_OS?=		FreeBSD
_REVISION?=	11.2
_BRANCH?=	RELEASE
THISRELEASE?=	${_OS}-${_REVISION}-${_BRANCH}

DOCS=	index.xml \
	schedule.xml \
	signatures.xml \
	announce.xml

DATA=	announce.asc \
	docbook.css \
	errata.html \
	hardware.html \
	installation.html \
	readme.html \
	relnotes.html

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

_ARM?=		GUMSTIX

_ARMV6?=	BANANAPI \
		BEAGLEBONE \
		CUBIEBOARD \
		CUBIEBOARD2 \
		CUBOX-HUMMINGBOARD \
		PANDABOARD \
		RPI-B \
		RPI2 \
		WANDBOARD

.for CHECKSUM in SHA512 SHA256
. for _B in ${_BIGIRON}
DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-${_B}.asc
. endfor
. for _V in ${_VMS}
DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-${_V}-vm.asc
. endfor
. for _A in ${_ARM}
DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-arm-${_A}.asc
. endfor
. for _A in ${_ARMV6}
DATA+=		CHECKSUM.${CHECKSUM}-${THISRELEASE}-arm-armv6-${_A}.asc
. endfor
.endfor

.include "${DOC_PREFIX}/share/mk/web.site.mk"

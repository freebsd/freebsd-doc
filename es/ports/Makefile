# $FreeBSD: www/es/ports/Makefile,v 1.6 1999/09/06 07:03:04 peter Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(Makefile.inc)
.include "Makefile.inc"
.endif

.if defined(NOPORTSCVS)
${INDEX}: $${PORTSBASE}/${PINDEX}
	cp ${PORTSBASE}/${PINDEX} ${INDEX}

${Y2K}: $${PORTSBASE}/${PY2K}
	cp ${PORTSBASE}/${PY2K} ${Y2K}

.else
${INDEX}: ${cvsindex}
	cvs -QR co -p ${PINDEX} > ${INDEX}

${Y2K}: ${cvsy2k}
	cvs -QR co -p ${PY2K} > ${Y2K}

.endif

# build the list of available packages only on the 
# main FreeBSD machines
hostname!= hostname

.if defined(NOPORTSCVS)
packages.exists:
.else
packages.exists: ${cvsindex} ${cvsy2k}
.endif
.if ${hostname} == "hub.freebsd.org" || ${hostname} == "freefall.freebsd.org"
.if  exists(${.CURDIR}/../../en/ports/packages.exists)
	cp ${.CURDIR}/../../en/ports/${.TARGET} .
.else
	sh ${.CURDIR}/packages > ${.TARGET}
.endif
.else
	touch ${.TARGET}
.endif

Makefile.gen: index.sgml .NOTMAIN
	echo DOCS= *.sgml > Makefile.gen

index.sgml: ${INDEX} ${Y2K} packages.exists portindex ports.inc .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX} ${Y2K}

install: all

all install clean:
	${MAKE}  ${MAKEFLAGS} -f Makefile.inc0 ${.TARGET}

.include "../web.mk"

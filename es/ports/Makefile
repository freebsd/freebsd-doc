# $FreeBSD: www/en/ports/Makefile,v 1.33 2001/06/14 03:09:56 dd Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif
.if exists(Makefile.inc)
.include "Makefile.inc"
.endif

.if defined(NOPORTSCVS)
${INDEX}: $${PORTSBASE}/${PINDEX}
	cp ${PORTSBASE}/${PINDEX} ${INDEX}
.else
${INDEX}:
	cvs -QR co -p ${PINDEX} > ${INDEX}
.endif

# build the list of available packages only on the 
# main FreeBSD machines
hostname!= hostname

packages.exists:
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

index.sgml: ${INDEX} packages.exists portindex ports.inc .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX} ${.CURDIR}

install: all

all install clean:
	(cd ${.CURDIR} &&${MAKE}  ${MAKEFLAGS} -f ${.CURDIR}/Makefile.inc0 ${.TARGET})

.include "${WEB_PREFIX}/share/mk/web.site.mk"

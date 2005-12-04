# $FreeBSD: www/es/ports/Makefile,v 1.12 2004/11/13 12:23:19 ceri Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif
.if exists(Makefile.inc)
.include "Makefile.inc"
.endif

FETCH_OPT?=	-am

.if defined(NOPORTSCVS)
${INDEX}: $${PORTSBASE}/${PINDEX}
	cp ${PORTSBASE}/${PINDEX} ${INDEX}
.else
${INDEX}:
	${FETCH} ${FETCH_OPT} -o ${INDEX}.bz2 ${INDEXURI}.bz2
	${BUNZIP2} ${INDEX}.bz2
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
	(cd ${.CURDIR} && ${MAKE}  ${MAKEFLAGS} -f ${.CURDIR}/Makefile.inc0 ${.TARGET})

.include "${WEB_PREFIX}/share/mk/web.site.mk"

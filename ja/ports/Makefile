#	$Id: Makefile,v 1.15 1999-05-27 08:58:19 wosch Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.22

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

PORTINDEX=	perl5 ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}
Y2K=		YEAR2000
PY2K=		ports/${Y2K}

COOKIE=		${INDEX} Makefile.gen

.if exists(Makefile.gen)
.include "Makefile.gen"
.endif
CLEANFILES+=	${DOCS} Makefile.gen ${INDEX} ${Y2K} packages.exists

cvsindex= $${CVSROOT}/${PINDEX},v
cvsy2k= $${CVSROOT}/${PY2K},v
_ALLINSTALL= packages.exists ${INDEX} ${Y2K}


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
	sh ${.CURDIR}/../../en/ports/packages > ${.TARGET}
.endif
.else
	touch ${.TARGET}
.endif

Makefile.gen: index.sgml .NOTMAIN
	echo DOCS= *.sgml > Makefile.gen
	${MAKE} ${MAKEFLAGS} ${.IMPSRC}

index.sgml: ${INDEX} ${Y2K} packages.exists portindex ports.inc .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX} ${Y2K}

.include "../../web.mk"

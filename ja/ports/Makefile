#	$Id: Makefile,v 1.13 1999-03-09 15:13:47 motoyuki Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.16

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

PORTINDEX=	perl ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

.if exists(Makefile.gen)
.include "Makefile.gen"
.endif
CLEANFILES+=	${DOCS} Makefile.gen ${INDEX} packages.exists

cvsindex= $${CVSROOT}/${PINDEX},v
_ALLINSTALL= packages.exists ${INDEX}

${INDEX}: ${cvsindex}
	cvs -QR co -p ${PINDEX} > ${INDEX}

# build the list of available packages only on the 
# main FreeBSD machines
hostname!= hostname

packages.exists: ${cvsindex}
.if ${hostname} == "hub.freebsd.org" || ${hostname} == "freefall.freebsd.org"
	sh ${.CURDIR}/../../en/ports/packages > ${.TARGET}
.else
	touch ${.TARGET}
.endif

Makefile.gen: index.sgml .NOTMAIN
	echo DOCS= *.sgml > Makefile.gen
	${MAKE} ${MAKEFLAGS} ${.IMPSRC}

index.sgml: ${INDEX} packages.exists portindex ports.inc .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX}

.include "../../web.mk"

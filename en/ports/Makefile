#	$Id: Makefile,v 1.17 1999-03-11 19:42:24 scrappy Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

PORTINDEX=	perl ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}
Y2K=		YEAR2000
PY2K=		ports/${Y2K}
WWW=		WWW_SITE
PWWW=		ports/${WWW}

COOKIE=		${INDEX} Makefile.gen

.if exists(Makefile.gen)
.include "Makefile.gen"
.endif
CLEANFILES+=	${DOCS} Makefile.gen ${INDEX} ${Y2K} ${WWW} packages.exists

cvsindex= $${CVSROOT}/${PINDEX},v
cvsy2k= $${CVSROOT}/${PY2K},v
cvswww= $${CVSROOT}/${PWWW},v
_ALLINSTALL= packages.exists ${INDEX} ${Y2K} ${WWW}

${INDEX}: ${cvsindex}
	cvs -QR co -p ${PINDEX} > ${INDEX}

${Y2K}: ${cvsy2k}
	cvs -QR co -p ${PY2K} > ${Y2K}

${WWW}: ${cvswww}
	cvs -QR co -p ${PWWW} > ${WWW}

# build the list of available packages only on the 
# main FreeBSD machines
hostname!= hostname

packages.exists: ${cvsindex} ${cvsy2k} ${cvswww}
.if ${hostname} == "hub.freebsd.org" || ${hostname} == "freefall.freebsd.org"
	sh ${.CURDIR}/packages > ${.TARGET}
.else
	touch ${.TARGET}
.endif

Makefile.gen: index.sgml .NOTMAIN
	echo DOCS= *.sgml > Makefile.gen
	${MAKE} ${MAKEFLAGS} ${.IMPSRC}

index.sgml: ${INDEX} ${Y2K} ${WWW} packages.exists portindex ports.inc .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX}

.include "../web.mk"

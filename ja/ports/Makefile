# $FreeBSD: www/ja/ports/Makefile,v 1.16 1999/09/06 07:03:22 peter Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.26

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../../en/ports/Makefile.inc)
.include "../../en/ports/Makefile.inc"
.endif

CVS_READONLY?=	YES
CVS_OPT+=	-Q
.if !empty(CVS_READONLY)
CVS_OPT+=	-R
.endif



.if defined(NOPORTSCVS)
${INDEX}: $${PORTSBASE}/${PINDEX}
	cp ${PORTSBASE}/${PINDEX} ${INDEX}

${Y2K}: $${PORTSBASE}/${PY2K}
	cp ${PORTSBASE}/${PY2K} ${Y2K}

.else
${INDEX}: ${cvsindex}
	cvs ${CVS_OPT} co -p ${PINDEX} > ${INDEX}

${Y2K}: ${cvsy2k}
	cvs ${CVS_OPT} co -p ${PY2K} > ${Y2K}
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
	@if sh ${.CURDIR}/../../en/ports/packages > ${.TARGET}.temp; then \
		mv ${.TARGET}.temp ${.TARGET}; \
	else \
		rm ${.TARGET}.temp; touch ${.TARGET}; \
	fi;
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


.include "../../web.mk"

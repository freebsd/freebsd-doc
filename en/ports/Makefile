# $FreeBSD: www/en/ports/Makefile,v 1.28 2000/09/30 00:21:39 nbm Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(Makefile.inc)
.include "Makefile.inc"
.endif

CVS_READONLY?=	YES
CVS_OPT+=	-Q
.if !empty(CVS_READONLY)
CVS_OPT+=	-R
.endif

#
# This hack is allows to build www/ tree for case when ports/ located
# in other repository, for example Repository of Translation Project
#
.if defined(PORTSCVSROOT) && !empty(PORTSCVSROOT)
CVS_OPT+=	-d ${PORTSCVSROOT}
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
	@if sh ${.CURDIR}/packages > ${.TARGET}.temp; then \
		mv ${.TARGET}.temp ${.TARGET}; \
	else \
		rm ${.TARGET}.temp; touch ${.TARGET}; \
	fi;
.else
	touch ${.TARGET}
.endif

Makefile.gen: index.sgml .NOTMAIN
	echo DOCS= *.sgml > Makefile.gen

index.sgml: ${INDEX} ${Y2K} categories packages.exists portindex ports.inc .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX} ${Y2K} ${.CURDIR}

install: all

all install clean:
	(cd ${.CURDIR} && ${MAKE}  ${MAKEFLAGS} -f Makefile.inc0 ${.TARGET})


.include "../web.mk"

# $FreeBSD$
# The FreeBSD Russian Documentation Project
# $FreeBSDru: frdp/www/ru/ports/Makefile,v 1.5 2001/12/06 12:25:32 phantom Exp $
# Original revision: 1.34

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

.if exists(../../en/ports/Makefile.inc)
.include "../../en/ports/Makefile.inc"
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
	${CP} ${PORTSBASE}/${PINDEX} ${INDEX}
.else
${INDEX}: ${cvsindex}
	${CVS} ${CVS_OPT} co -p ${PINDEX} > ${INDEX}
.endif

# build the list of available packages only on the 
# main FreeBSD machines
hostname!= hostname

#
# don't build the packages links if NO_PACKAGES_LINK
# is set and not empty.
#
# XXX: you can set NO_PACKAGES_LINK to your hostname to
#      test the packages link generation
#
.if defined(NO_PACKAGES_LINK) && !empty(NO_PACKAGES_LINK)
hostname=      ${NO_PACKAGES_LINK}
.endif

packages.exists:
.if ${hostname} == "hub.freebsd.org" || ${hostname} == "freefall.freebsd.org"
.if  exists(${.CURDIR}/../../en/ports/packages.exists)
	${CP} ${.CURDIR}/../../en/ports/${.TARGET} ${.CURDIR}
.else
	@if ${SH} ${.CURDIR}/../../en/ports/packages > ${.TARGET}.temp; then \
		${MV} ${.TARGET}.temp ${.TARGET}; \
	else \
		${RM} ${.TARGET}.temp; touch ${.TARGET}; \
	fi;
.endif
.else
	${TOUCH} ${.TARGET}
.endif

Makefile.gen: index.sgml .NOTMAIN
	${ECHO_CMD} DOCS= *.sgml > Makefile.gen

index.sgml: ${INDEX} categories packages.exists portindex ports.inc .NOTMAIN
	${RM} -f *.sgml
	${PORTINDEX} ${INDEX} ${.CURDIR}

install: all

all install clean:
	(cd ${.CURDIR}; \
		 ${MAKE} ${MAKEFLAGS} -f ${.CURDIR}/Makefile.inc0 ${.TARGET})

.include "${WEB_PREFIX}/share/mk/web.site.mk"

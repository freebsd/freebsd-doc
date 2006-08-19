# $FreeBSD: www/en/ports/Makefile,v 1.46 2005/12/15 01:02:28 linimon Exp $

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

.if defined(PINDEX_OVERRIDE)
${INDEX}: ${PINDEX_OVERRIDE}
	${CP} ${PINDEX_OVERRIDE} ${INDEX}
.elif defined(NOPORTSNET)
${INDEX}: $${PORTSBASE}/${PINDEX}
	${CP} ${PORTSBASE}/${PINDEX} ${INDEX}
.else
${INDEX}:
	${FETCH} ${FETCH_OPT} -o ${INDEX}.bz2 ${INDEXURI}.bz2
	${BUNZIP2} ${INDEX}.bz2
.endif

HOSTNAME!= hostname
.if ${HOSTNAME} == "hub.freebsd.org" || ${HOSTNAME} == "freefall.freebsd.org" || ${HOSTNAME} == "www.freebsd.org"
CLUSTER_MACHINE=	YES
.endif

# Build the list of available packages, but only on the main FreeBSD machines.
# Don't build the list if NO_PACKAGES_LINK is set and not empty.
#
packages.exists:
.if defined(CLUSTER_MACHINE) && (!defined(NO_PACKAGES_LINK) || empty(NO_PACKAGES_LINK))
	@if ${SH} ${.CURDIR}/packages > ${.TARGET}.temp; then \
		${MV} ${.TARGET}.temp ${.TARGET}; \
	else \
		${RM} ${.TARGET}.temp; ${TOUCH} ${.TARGET}; \
	fi;
.else
	${TOUCH} ${.TARGET}
.endif

Makefile.gen: categories-alpha.sgml categories-grouped.sgml index.sgml \
	installing.sgml master-index.sgml references.sgml searching.sgml \
	statistics.ent updating.sgml .NOTMAIN
	(	${ECHO_CMD} TIDY=${PERL};\
		${ECHO_CMD} TIDYOPTS="-i'' -npe 's,\"-//FreeBSD//DTD HTML 4.01 Transitional-Based Extension//EN\",\"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\",'";\
		${ECHO_CMD} DOCS= *.sgml;\
		${ECHO_CMD} -n "DYNAMIC_DOCS= ";\
		${ECHO_CMD} -n " categories-alpha.sgml";\
		${ECHO_CMD} -n " categories-grouped.sgml";\
		${ECHO_CMD} -n " master-index.sgml";\
		${ECHO_CMD} -n " statistics.ent";\
	) > Makefile.gen
	for categoryfile in ${CATEGORYLIST}; do \
		${ECHO_CMD} -n " $$categoryfile.sgml" >> Makefile.gen; \
	done
	${ECHO_CMD} >> Makefile.gen
.if defined(NO_TIDY)
	${ECHO_CMD} NO_TIDY=${NO_TIDY} >> Makefile.gen
.endif

.if defined(CLUSTER_MACHINE)
PORTS_TARGZ_URL?= ftp://ftp-master.FreeBSD.org/pub/FreeBSD/ports/ports/ports.tar.gz
.else
PORTS_TARGZ_URL?= ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/ports/ports.tar.gz
.endif

ports.size:
.if defined (NOPORTSNET)
	touch ${.TARGET}
.else
	${RM} -f ${.TARGET}
	${FETCH} -s ${PORTS_TARGZ_URL} > ${.TARGET}
.endif

# this builds: categories-alpha.sgml, categories-grouped.sgml,
# master-index.sgml, statistics.ent, <category>.sgml
CATEGORYLIST=`grep "^[a-z]" categories | sed -e s"/,.*//"`
categories-alpha.sgml: ${INDEX} categories categories.descriptions \
	packages.exists portindex ports.ent ports.size .NOTMAIN
	${RM} -f categories-alpha.sgml categories-grouped.sgml \
		master-index.sgml statistics.ent
	for categoryfile in ${CATEGORYLIST}; do \
		rm -f "$$categoryfile.sgml"; \
	done
	${PORTINDEX} ${INDEX} ${.CURDIR}

install: all beforeinstall

all install clean:
	cd ${.CURDIR}; \
		${MAKE} ${MAKEFLAGS} -f ${.CURDIR}/Makefile.inc0 ${.TARGET}
.if defined(WITH_PORTS_GROWTH)
	cd growth; \
		${MAKE} ${MAKEFLAGS} ${.TARGET}
beforeinstall:
.else
beforeinstall:
	${SED} -i "" -e 's,HREF="growth,href="http://www.FreeBSD.org/ports/growth,' index.html
	${SED} -i "" -e 's,HREF="growth,href="http://www.FreeBSD.org/ports/growth,' references.html
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"

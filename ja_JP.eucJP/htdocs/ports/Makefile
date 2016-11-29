# $FreeBSD$
# The FreeBSD Japanese Documentation Project
# Original revision: r39545

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif
.if exists(${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/Makefile.inc)
.include "${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/Makefile.inc"
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
.if ${HOSTNAME} == "freefall.freebsd.org" || ${HOSTNAME} == "build-web.ysv.freebsd.org"
CLUSTER_MACHINE=	YES
.endif

# Build the list of available packages, but only on the main FreeBSD machines.
# Don't build the list if NO_PACKAGES_LINK is set and not empty.
#
packages.exists:
.if defined(CLUSTER_MACHINE) && (!defined(NO_PACKAGES_LINK) || empty(NO_PACKAGES_LINK))
.if  exists(${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/packages.exists)
	cp ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/${.TARGET} .
.else
	@if ${SH} ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/packages > ${.TARGET}.temp; then \
		${MV} ${.TARGET}.temp ${.TARGET}; \
	else \
		${RM} ${.TARGET}.temp; ${TOUCH} ${.TARGET}; \
	fi;
.endif
.else
	${TOUCH} ${.TARGET}
.endif

Makefile.gen: categories-alpha.xml categories-grouped.xml index.xml \
	installing.xml master-index.xml references.xml searching.xml \
	statistics.ent updating.xml .NOTMAIN
	(	${ECHO_CMD} DOCS= *.xml | ${SED} 's|catalog-cwd\.xml||g';\
		${ECHO_CMD} -n "DYNAMIC_DOCS= ";\
		${ECHO_CMD} -n " categories-alpha.xml";\
		${ECHO_CMD} -n " categories-grouped.xml";\
		${ECHO_CMD} -n " master-index.xml";\
		${ECHO_CMD} -n " statistics.ent";\
	) > Makefile.gen
	for categoryfile in ${CATEGORYLIST}; do \
		${ECHO_CMD} -n " $$categoryfile.xml" >> Makefile.gen; \
	done
	${ECHO_CMD} >> Makefile.gen

# this builds: categories-alpha.xml, categories-grouped.xml,
# master-index.xml, statistics.ent, <category>.xml
CATEGORYLIST=`grep "^[a-z]" ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/categories | sed -e s"/,.*//"`
categories-alpha.xml: ${INDEX} categories categories.descriptions \
	packages.exists portindex ports.ent .NOTMAIN
	${RM} -f categories-alpha.xml categories-grouped.xml \
		master-index.xml statistics.ent
	for categoryfile in ${CATEGORYLIST}; do \
		rm -f "$$categoryfile.xml"; \
	done
	${PORTINDEX} ${INDEX} ${.CURDIR}

install: all beforeinstall

all install clean:
	cd ${.CURDIR}; \
		${MAKE} ${MAKEFLAGS} -f ${.CURDIR}/Makefile.inc0 ${.TARGET}
.if defined(WITH_PORTS_GROWTH)
# Because We refer www/ports/growth/status.png on web site from ports.inc,
# don't need to have local version of the image file.
#	cd growth; \
#		${MAKE} ${MAKEFLAGS} ${.TARGET}
beforeinstall:
.else
beforeinstall:
	${SED} -i "" -e 's,href="growth,href="http://www.FreeBSD.org/ports/growth,' index.html
	${SED} -i "" -e 's,href="growth,href="http://www.FreeBSD.org/ports/growth,' references.html
.endif

.include "${DOC_PREFIX}/share/mk/web.site.mk"

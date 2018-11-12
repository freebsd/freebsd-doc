#
# $FreeBSD$
#

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# At build time, we have to link to the doc/ directory at the same level
# as the www/ tree.
all:
	${LN} -fs ${.OBJDIR}/../../../doc/es_ES.ISO8859-1/books/handbook/* .

# At install time the ../doc/ directory has been populated, so we can
# link in to there instead.
install:
	[ -d ${DOCINSTALLDIR} ] || ${MKDIR} ${DOCINSTALLDIR}
	cd ${DOCINSTALLDIR}; \
		${LN} -fs ../doc/es_ES.ISO8859-1/books/handbook/* \
			${DOCINSTALLDIR}

.include "${DOC_PREFIX}/share/mk/web.site.mk"

#
# $FreeBSD: www/ja/handbook/Makefile,v 1.8 1999/12/07 14:03:26 kuriyama Exp $
# Original revision:	1.8
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
	${LN} -fs ${.OBJDIR}/../../../doc/ja_JP.eucJP/books/handbook/* .

# At install time the ../doc/ directory has been populated, so we can
# link in to there instead.
install:
	[ -d ${DOCINSTALLDIR} ] || ${MKDIR} ${DOCINSTALLDIR}
	cd ${DOCINSTALLDIR}; \
		${LN} -fs ../doc/ja_JP.eucJP/books/handbook/* \
			  ${DOCINSTALLDIR}

.include "${WEB_PREFIX}/share/mk/web.site.mk"

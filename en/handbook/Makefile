#
# $FreeBSD: www/en/FAQ/Makefile,v 1.4 1999/09/15 20:37:03 wosch Exp $
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
	ln -fs ${.CURDIR}/../../../doc/en_US.ISO_8859-1/books/handbook/* .

# At install time the ../doc/ directory has been populated, so we can
# link in to there instead.
install:
	[ -d ${DOCINSTALLDIR} ] || mkdir ${DOCINSTALLDIR}
	(cd ${DOCINSTALLDIR} && ln -fs ../doc/en_US.ISO_8859-1/books/handbook/* ${DOCINSTALLDIR})

.include "${WEB_PREFIX}/share/mk/web.site.mk"


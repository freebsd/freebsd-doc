#
# $FreeBSD: www/ja/FAQ/Makefile,v 1.6 1999/12/07 14:03:29 kuriyama Exp $
# Original revision:	1.7
#
# Build the FreeBSD FAQ *outside* of the www tree, and install it
# in to the right place as necessary.

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# At build time, we have to link to the doc/ directory at the same level
# as the www/ tree.
all:
	${LN} -fs ${.OBJDIR}/../../../doc/ja_JP.eucJP/books/faq/* .

# At install time the www/en/doc/ directory has been populated, so we can
# link in to there instead.
install:
	[ -d ${DOCINSTALLDIR} ] || ${MKDIR} ${DOCINSTALLDIR}
	cd ${DOCINSTALLDIR}; \
		${LN} -fs ../doc/ja_JP.eucJP/books/faq/* ${DOCINSTALLDIR}

.include "${WEB_PREFIX}/share/mk/web.site.mk"

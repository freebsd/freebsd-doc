#
# $FreeBSD: www/en/FAQ/Makefile,v 1.4 1999/09/15 20:37:03 wosch Exp $
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
	ln -fs ${.CURDIR}/../../../doc/en_US.ISO_8859-1/books/faq/* .

# At install time the www/en/doc/ directory has been populated, so we can
# link in to there instead.
install:
	[ -d ${DOCINSTALLDIR} ] || mkdir ${DOCINSTALLDIR}
	(cd ${DOCINSTALLDIR} && ln -fs ../doc/en_US.ISO_8859-1/books/faq/* ${DOCINSTALLDIR})

.include "${WEB_PREFIX}/share/mk/web.site.mk"


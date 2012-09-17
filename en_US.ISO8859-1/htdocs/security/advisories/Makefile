# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

BULKDATADIRS=	${DOC_PREFIX}/share/security/advisories

# Things that went wrong in the past and had to be fixed.
# SYMLINKS+=	Source Target
SYMLINKS=	FreeBSD-SA-09:06.ktimer.asc FreeBSD-SA-06:09.ktimer.asc

.include "${DOC_PREFIX}/share/mk/web.site.mk"

# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

BULKDATADIRS=	${DOC_PREFIX}/share/security/patches

# Things that went wrong in the past and had to be fixed.
# Source Target
SYMLINKS=
SYMLINKS+=	SA-04:04/tcp47.patch tcp47.patch
SYMLINKS+=	SA-04:04/tcp47.patch.asc tcp47.patch.asc
SYMLINKS+=	SA-04:04/tcp52.patch tcp52.patch
SYMLINKS+=	SA-04:04/tcp52.patch.asc tcp52.patch.asc
SYMLINKS+=	SA-10:05 SA-10-05
SYMLINKS+=	kadmin.patch SA-04:09/kadmind.patch
SYMLINKS+=	kadmin.patch.asc SA-04:09/kadmind.patch.asc
SYMLINKS+=	kadmind.patch SA-02:40/kadmin.patch
SYMLINKS+=	kadmind.patch.asc SA-02:40/kadmin.patch.asc
SYMLINKS+=	ip-options.diff SA-00:23/ip_options.diff
SYMLINKS+=	ip-options.diff.asc SA-00:23/ip_options.diff.asc
# Lost?
#SYMLINKS+=	../../tools/libfind.sh patches/SA-00:17/libfind.sh

.include "${DOC_PREFIX}/share/mk/web.site.mk"

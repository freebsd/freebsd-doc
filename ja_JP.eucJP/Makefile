# $FreeBSD$
#
# Original revision: 1.5
#

SUBDIR = articles
SUBDIR+= books

.if defined(WITH_JPMAN)
SUBDIR+= man
.endif

COMPAT_SYMLINK = ja

DOC_PREFIX?= ${.CURDIR}/..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

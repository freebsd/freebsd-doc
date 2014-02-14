# $FreeBSD$

DOC_PREFIX?=	${.CURDIR}/../../../..
RELN_ROOT?=	${.CURDIR}/../../relnotes

.if exists(${RELN_ROOT}/Makefile.inc)
.include "${RELN_ROOT}/Makefile.inc"
.endif
.if exists(${.CURDIR}/Makefile.inc)
.include "${.CURDIR}/Makefile.inc"
.endif

XXX=		errata \
		hardware \
		readme \
		relnotes

.if ${.TARGET:M*install} != ""
DATA=		docbook.css
.  for _D in ${XXX}
.   if exists(${.CURDIR}/${_D}.html)
DATA+=		${_D}.html
.   endif
.  endfor
. include "${DOC_PREFIX}/share/mk/web.site.mk"

.else
SUBDIR=		${XXX}
. include "${DOC_PREFIX}/share/mk/doc.subdir.mk"
.endif

COMPAT_SYMLINK=	en
LANGCODE=	en_US.ISO8859-1
_LANGCODE=	en_US.ISO8859-1

. include "${RELN_ROOT}/share/mk/doc.relnotes.mk"

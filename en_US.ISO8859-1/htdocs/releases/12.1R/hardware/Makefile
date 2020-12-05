# $FreeBSD$

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif
.if exists(../Makefile.hardware)
.include "../Makefile.hardware"
.endif

ARCHLIST?=	${DOC_PREFIX}/share/misc/dev.archlist.txt

MAN2HWNOTES_CMD=${DOC_PREFIX}/share/misc/man2hwnotes.pl
.if defined(HWNOTES_MI)
MAN2HWNOTES_FLAGS=
.else
MAN2HWNOTES_FLAGS=	-c
.endif

DOC?=			hardware
FORMATS?=		html txt
INSTALL_COMPRESSED?=	gz
INSTALL_ONLY_COMPRESSED=

.if ${.TARGET:M${DOC}.html} && !make(install)
MAN4TMP!=	${MKTEMP} -d ${.CURDIR}/svn.XXXXXXXX
MAN4DIR=	${MAN4TMP}
.if exists(${MAN4DIR})
	rm -rf ${MAN4DIR}
.endif

MAN4PAGES?=	${MAN4DIR}/*.4 ${MAN4DIR}/man4.*/*.4
hardware.parsed.xml:	dev-auto.ent man4-rmsrc
dev-auto.ent:	man4-src-checkout
	${PERL} ${MAN2HWNOTES_CMD} ${MAN2HWNOTES_FLAGS} -a ${ARCHLIST} -o ${.TARGET} ${MAN4PAGES} || (rm -f ${.TARGET})
CLEANFILES+=	dev-auto.ent
CLEANDIRS+=	${.CURDIR}/svn.*

.ORDER:			man4-rmsrc man4-src-checkout
man4-src-checkout:
	mkdir -p ${MAN4TMP}
	${SVN} co svn://svn.freebsd.org/base/${SRCBRANCH}/share/man/man4 \
		${MAN4TMP}

man4-rmsrc:
	@# Just in case.
	rm -rf ${MAN4DIR} || true
.endif

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

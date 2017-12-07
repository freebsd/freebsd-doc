# $FreeBSD$

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# The path used on build-web is 'src/share/man/man4'.
.if make(all) && (!defined(MAN4DIR) || empty(MAN4DIR) || !exists(${MAN4DIR}))
. warning "MAN4DIR not found.  Unable to build hardware.html"
.endif

MAN4PAGES?=	${MAN4DIR}/*.4 ${MAN4DIR}/man4.*/*.4
ARCHLIST?=	${DOC_PREFIX}/share/misc/dev.archlist.txt

MAN2HWNOTES_CMD=${DOC_PREFIX}/share/misc/man2hwnotes.pl
.if defined(HWNOTES_MI)
MAN2HWNOTES_FLAGS=
.else
MAN2HWNOTES_FLAGS=	-c
.endif

DOC=			hardware
FORMATS?=		html
INSTALL_COMPRESSED?=	gz
INSTALL_ONLY_COMPRESSED=

hardware.parsed.xml: dev-auto.ent
dev-auto.ent:
	${PERL} ${MAN2HWNOTES_CMD} ${MAN2HWNOTES_FLAGS} -a ${ARCHLIST} -o ${.TARGET} ${MAN4PAGES} || (rm -f ${.TARGET})
CLEANFILES+=	dev-auto.ent

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

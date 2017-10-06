# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOC_PREFIX?=	${.CURDIR}/../../../../..
RELN_ROOT?=	${.CURDIR}/..

DOC=			relnotes
FORMATS?=		html
INSTALL_COMPRESSED?=	gz
INSTALL_ONLY_COMPRESSED=

JADEFLAGS+=		-V %generate-article-toc%

SRCS?=			relnotes.xml

DATA+=			${DOC}.html

CLEANFILES+=		${DOC}.html \
			${DOC}.txt \
			catalog-cwd.xml \
			autogen.ent \
			${DOC}.parsed.*

install: ${DOC}.html
	mkdir -p ${DOCINSTALLDIR}
	${INSTALL_DOCS} ${DATA} ${DOCINSTALLDIR}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

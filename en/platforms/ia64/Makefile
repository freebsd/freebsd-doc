# $FreeBSD: www/en/platforms/ia64/Makefile,v 1.3 2004/09/25 17:36:31 marcel Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	machines.sgml refs.sgml
DATA=	mckinley-die.png merced-die.png

_GEN=	index.html todo.html

DATA+=	${_GEN}
CLEANFILES+= ${_GEN}

.SUFFIXES: .xsl .html
.xsl.html: news.xml
	${XSLTPROC} ${XSLTPROCOPTS:N-nonet} -o ${.TARGET} ${.ALLSRC}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"

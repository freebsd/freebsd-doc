# $FreeBSD: www/en/platforms/ia64/Makefile,v 1.2 2004/08/31 18:13:27 marcel Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	machines.sgml refs.sgml todo.sgml
DATA=	mckinley-die.png merced-die.png

_GEN=	index.html

DATA+=	${_GEN}
CLEANFILES+= ${_GEN}

index.html: index.xsl news.xml
	${XSLTPROC} ${XSLTPROCOPTS:N-nonet} -o ${.TARGET} ${.ALLSRC}
.if !defined(NO_TIDY)
	-${TIDY} ${TIDYOPTS} ${.TARGET}
.endif

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD: www/en/platforms/ia64/Makefile,v 1.4 2004/10/19 04:14:05 marcel Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	machines.sgml refs.sgml
DATA=	i2inside.png mckinley-die.png merced-die.png montecito-die.png

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

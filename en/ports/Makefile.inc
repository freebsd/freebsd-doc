# $FreeBSD: www/en/ports/Makefile.inc,v 1.2 2000/02/28 12:46:07 phantom Exp $

PORTINDEX=	${PERL} ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}
Y2K=		YEAR2000
PY2K=		ports/${Y2K}

COOKIE=		${INDEX} Makefile.gen

CLEANFILES+=	${INDEX} 
CLEANFILES+=	${Y2K}
CLEANFILES+=	packages.exists.temp  packages.exists
CLEANFILES+= 	${DOCS} 
CLEANFILES+=	Makefile.gen

cvsindex= $${CVSROOT}/${PINDEX},v
cvsy2k= $${CVSROOT}/${PY2K},v

_ALLINSTALL= packages.exists ${INDEX} ${Y2K}


# $FreeBSD: www/en/ports/Makefile.inc,v 1.4 2001/01/01 12:33:23 kuriyama Exp $

PORTINDEX=	${PERL} ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

CLEANFILES+=	${INDEX} 
CLEANFILES+=	packages.exists.temp  packages.exists
CLEANFILES+= 	${DOCS} 
CLEANFILES+=	Makefile.gen

cvsindex= $${CVSROOT}/${PINDEX},v

_ALLINSTALL= packages.exists ${INDEX} categories


# $FreeBSD: www/en/ports/Makefile.inc,v 1.5 2001/01/04 22:12:42 wosch Exp $

PORTINDEX=	${PERL} ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

CLEANFILES+=	${INDEX} 
CLEANFILES+=	packages.exists.temp  packages.exists
CLEANFILES+= 	${DOCS} 
CLEANFILES+=	Makefile.gen

_ALLINSTALL= packages.exists ${INDEX} categories


# $FreeBSD: www/en/ports/Makefile.inc,v 1.6 2001/06/14 03:09:56 dd Exp $

PORTINDEX=	${PERL} ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

CLEANFILES+=	${INDEX} 
CLEANFILES+=	packages.exists.temp  packages.exists
CLEANFILES+= 	${DOCS} 
CLEANFILES+=	Makefile.gen
CLEANFILES+=	ports.size

_ALLINSTALL= packages.exists ${INDEX} categories


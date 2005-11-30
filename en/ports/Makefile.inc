# $FreeBSD: www/en/ports/Makefile.inc,v 1.7 2005/11/15 10:09:26 osa Exp $

PORTINDEX=	${PERL} ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

CLEANFILES+=	${INDEX} ${INDEX}.bz2
CLEANFILES+=	packages.exists.temp  packages.exists
CLEANFILES+= 	${DOCS} 
CLEANFILES+=	Makefile.gen
CLEANFILES+=	ports.size

_ALLINSTALL= packages.exists ${INDEX} categories


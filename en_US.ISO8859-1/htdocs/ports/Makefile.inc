# $FreeBSD: www/en/ports/Makefile.inc,v 1.9 2005/12/15 01:02:28 linimon Exp $

PORTINDEX=	${PERL} ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

CLEANFILES+=	${INDEX} ${INDEX}.bz2
CLEANFILES+=	packages.exists.temp  packages.exists
CLEANFILES+= 	${DYNAMIC_DOCS} 
CLEANFILES+=	Makefile.gen
CLEANFILES+=	ports.count ports.size

_ALLINSTALL= packages.exists categories


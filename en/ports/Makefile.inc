# $FreeBSD: www/en/ports/Makefile.inc,v 1.3 2000/04/20 16:42:04 phantom Exp $

PORTINDEX=	${PERL} ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

CLEANFILES+=	${INDEX} 
CLEANFILES+=	packages.exists.temp  packages.exists
CLEANFILES+= 	${DOCS} 
CLEANFILES+=	Makefile.gen

cvsindex= $${CVSROOT}/${PINDEX},v

_ALLINSTALL= packages.exists ${INDEX}


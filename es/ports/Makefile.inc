
PORTINDEX=	perl5 ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

CLEANFILES+=	${INDEX} 
CLEANFILES+=	packages.exists.temp  packages.exists
CLEANFILES+= 	${DOCS} 
CLEANFILES+=	Makefile.gen

cvsindex= $${CVSROOT}/${PINDEX},v

_ALLINSTALL= packages.exists ${INDEX}


# $FreeBSD$
# $FreeBSDde$
# basiert auf: r47265

PORTINDEX=	${PERL} ${.CURDIR}/../../../en_US.ISO8859-1/htdocs/ports/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

CLEANFILES+=	${INDEX} ${INDEX}.bz2
CLEANFILES+=	packages.exists.temp  packages.exists
CLEANFILES+= 	${DYNAMIC_DOCS}
CLEANFILES+=	Makefile.gen
CLEANFILES+=	ports.count

_ALLINSTALL= packages.exists categories


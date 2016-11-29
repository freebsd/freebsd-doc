#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/ports/Makefile.inc,v 1.3 2004/01/06 17:28:41 andy Exp $
#
#  Original revision: r39534
#

PORTINDEX=	${PERL} ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

CLEANFILES+=	${INDEX} ${INDEX}.bz2
CLEANFILES+=	packages.exists.temp  packages.exists
CLEANFILES+= 	${DYNAMIC_DOCS}
CLEANFILES+=	Makefile.gen
CLEANFILES+=	ports.count

_ALLINSTALL= packages.exists categories


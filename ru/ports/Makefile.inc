#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/ports/Makefile.inc,v 1.3 2004/01/06 17:28:41 andy Exp $
#
#  Original revision: 1.6
#

PORTINDEX=	${PERL} ${.CURDIR}/portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

CLEANFILES+=	${INDEX} 
CLEANFILES+=	packages.exists.temp  packages.exists
CLEANFILES+= 	${DOCS} 
CLEANFILES+=	Makefile.gen

_ALLINSTALL= packages.exists ${INDEX} categories


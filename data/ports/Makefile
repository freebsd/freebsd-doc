#	$Id: Makefile,v 1.11 1998-07-23 10:59:39 wosch Exp $

PORTINDEX=	perl ./portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

.if exists(Makefile.gen)
.include "Makefile.gen"
CLEANFILES+=	${DOCS} Makefile.gen ${INDEX} packages.exists
.endif

_ALLINSTALL= packages.exists

${INDEX}: $${CVSROOT}/${PINDEX},v
	cvs -QR co -p ${PINDEX} > ${INDEX}

packages.exists:
	./packages > ${.TARGET}

Makefile.gen: index.sgml .NOTMAIN
	echo DOCS= *.sgml > Makefile.gen
	${MAKE} ${MAKEFLAGS} ${.IMPSRC}

index.sgml: ${INDEX} packages.exists portindex ports.inc .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX}

.include "../web.mk"

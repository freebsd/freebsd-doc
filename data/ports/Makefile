#	$Id: Makefile,v 1.10 1998-07-16 17:03:54 wosch Exp $

PORTINDEX=	perl ./portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

.if exists(Makefile.gen)
.include "Makefile.gen"
CLEANFILES+=	${DOCS} Makefile.gen ${INDEX} packages.exists
.endif

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

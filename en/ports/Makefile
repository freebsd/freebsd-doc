#	$Id: Makefile,v 1.9 1998-06-10 15:52:30 wosch Exp $

PORTINDEX=	perl ./portindex
INDEX=		ports/INDEX

COOKIE=		${INDEX} Makefile.gen

.if exists(Makefile.gen)
.include "Makefile.gen"
CLEANFILES+=	${DOCS} Makefile.gen ${INDEX} packages.exists
.endif

${INDEX}:
	cvs -QR co ${INDEX}

packages.exists:
	./packages > ${.TARGET}

Makefile.gen: index.sgml .NOTMAIN
	echo DOCS= *.sgml > Makefile.gen
	${MAKE} ${MAKEFLAGS} ${.IMPSRC}

index.sgml: ${INDEX} packages.exists portindex ports.inc .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX}

.include "../web.mk"

#	$Id: Makefile,v 1.8 1998-04-14 23:46:42 steve Exp $

PORTINDEX=	perl ./portindex
INDEX=		ports/INDEX

COOKIE=		${INDEX} Makefile.gen

.if exists(Makefile.gen)
.include "Makefile.gen"
CLEANFILES+=	${DOCS} Makefile.gen ${INDEX}
.endif

${INDEX}:
	cvs -QR co ${INDEX}

Makefile.gen: index.sgml .NOTMAIN
	echo DOCS= *.sgml > Makefile.gen
	${MAKE} ${MAKEFLAGS} ${.IMPSRC}

index.sgml: ${INDEX} portindex ports.inc .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX}

.include "../web.mk"

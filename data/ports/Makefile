#	$Id: Makefile,v 1.2 1996-09-24 18:56:21 jfieber Exp $

PORTINDEX=	./portindex
INDEX=		ports/INDEX

COOKIE=		index Makefile.gen

.if exists(Makefile.gen)
.include "Makefile.gen"
CLEANFILES+=	${DOCS} Makefile.gen
.endif

Makefile.gen: index.sgml .NOTMAIN
	echo DOCS= *.sgml > Makefile.gen
	${MAKE} ${MAKEFLAGS} ${.IMPSRC}

index.sgml: ${INDEX} .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX}

index: .NOTMAIN
	cvs co ${INDEX}

.include "../web.mk"

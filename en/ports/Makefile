#	$Id: Makefile,v 1.3 1996-10-24 23:48:43 jfieber Exp $

PORTINDEX=	./portindex
INDEX=		ports/INDEX
CVSDIR=		ports/INDEX

COOKIE=		cvsdir Makefile.gen

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

.include "../web.mk"

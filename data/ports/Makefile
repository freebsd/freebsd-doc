#	$Id: Makefile,v 1.4 1997-04-23 22:23:02 jfieber Exp $

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

index.sgml: ${INDEX} portindex ports.inc .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX}

.include "../web.mk"

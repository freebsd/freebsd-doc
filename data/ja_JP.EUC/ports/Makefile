#	$Id: Makefile,v 1.1.1.1 1997-11-23 22:23:06 max Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.4

PORTINDEX=	./portindex
INDEX=		../../ports/ports/INDEX
#CVSDIR=	ports/INDEX

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

.include "../../web.mk"

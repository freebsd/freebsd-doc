#	$Id: Makefile,v 1.3 1998-01-18 22:27:40 jfieber Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.4

PORTINDEX=	./portindex
INDEX=		ports/INDEX

COOKIE=		index Makefile.gen

.if exists(Makefile.gen)
.include "Makefile.gen"
CLEANFILES+=	${DOCS} Makefile.gen
.endif

index:
	cvs co ${INDEX}

Makefile.gen: index.sgml .NOTMAIN
	echo DOCS= *.sgml > Makefile.gen
	${MAKE} ${MAKEFLAGS} ${.IMPSRC}

index.sgml: ${INDEX} portindex ports.inc categories.ja_JP.EUC .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX}

.include "../../web.mk"

PORTINDEX=	./portindex

.if exists(Makefile.gen)
.include "Makefile.gen"
CLEANFILES+=	${DOCS} Makefile.gen
COOKIE=		Makefile.gen
.include "../web.mk"
.else
foo .DEFAULT: 
	${MAKE} ${MAKEFLAGS} Makefile.gen
	${MAKE} ${MAKEFLAGS} ${.IMPSRC}
.endif

Makefile.gen: index.sgml .NOTMAIN
	if [ -f Makefile.gen ]; then mv Makefile.gen Makefile.gen.bak; fi
	echo DOCS= *.sgml > Makefile.gen

index.sgml: ports/INDEX .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ports/INDEX


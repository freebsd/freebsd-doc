#	$Id: Makefile,v 1.5 1998-04-25 16:41:06 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.8

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

index.sgml: ${INDEX} portindex ports.inc categories.ja_JP.EUC .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX}

.include "../../web.mk"

#	$Id: Makefile,v 1.7 1998-07-16 17:17:18 wosch Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.8

PORTINDEX=	perl ./portindex
INDEX=		INDEX
PINDEX=		ports/${INDEX}

COOKIE=		${INDEX} Makefile.gen

.if exists(Makefile.gen)
.include "Makefile.gen"
CLEANFILES+=	${DOCS} Makefile.gen ${INDEX}
.endif

${INDEX}: $${CVSROOT}/${PINDEX},v
	cvs -QR co -p ${PINDEX} > ${INDEX}

Makefile.gen: index.sgml .NOTMAIN
	echo DOCS= *.sgml > Makefile.gen
	${MAKE} ${MAKEFLAGS} ${.IMPSRC}

index.sgml: ${INDEX} portindex ports.inc categories.ja_JP.EUC .NOTMAIN
	rm -f *.sgml
	${PORTINDEX} ${INDEX}

.include "../../web.mk"

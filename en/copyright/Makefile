# $Id: Makefile,v 1.4 1998-08-16 12:51:02 wosch Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS=	license.sgml
DOCS+=	daemon.sgml
DOCS+=	copyright.sgml

INDEXLINK= copyright.html

DATA+= COPYING COPYING.LIB ${LEGAL}

# FreeBSD Ports redistribution restrictions
LEGAL= LEGAL
CLEANFILES+= ${LEGAL}
${LEGAL}: $${CVSROOT}/ports/LEGAL,v
	co -q -p ${.ALLSRC} > ${.TARGET}

.include "../web.mk"

# $Id: Makefile,v 1.6 1998-08-20 04:12:12 hanai Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.4

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS=	license.sgml
DOCS+=	daemon.sgml
DOCS+=  copyright.sgml

INDEXLINK= copyright.html

# DATA+= COPYING COPYING.LIB ${LEGAL}

# FreeBSD Ports redistribution restrictions
#LEGAL= LEGAL
#CLEANFILES+= ${LEGAL}
#${LEGAL}: $${CVSROOT}/ports/LEGAL,v
#       co -q -p ${.ALLSRC} > ${.TARGET}

.include "../../web.mk"

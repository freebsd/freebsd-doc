# $Id: Makefile,v 1.7 1999-01-14 15:25:41 motoyuki Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.6

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS=	license.sgml
#DOCS+= freebsd-license.sgml
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

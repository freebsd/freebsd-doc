# $FreeBSD: www/ja/copyright/Makefile,v 1.9 1999/09/06 07:03:17 peter Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.8

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS=	license.sgml
DOCS+= freebsd-license.sgml
DOCS+=	daemon.sgml
DOCS+=  copyright.sgml

INDEXLINK= copyright.html

# DATA+= COPYING COPYING.LIB ${LEGAL}

# FreeBSD Ports redistribution restrictions
#LEGAL= LEGAL
#CLEANFILES+= ${LEGAL}
#.if defined(NOPORTSCVS)
#${LEGAL}: $${PORTSBASE}/ports/LEGAL
#	cp ${PORTSBASE}/ports/LEGAL LEGAL
#.else
#${LEGAL}: $${CVSROOT}/ports/LEGAL,v
#       co -q -p ${.ALLSRC} > ${.TARGET}
#.endif

.include "../../web.mk"

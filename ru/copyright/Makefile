# $FreeBSD: www/ru/copyright/Makefile,v 1.1 1999/11/01 05:02:54 andy Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS=	license.sgml
DOCS+=	freebsd-license.sgml
DOCS+=	daemon.sgml
DOCS+=	copyright.sgml

INDEXLINK= copyright.html

CVS_READONLY?=	YES
CVS_OPT+=	-Q
.if !empty(CVS_READONLY)
CVS_OPT+=	-R
.endif


#DATA+= COPYING COPYING.LIB ${LEGAL}

## FreeBSD Ports redistribution restrictions
#LEGAL= LEGAL
#LEGAL_FILE= 	ports/LEGAL
#CLEANFILES+= ${LEGAL}
#.if defined(NOPORTSCVS)
#${LEGAL}: $${PORTSBASE}/${LEGAL_FILE}
#	cp ${PORTSBASE}/${LEGAL_FILE} ${LEGAL}
#.else
#${LEGAL}: $${CVSROOT}/${LEGAL_FILE},v
#	cvs ${CVS_OPT} co -p ${LEGAL_FILE} > ${.TARGET}
#.endif

.include "../web.mk"

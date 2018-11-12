# $FreeBSD$
# The FreeBSD Russian Documentation Project
# $FreeBSDru: frdp/www/ru/copyright/Makefile,v 1.4 2003/10/07 13:44:55 den Exp $
# Original revision: 1.14

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	copyright.sgml
DOCS+=	daemon.sgml
DOCS+=	freebsd-doc-license.sgml
DOCS+=	freebsd-license.sgml
DOCS+=	license.sgml
DOCS+=	trademarks.sgml

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
#CLEANFILES+=	${LEGAL}
#.if defined(NOPORTSCVS)
#${LEGAL}: $${PORTSBASE}/${LEGAL_FILE}
#	${CP} ${PORTSBASE}/${LEGAL_FILE} ${LEGAL}
#.else
#${LEGAL}:
#	${CVS} ${CVS_OPT} co -p ${LEGAL_FILE} > ${.TARGET}
#.endif

.include "${DOC_PREFIX}/share/mk/web.site.mk"

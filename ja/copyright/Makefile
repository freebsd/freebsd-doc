# $FreeBSD: www/ja/copyright/Makefile,v 1.14 2000/11/07 11:37:53 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.11

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
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


# DATA+= COPYING COPYING.LIB ${LEGAL}

# FreeBSD Ports redistribution restrictions
#LEGAL= LEGAL
#LEGAL_FILE=	ports/LEGAL
#CLEANFILES+= ${LEGAL}
#.if defined(NOPORTSCVS)
#${LEGAL}: $${PORTSBASE}/${LEGAL_FILE}
#	cp ${PORTSBASE}/${LEGAL_FILE} LEGAL
#.else
#${LEGAL}:
#       cvs ${CVS_OPT} co -p ${LEGAL_FILE} > ${.TARGET}
#.endif

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

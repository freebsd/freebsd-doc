# $Id: Makefile,v 1.15 1998-08-03 14:44:26 wosch Exp $

DOCS?=		index.sgml
SUBDIR=		devel diskformat disklessx fonts mh multios newuser
DOCSUBDIR=	ddwg ppp
SGMLOPTS+=      -links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr


.if defined $(NEW_BUILD)
SUBDIR=
.endif
.if defined(DOCBOOK_ONLY) && !empty(DOCBOOK_ONLY)
DOCSUBDIR=
.endif

WEBBASE?=	/data/tutorials

.include "../web.mk"

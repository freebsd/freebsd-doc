# $Id: Makefile,v 1.13 1998-04-16 08:53:48 wosch Exp $

DOCS?=		index.sgml
SUBDIR=		devel diskformat disklessx fonts mh multios newuser upgrade
DOCSUBDIR=	ddwg ppp
SGMLOPTS+=      -links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr


.if defined $(NEW_BUILD)
SUBDIR=
.endif
.if defined(DOCBOOK_ONLY) && !empty(DOCBOOK_ONLY)
DOCSUBDIR=
.endif

.include "../web.mk"

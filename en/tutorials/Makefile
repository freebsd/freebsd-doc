# $Id: Makefile,v 1.14 1998-07-24 13:31:04 nik Exp $

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

.include "../web.mk"

# $Id: Makefile,v 1.12 1998-01-18 22:27:43 jfieber Exp $

DOCS?=		index.sgml
SUBDIR=		devel diskformat disklessx fonts mh multios newuser upgrade
DOCSUBDIR=	ddwg ppp
SGMLOPTS+=      -links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr


.if defined $(NEW_BUILD)
SUBDIR=
.endif

.include "../web.mk"

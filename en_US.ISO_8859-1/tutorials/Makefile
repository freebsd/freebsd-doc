# $Id: Makefile,v 1.17 1999-04-26 21:45:30 nik Exp $

DOCS?=		index.sgml
SUBDIR=		devel 
SUBDIR+=        diskformat 
SUBDIR+=        disklessx 
SUBDIR+=        docproj-primer
SUBDIR+=        fonts 
SUBDIR+=        mh 
SUBDIR+=        multios 
SUBDIR+=        newuser
DOCSUBDIR=	ddwg ppp
SGMLOPTS+=      -links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr


.if defined $(NEW_BUILD)
SUBDIR=
.endif
.if defined(DOCBOOK_ONLY) && !empty(DOCBOOK_ONLY)
DOCSUBDIR=
.endif

WEBBASE?=	/data/

.include "../web.mk"

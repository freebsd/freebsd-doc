# $Id: Makefile,v 1.18 1999-04-27 18:33:23 nik Exp $

DOCS?=		index.sgml
SUBDIR=		devel 
SUBDIR+=        diskformat 
SUBDIR+=        disklessx 
SUBDIR+=        fonts 
SUBDIR+=        mh 
SUBDIR+=        multios 
SUBDIR+=        newuser
DOCSUBDIR=	docproj-primer
DOCSUBDIR+=	ddwg 
DOCSUBDIR+=	ppp
SGMLOPTS+=      -links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr


.if defined $(NEW_BUILD)
SUBDIR=
.endif
.if defined(DOCBOOK_ONLY) && !empty(DOCBOOK_ONLY)
DOCSUBDIR=
.endif

WEBBASE?=	/data/

.include "../web.mk"

# $FreeBSD: www/es/Makefile,v 1.8 2000/02/28 12:43:08 phantom Exp $

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif


# These are turned into validated, normalized HTML files.

DOCS=  applications.sgml
DOCS+= auditors.sgml
DOCS+= availability.sgml
DOCS+= docs.sgml 
DOCS+= features.sgml
DOCS+= register.sgml
DOCS+= index.sgml
DOCS+= internet.sgml 
DOCS+= mailto.sgml 
DOCS+= publish.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml 
DOCS+= y2kbug.sgml 

CLEANFILES+=atoz.sgml site.sgml

# These will be directly installed.

#DATA=	COPYING COPYING.LIB README.mirror robots.txt index.html
DATA=	robots.txt index.html

# Subdirectories
# SGML
SUBDIR=	 security
#SUBDIR+= commercial
SUBDIR+= docproj
SUBDIR+= news
SUBDIR+= alpha
SUBDIR+= internal
SUBDIR+= copyright
SUBDIR+= search
#SUBDIR+= gallery
SUBDIR+= projects
SUBDIR+= releases 
#SUBDIR+= doc-es
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

# Non-English
#.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
#SUBDIR+= ja
#SUBDIR+= es
#.endif

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
# Extern
#SUBDIR+= tutorials

#DOCSUBDIR=	FAQ handbook
DOCSUBDIR=	FAQ
.endif
SGMLOPTS+=      -links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr

WEBDIR=		data/es

.include "${WEB_PREFIX}/share/mk/web.site.mk"


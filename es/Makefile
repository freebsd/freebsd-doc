# $FreeBSD: www/es/Makefile,v 1.13 2002/11/25 12:27:39 jesusr Exp $

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
SUBDIR+= gnome

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
SUBDIR+= doc
.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

#DOCSUBDIR=	FAQ handbook

SGMLFLAGS+=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr

WEBDIR=		data/es

.include "${WEB_PREFIX}/share/mk/web.site.mk"

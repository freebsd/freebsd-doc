# $Id: Makefile,v 1.5 1999-08-19 20:42:03 nik Exp $

.if exists(Makefile.conf)
.include "Makefile.conf"
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
SUBDIR+= ports
SUBDIR+= projects
SUBDIR+= releases 
#SUBDIR+= doc-es

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

.endif
SGMLOPTS+=      -links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr

WEBDIR=		data/es

.include "web.mk"


# $Id: Makefile,v 1.42 1998-08-04 14:18:21 wosch Exp $

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif


# These are turned into validated, normalized HTML files.

DOCS=  applications.sgml
DOCS+= auditors.sgml
DOCS+= availability.sgml
DOCS+= branch.sgml
DOCS+= docs.sgml 
DOCS+= features.sgml
DOCS+= register.sgml 
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
SUBDIR+= commercial
SUBDIR+= docproj
SUBDIR+= news
SUBDIR+= alpha
SUBDIR+= internal
SUBDIR+= copyright
SUBDIR+= search
SUBDIR+= gallery
SUBDIR+= ports
SUBDIR+= projects
SUBDIR+= releases 

# Non-SGML
SUBDIR+= gifs
SUBDIR+= cgi

# Extern
SUBDIR+= tutorials

# Non-English
SUBDIR+= ja
SUBDIR+= es

DOCSUBDIR=	FAQ handbook
SGMLOPTS+=      -links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr

WEBDIR=		data

.include "web.mk"


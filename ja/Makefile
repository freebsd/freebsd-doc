# $FreeBSD: www/ja/Makefile,v 1.34 1999/09/06 07:03:14 peter Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.49

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
 
# Japanese-only file
DOCS+= jabout.sgml

CLEANFILES+=atoz.sgml site.sgml

# These will be directly installed.

DATA=	index.html

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

# Japanese only.
SUBDIR+= java

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
# Extern
#SUBDIR+= tutorials

DOCSUBDIR=	FAQ handbook
.endif
SGMLOPTS=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr -e EUC-JP

WEBDIR=		data/ja

.include "../web.mk"


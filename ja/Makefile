# $Id: Makefile,v 1.26 1998-08-09 16:22:14 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.42

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
 
# Japanese-only file
DOCS+= jabout.sgml

CLEANFILES+=atoz.sgml site.sgml

# These will be directly installed.

DATA=	index.html

# Subdirectories

# SGML

SUBDIR=  security
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
#SUBDIR+= gifs
#SUBDIR+= cgi

# Extern
#SUBDIR+= tutorials

# Subdirectories that have linuxdoc docs and makefiles that use
# <bsd.sgml.mk>.

DOCSUBDIR=	FAQ handbook
FORMATS?=	"html roff"
SGMLOPTS=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr -e EUC-JP


WEBDIR=		data/ja

.include "../web.mk"


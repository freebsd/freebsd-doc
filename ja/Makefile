# $FreeBSD: www/ja/Makefile,v 1.42 2000/10/02 09:16:04 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.54

LOCALTOP= .

.if exists(${LOCALTOP}/Makefile.conf)
.include "${LOCALTOP}/Makefile.conf"
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
SUBDIR+= java
SUBDIR+= copyright
SUBDIR+= search
SUBDIR+= gallery
SUBDIR+= projects
SUBDIR+= releases
#SUBDIR+= smp
SUBDIR+= conspectus
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= ports
.endif

# Non-SGML
#SUBDIR+= gifs
#SUBDIR+= cgi

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
# Extern
SUBDIR+= tutorials

DOCSUBDIR=	FAQ handbook
.endif
SGMLOPTS=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr -e EUC-JP

WEBDIR=		data/ja

### Revision checking
REVCHECK=	yes

.include "${LOCALTOP}/web.mk"

# The FreeBSD Documentation Project
# The FreeBSD German Documentation Project
# $FreeBSD$
# $FreeBSDde: de-www/Makefile,v 1.6 2001/02/25 11:48:33 alex Exp $

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif


# These are turned into validated, normalized HTML files.

DOCS+= availability.sgml
DOCS+= index.sgml

CLEANFILES+=atoz.sgml site.sgml

# These will be directly installed.

#DATA=	robots.txt index.html

# Subdirectories
# SGML
#.if !defined(WEB_ONLY) || empty(WEB_ONLY)
#SUBDIR+= ports
#.endif

.if !defined(WEB_ONLY) || empty(WEB_ONLY)
# Extern
#SUBDIR+= tutorials

DOCSUBDIR=	FAQ handbook
.endif
SGMLOPTS+=      -links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr

WEBDIR=		data/de

.include "${WEB_PREFIX}/share/mk/web.site.mk"

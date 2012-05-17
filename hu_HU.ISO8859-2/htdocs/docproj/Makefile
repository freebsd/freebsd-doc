# $FreeBSD: www/en/docproj/Makefile,v 1.11 2006/01/27 11:04:03 blackend Exp $

###################################################
# The FreeBSD Hungarian Documentation Project     #
###################################################

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+=	doc-set.sgml
DOCS+=	hungarian.sgml
DOCS+=  sgml.sgml
DOCS+=  submitting.sgml
DOCS+=  who.sgml 
DOCS+=	docproj.sgml

INDEXLINK= docproj.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

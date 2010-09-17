# $FreeBSD: www/en/portmgr/Makefile,v 1.3 2006/05/11 22:58:42 pav Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS?=	index.sgml
DOCS+=	charter.sgml
DOCS+=	implementation.sgml
DOCS+=	policies.sgml
DOCS+=	policies_committing.sgml
DOCS+=	policies_contributors.sgml
DOCS+=	policies_releng_6.sgml
DOCS+=	qa.sgml

.include "${WEB_PREFIX}/share/mk/web.site.mk"

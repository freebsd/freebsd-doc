# $FreeBSD$

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
DOCS+=	policies_eol.sgml
DOCS+=	qa.sgml

.include "${DOC_PREFIX}/share/mk/web.site.mk"

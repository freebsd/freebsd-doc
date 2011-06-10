# $FreeBSD: www/en/ipv6/Makefile,v 1.3 2011/06/07 21:33:10 simon Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+=		index.sgml
DOCS+=		ipv6only.sgml
DOCS+=		w6d.sgml
DOCS+=		w6d-www-stats.sgml

DATA+=		IPv6-badge-blue-256-trans.png	\
		IPv6-badge-blue-128-trans.png
DATA+=		w6d-www-stats-large.png		\
		w6d-www-stats-v6-large.png	\
		w6d-www-stats-v6.png		\
		w6d-www-stats.png

.include "${WEB_PREFIX}/share/mk/web.site.mk"

# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+=		index.xml
DOCS+=		w6d.xml
DOCS+=		w6l.xml
DOCS+=		w6d-www-stats.xml

DATA+=		IPv6-badge-blue-256-trans.png	\
		IPv6-badge-blue-128-trans.png
DATA+=		w6d-www-stats-large.png		\
		w6d-www-stats-v6-large.png	\
		w6d-www-stats-v6.png		\
		w6d-www-stats.png

.include "${DOC_PREFIX}/share/mk/web.site.mk"

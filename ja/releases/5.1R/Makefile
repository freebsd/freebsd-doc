# $FreeBSD: www/ja/releases/5.1R/Makefile,v 1.1 2003/03/22 05:05:00 hrs Exp $
# Original revision: 1.2

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS=	schedule.sgml todo.sgml
DOCS+=	hardware.sgml relnotes.sgml installation.sgml

DATA=	docbook.css
DATA+=	errata.html
DATA+=	early-adopter.html
DATA+=	hardware-alpha.html
DATA+=	hardware-ia64.html
DATA+=	hardware-i386.html
DATA+=	hardware-pc98.html
DATA+=	hardware-sparc64.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-ia64.html
DATA+=	relnotes-i386.html
DATA+=	relnotes-pc98.html
DATA+=	relnotes-sparc64.html
#DATA+=	installation-alpha.html
#DATA+=	installation-ia64.html
#DATA+=	installation-i386.html
#DATA+=	installation-pc98.html
#DATA+=	installation-sparc64.html

### Revision checking
REVCHECK=	YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"

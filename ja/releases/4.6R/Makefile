# $FreeBSD$
# Original revision: 1.4

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

#DOCS=	announce.sgml contents.sgml
DOCS=	announce.sgml
#DOCS+=	hardware.sgml relnotes.sgml qa.sgml schedule.sgml
DOCS+=	hardware.sgml relnotes.sgml

DATA=	docbook.css
#DATA+=	errata.html
#DATA+=	hardware-alpha.html hardware-i386.html
DATA+=	relnotes-alpha.html relnotes-i386.html
DATA+=  cd1.txt cd2.txt cd3.txt cd4.txt mini.txt

### Revision checking
REVCHECK=       YES

.include "${WEB_PREFIX}/share/mk/web.site.mk"

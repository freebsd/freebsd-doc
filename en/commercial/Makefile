# $FreeBSD: www/en/commercial/Makefile,v 1.12 2000/04/04 09:21:21 kuriyama Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

PERL=	perl5

DOCS =  commercial.sgml
DOCS+=  consulting.sgml
DOCS+=  consulting_bycat.sgml
DOCS+=  hardware.sgml
DOCS+=  misc.sgml
DOCS+=  software.sgml
DOCS+=  software_bycat.sgml

INDEXLINK=commercial.html
CLEANFILES+= consulting.inc consulting_bycat.inc hardware.inc
CLEANFILES+= misc.inc software.inc software_bycat.inc

consulting.html: consulting.sgml consulting.inc

consulting_bycat.html: consulting_bycat.sgml consulting_bycat.inc

hardware.html: hardware.sgml hardware.inc

misc.html: misc.sgml misc.inc

software.html: software.sgml software.inc

software_bycat.html: software_bycat.sgml software_bycat.inc

consulting.inc: gencommercial.pl commercial.desc consulting.raw
	${PERL} ${.CURDIR}/gencommercial.pl -s ${.CURDIR} consulting

consulting_bycat.inc: gencommercial.pl commercial.desc consulting.raw
	${PERL} ${.CURDIR}/gencommercial.pl -s ${.CURDIR} -c consulting

hardware.inc: gencommercial.pl commercial.desc hardware.raw
	${PERL} ${.CURDIR}/gencommercial.pl -s ${.CURDIR} hardware

misc.inc: gencommercial.pl commercial.desc misc.raw
	${PERL} ${.CURDIR}/gencommercial.pl -s ${.CURDIR} misc

software.inc: gencommercial.pl commercial.desc software.raw
	${PERL} ${.CURDIR}/gencommercial.pl -s ${.CURDIR} software

software_bycat.inc: gencommercial.pl commercial.desc software.raw
	${PERL} ${.CURDIR}/gencommercial.pl -s ${.CURDIR} -c software

.include <../web.mk>

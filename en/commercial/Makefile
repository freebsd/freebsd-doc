# $FreeBSD$

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

consulting.inc: consulting.raw
	${PERL} ./gencommercial.pl consulting

consulting_bycat.inc: consulting.raw
	${PERL} ./gencommercial.pl -c consulting

hardware.inc: hardware.raw
	${PERL} ./gencommercial.pl hardware
	
misc.inc: misc.raw
	${PERL} ./gencommercial.pl misc

software.inc: software.raw
	${PERL} ./gencommercial.pl software

software_bycat.inc: software.raw
	${PERL} ./gencommercial.pl -c software

.include <../web.mk>

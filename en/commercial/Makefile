# $Id: Makefile,v 1.7 1999-01-22 11:23:44 mbarkah Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

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
	./gencommercial.pl consulting

consulting_bycat.inc: consulting.raw
	./gencommercial.pl -c consulting

hardware.inc: hardware.raw
	./gencommercial.pl hardware
	
misc.inc: misc.raw
	./gencommercial.pl misc

software.inc: software.raw
	./gencommercial.pl software

software_bycat.inc: software.raw
	./gencommercial.pl -c software

.include <../web.mk>

# $Id: Makefile,v 1.4 1998-08-03 09:42:03 wosch Exp $

DOCS=	photos.sgml	
DOCS+=	internal.sgml	
DOCS+=	homepage.sgml
DOCS+= 	about.sgml
DOCS+= 	machines.sgml
DOCS+= 	mirror.sgml
DOCS+= 	machines.sgml
DOCS+=	resignation.sgml

homepage.inc:
	perl homepage.pl > ${.TARGET}

homepage.sgml:  homepage.inc
CLEANFILES+=	homepage.inc

.include "../web.mk"

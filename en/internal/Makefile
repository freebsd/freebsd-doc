# $Id: Makefile,v 1.6 1998-08-03 16:03:32 wosch Exp $

DOCS=	photos.sgml	
DOCS+=	internal.sgml	
DOCS+=	homepage.sgml
DOCS+= 	about.sgml
DOCS+= 	machines.sgml
DOCS+= 	mirror.sgml
DOCS+=	resignation.sgml

homepage.inc:
	perl homepage.pl > ${.TARGET}

homepage.sgml:  homepage.inc
CLEANFILES+=	homepage.inc

DATA+=	README.mirror

.include "../web.mk"

# $Id: Makefile,v 1.7 1998-08-07 16:57:08 wosch Exp $

DOCS=	photos.sgml	
DOCS+=	internal.sgml	
DOCS+=	homepage.sgml
DOCS+= 	about.sgml
DOCS+= 	machines.sgml
DOCS+= 	mirror.sgml
DOCS+=	resignation.sgml

INDEXLINK=	internal.html

homepage.inc:
	perl homepage.pl > ${.TARGET}

homepage.sgml:  homepage.inc
CLEANFILES+=	homepage.inc

DATA+=	README.mirror

.include "../web.mk"

# $Id: Makefile,v 1.3 1998-08-01 09:37:10 wosch Exp $

DOCS=	photos.sgml	
DOCS+=	internal.sgml	

homepage.inc:
	perl homepage.pl > ${.TARGET}

homepage.sgml:  homepage.inc
CLEANFILES+=	homepage.inc

.include "../web.mk"

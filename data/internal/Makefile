# $Id: Makefile,v 1.2 1998-07-31 09:45:51 wosch Exp $

DOCS=	photos.sgml	

homepage.inc:
	perl homepage.pl > ${.TARGET}

homepage.sgml:  homepage.inc
CLEANFILES+=	homepage.inc

.include "../web.mk"

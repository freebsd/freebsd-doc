# $Id: Makefile,v 1.3 1997-11-23 22:55:06 max Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.19

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml applications.sgml auditors.sgml availability.sgml branch.sgml
DOCS+= commercial.sgml daemon.sgml docproj.sgml docs.sgml 
DOCS+= features.sgml gallery.sgml index-site.sgml register.sgml 
DOCS+= internet.sgml license.sgml mailto.sgml mirror.sgml newsflash.sgml
DOCS+= publish.sgml search.sgml searchhints.sgml
DOCS+= send-pr.sgml security.sgml support.sgml where.sgml resignation.sgml
DOCS+= jabout.sgml
#DOCS+= cgallery.sgml npgallery.sgml pgallery.sgml

CLEANFILES+=atoz.sgml

# These will be directly installed.

DATA=	index.html

# Files or targets listed here are defined in this file.

index-site.sgml: atoz.sgml
atoz.sgml: web.atoz 
	sort -fu web.atoz | perl ../atoz.pl > ${.TARGET}

# Subdirectories

#SUBDIR=		cgi commercial gifs ports releases tutorials
SUBDIR=			ports releases

# Subdirectories that have linuxdoc docs and makefiles that use
# <bsd.sgml.mk>.

DOCSUBDIR=	FAQ handbook

# Directories that need to be checked out from the 
# CVS repository.

#CVSDIR=		FAQ handbook

WEBDIR=		data/ja_JP.EUC

.include "../web.mk"


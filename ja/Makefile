# $Id: Makefile,v 1.18 1998-07-27 14:34:27 hanai Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.36

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml applications.sgml auditors.sgml availability.sgml branch.sgml
DOCS+= commercial.sgml daemon.sgml docproj.sgml docs.sgml 
DOCS+= features.sgml gallery.sgml index-site.sgml register.sgml 
DOCS+= internet.sgml license.sgml 
DOCS+= machines.sgml mailto.sgml mirror.sgml
DOCS+= newsflash.sgml publish.sgml search.sgml 
DOCS+= searchhints.sgml send-pr.sgml support.sgml where.sgml 
DOCS+= resignation.sgml y2kbug.sgml search-mid.sgml

# Japanese-only file
DOCS+= jabout.sgml

# Not translated into Japanese yet.
#DOCS+= mozilla.sgml newbies.sgml press.sgml

# Not available in Japanese version.
#DOCS+= cgallery.sgml npgallery.sgml pgallery.sgml

CLEANFILES+=atoz.sgml site.sgml

# These will be directly installed.

DATA=	index.html

# Files or targets listed here are defined in this file.

index-site.sgml: atoz.sgml site.sgml
atoz.sgml: web.atoz 
	sort -fu web.atoz | perl ../atoz.pl > ${.TARGET}
site.sgml: ../site.map
	perl ../site.pl < ${.ALLSRC} > ${.TARGET}


# Subdirectories

#SUBDIR=	security cgi commercial docproj gifs ports releases tutorials 
#SUBDIR+=	news alpha projects
SUBDIR=		security docproj ports releases
SUBDIR+=	news

# Subdirectories that have linuxdoc docs and makefiles that use
# <bsd.sgml.mk>.

DOCSUBDIR=	FAQ handbook
FORMATS?=	"html roff"
SGMLOPTS=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr -e EUC-JP


WEBDIR=		ja_JP.EUC

.include "../web.mk"


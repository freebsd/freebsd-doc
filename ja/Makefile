# $Id: Makefile,v 1.22 1998-08-03 16:40:10 wosch Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.36

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  applications.sgml auditors.sgml availability.sgml branch.sgml
DOCS+= docs.sgml 
DOCS+= features.sgml register.sgml 
DOCS+= internet.sgml 
DOCS+= mailto.sgml 
DOCS+= publish.sgml
DOCS+= send-pr.sgml support.sgml where.sgml 
DOCS+= y2kbug.sgml

# Japanese-only file
DOCS+= jabout.sgml

# Not available in Japanese version.
#DOCS+= cgallery.sgml npgallery.sgml pgallery.sgml

CLEANFILES+=atoz.sgml site.sgml

# These will be directly installed.

DATA=	index.html


# Subdirectories

#SUBDIR=	security cgi commercial docproj gifs ports releases tutorials 
#SUBDIR+=	news alpha projects
SUBDIR=		security docproj ports releases
SUBDIR+=	news alpha copyright internal search projects

# Subdirectories that have linuxdoc docs and makefiles that use
# <bsd.sgml.mk>.

DOCSUBDIR=	FAQ handbook
FORMATS?=	"html roff"
SGMLOPTS=	-links -hdr ${.CURDIR}/doc.hdr -ftr ${.CURDIR}/doc.ftr -e EUC-JP


WEBDIR=		ja_JP.EUC

.include "../web.mk"


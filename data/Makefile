# $Id: Makefile,v 1.19 1997-06-30 06:30:17 jkh Exp $

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif

ACCESS_LOG_DIR?=/home/www/server/logs
ACCESS_LOG_FILE?=access_log
ANALOG?=/home/www/bin/analog

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml applications.sgml auditors.sgml availability.sgml branch.sgml
DOCS+= cgallery.sgml commercial.sgml daemon.sgml docproj.sgml docs.sgml 
DOCS+= features.sgml gallery.sgml index-site.sgml register.sgml 
DOCS+= internet.sgml license.sgml mailto.sgml mirror.sgml newsflash.sgml
DOCS+= npgallery.sgml pgallery.sgml publish.sgml search.sgml searchhints.sgml
DOCS+= send-pr.sgml security.sgml support.sgml where.sgml resignation.sgml

CLEANFILES+=atoz.sgml

# These will be directly installed.

DATA=	COPYING COPYING.LIB README.mirror robots.txt index.html

# Files or targets listed here are defined in this file.

LOCAL=	stats.html stats-img.html

stats.html: ${ACCESS_LOG_DIR}/${ACCESS_LOG_FILE}
	renice +10 $$$$; \
	(cd ${ACCESS_LOG_DIR};zcat ${ACCESS_LOG_FILE}.*.gz; \
	    cat ${ACCESS_LOG_FILE}) | \
	egrep -iv '\.(gif|jpg|jpeg|au) ' | \
	${ANALOG} +i0 +R500 -o > ${.TARGET}

stats-img.html: ${ACCESS_LOG_DIR}/${ACCESS_LOG_FILE}
	renice +10 $$$$; \
	(cd ${ACCESS_LOG_DIR};zcat ${ACCESS_LOG_FILE}.*.gz; \
	    cat ${ACCESS_LOG_FILE}) | \
	${ANALOG} +i0 +R500 -o > ${.TARGET}

index-site.sgml: atoz.sgml
atoz.sgml: web.atoz 
	sort -fu web.atoz | perl atoz.pl > ${.TARGET}

# Subdirectories

SUBDIR=		cgi commercial gifs ports releases tutorials ja_JP.EUC

# Subdirectories that have linuxdoc docs and makefiles that use
# <bsd.sgml.mk>.

DOCSUBDIR=	FAQ handbook

# Directories that need to be checked out from the 
# CVS repository.

CVSDIR=		FAQ handbook

WEBDIR=		data

.include "web.mk"


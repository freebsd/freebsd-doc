# $Id: Makefile,v 1.9 1997-01-23 09:23:50 mbarkah Exp $

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml applications.sgml availability.sgml branch.sgml
DOCS+= cgallery.sgml commercial.sgml daemon.sgml docproj.sgml docs.sgml 
DOCS+= features.sgml gallery.sgml includes.sgml index-site.sgml index.sgml
DOCS+= internet.sgml license.sgml mailto.sgml mirror.sgml newsflash.sgml
DOCS+= npgallery.sgml pgallery.sgml search.sgml searchhints.sgml send-pr.sgml
DOCS+= support.sgml welcome.sgml where.sgml

# These will be directly installed.

DATA=	COPYING COPYING.LIB README.mirror robots.txt

# Files or targets listed here are defined in this file.

LOCAL=	stats.html stats-img.html

stats.html: /home/www/server/logs/access_log
	(cd /usr/local/www/server/logs;zcat access_log.*.gz;cat access_log) | \
	egrep -iv '\.(gif|jpg|jpeg|au) ' | \
	/usr/local/www/bin/analog +i0 +R500 -o > ${.TARGET}

stats-img.html: /home/www/server/logs/access_log
	(cd /usr/local/www/server/logs;zcat access_log.*.gz;cat access_log) | \
	/usr/local/www/bin/analog +i0 +R500 -o > ${.TARGET}

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


# $Id: Makefile,v 1.4 1996-09-28 23:51:36 jfieber Exp $

# These are turned into validated, normalized HTML files.

DOCS=	about.sgml commercial.sgml daemon.sgml docproj.sgml docs.sgml
DOCS+=	gallery.sgml index-site.sgml index.sgml license.sgml
DOCS+=	mailto.sgml newsflash.sgml searchhints.sgml support.sgml
DOCS+=	welcome.sgml where.sgml search.sgml send-pr.sgml
DOCS+=	internet.sgml features.sgml applications.sgml availability.sgml

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

SUBDIR=		cgi gifs ports releases tutorials

# Subdirectories that have linuxdoc docs and makefiles that use
# <bsd.sgml.mk>.

DOCSUBDIR=	FAQ handbook

# Directories that need to be checked out from the 
# CVS repository.

CVSDIR=		FAQ handbook

WEBDIR=		data

.include "web.mk"


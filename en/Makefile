DOCS=	about.sgml commercial.sgml daemon.sgml docproj.sgml docs.sgml
DOCS+=	gallery.sgml index-site.sgml index.sgml license.sgml
DOCS+=	mailto.sgml newsflash.sgml searchhints.sgml support.sgml
DOCS+=	welcome.sgml where.sgml search.sgml

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

SUBDIR=		cgi gifs ports releases tutorials
DOCSUBDIR=	FAQ handbook
WEBDIR=		data

.include "web.mk"

# $Id: Makefile,v 1.1 1998-08-03 09:34:03 wosch Exp $


DOCS+= cgallery.sgml
DOCS+= gallery.sgml
DOCS+= npgallery.sgml 
DOCS+= pgallery.sgml

CLEANFILES+= cgallery.inc npgallery.inc pgallery.inc

cgallery.html: cgallery.sgml cgallery.inc
cgallery.inc: gallery.db gengallery.pl
	./gengallery.pl commercial gallery.db > cgallery.inc

npgallery.html: npgallery.sgml npgallery.inc
npgallery.inc: gallery.db gengallery.pl
	./gengallery.pl nonprofit gallery.db > npgallery.inc

pgallery.html: pgallery.sgml pgallery.inc
pgallery.inc: gallery.db gengallery.pl
	./gengallery.pl personal gallery.db > pgallery.inc

.include "../web.mk"


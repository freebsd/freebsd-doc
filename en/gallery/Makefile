# $Id: Makefile,v 1.2 1998-08-03 15:37:48 wosch Exp $

DOCS = gallery.sgml
DOCS+= cgallery.sgml
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


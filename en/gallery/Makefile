# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS = gallery.sgml
DOCS+= cgallery.sgml
DOCS+= npgallery.sgml 
DOCS+= pgallery.sgml

INDEXLINK= gallery.html

CLEANFILES+= cgallery.inc npgallery.inc pgallery.inc

cgallery.html: cgallery.sgml cgallery.inc
cgallery.inc: gallery.db gengallery.pl
	perl ./gengallery.pl commercial gallery.db > cgallery.inc

npgallery.html: npgallery.sgml npgallery.inc
npgallery.inc: gallery.db gengallery.pl
	perl ./gengallery.pl nonprofit gallery.db > npgallery.inc

pgallery.html: pgallery.sgml pgallery.inc
pgallery.inc: gallery.db gengallery.pl
	perl ./gengallery.pl personal gallery.db > pgallery.inc

.include "../web.mk"


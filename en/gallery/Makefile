# $FreeBSD: www/en/gallery/Makefile,v 1.7 1999/09/06 07:02:43 peter Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS = gallery.sgml
DOCS+= cgallery.sgml
DOCS+= npgallery.sgml 
DOCS+= pgallery.sgml

INDEXLINK= gallery.html

CLEANFILES+= cgallery.inc npgallery.inc pgallery.inc gallery.inc

cgallery.html: cgallery.sgml cgallery.inc
cgallery.inc: gallery.db gengallery.pl
	perl ./gengallery.pl commercial gallery.db > cgallery.inc

npgallery.html: npgallery.sgml npgallery.inc
npgallery.inc: gallery.db gengallery.pl
	perl ./gengallery.pl nonprofit gallery.db > npgallery.inc

pgallery.html: pgallery.sgml pgallery.inc
pgallery.inc: gallery.db gengallery.pl
	perl ./gengallery.pl personal gallery.db > pgallery.inc

gallery.html: gallery.sgml gallery.inc
gallery.inc: gallery.db gallery.sgml
	perl ./prune.pl gallery.db /dev/null | \
	perl -ne 'chomp; m/([-\w]+):\s+(\d+)/ and \
	          print qq/<!ENTITY num./.lc($$1).qq/ CDATA "$$2">\n/' \
	> gallery.inc

.include "../web.mk"


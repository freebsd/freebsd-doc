# $FreeBSD$
# Original version: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS = gallery.sgml
DOCS+= cgallery.sgml
DOCS+= npgallery.sgml 
DOCS+= pgallery.sgml

INDEXLINK= gallery.html

CLEANFILES+= cgallery.inc npgallery.inc pgallery.inc

SCRIPTSRCDIR = ../../en/gallery
GENSCRIPT = $(SCRIPTSRCDIR)/gengallery.pl
DBFILE = $(SCRIPTSRCDIR)/gallery.db

cgallery.html: cgallery.sgml cgallery.inc
cgallery.inc: $(GENSCRIPT) $(DBFILE)
	perl $(GENSCRIPT) commercial $(DBFILE) > cgallery.inc

npgallery.html: npgallery.sgml npgallery.inc
npgallery.inc: $(GENSCRIPT) $(DBFILE)
	perl $(GENSCRIPT) nonprofit $(DBFILE) > npgallery.inc

pgallery.html: pgallery.sgml pgallery.inc
pgallery.inc: $(GENSCRIPT) $(DBFILE)
	perl $(GENSCRIPT) personal $(DBFILE) > pgallery.inc

.include "../web.mk"


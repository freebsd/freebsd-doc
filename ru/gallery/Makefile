# $FreeBSD$
# The FreeBSD Russian Documentation Project
# $FreeBSDru: frdp/www/ru/gallery/Makefile,v 1.2 2000/10/12 10:02:51 phantom Exp $
# Original revision: 1.10

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS = gallery.sgml
DOCS+= cgallery.sgml
DOCS+= npgallery.sgml 
DOCS+= pgallery.sgml

INDEXLINK= gallery.html

CLEANFILES+= cgallery.inc npgallery.inc pgallery.inc gallery.inc

SCRIPTSRCDIR = ${.CURDIR}/../../en/gallery
GENSCRIPT = $(SCRIPTSRCDIR)/gengallery.pl
DBFILE = $(SCRIPTSRCDIR)/gallery.db

cgallery.html: cgallery.sgml cgallery.inc
cgallery.inc: $(GENSCRIPT) $(DBFILE)
	${PERL} $(GENSCRIPT) commercial $(DBFILE) > cgallery.inc

npgallery.html: npgallery.sgml npgallery.inc
npgallery.inc: $(GENSCRIPT) $(DBFILE)
	${PERL} $(GENSCRIPT) nonprofit $(DBFILE) > npgallery.inc

pgallery.html: pgallery.sgml pgallery.inc
pgallery.inc: $(GENSCRIPT) $(DBFILE)
	${PERL} $(GENSCRIPT) personal $(DBFILE) > pgallery.inc

gallery.html: gallery.sgml gallery.inc
gallery.inc: $(DBFILE) gallery.sgml
	${PERL} $(SCRIPTSRCDIR)/prune.pl $(DBFILE) /dev/null | \
	${PERL} -ne 'chomp; m/([-\w]+):\s+(\d+)/ and \
	          print qq/<!ENTITY num./.lc($$1).qq/ CDATA "$$2">\n/' \
	> gallery.inc

.include "../web.mk"


# $FreeBSD: www/en/gallery/Makefile,v 1.9 2000/04/20 16:40:58 phantom Exp $

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
	${PERL} ${.CURDIR}/gengallery.pl commercial ${.CURDIR}/gallery.db > cgallery.inc

npgallery.html: npgallery.sgml npgallery.inc
npgallery.inc: gallery.db gengallery.pl
	${PERL} ${.CURDIR}/gengallery.pl nonprofit ${.CURDIR}/gallery.db > npgallery.inc

pgallery.html: pgallery.sgml pgallery.inc
pgallery.inc: gallery.db gengallery.pl
	${PERL} ${.CURDIR}/gengallery.pl personal ${.CURDIR}/gallery.db > pgallery.inc

gallery.html: gallery.sgml gallery.inc
gallery.inc: gallery.db gallery.sgml
	${PERL} ${.CURDIR}/prune.pl ${.CURDIR}/gallery.db /dev/null | \
	${PERL} -ne 'chomp; m/([-\w]+):\s+(\d+)/ and \
	          print qq/<!ENTITY num./.lc($$1).qq/ CDATA "$$2">\n/' \
	> gallery.inc

.include "../web.mk"


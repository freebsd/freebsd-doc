# $FreeBSD: www/ja/gallery/Makefile,v 1.10 2000/04/27 02:07:19 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.10

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

DOCS = gallery.sgml

INDEXLINK= gallery.html

CLEANFILES+= gallery.inc

gallery.html: gallery.sgml gallery.inc
gallery.inc: ../../en/gallery/gallery.db gallery.sgml
	${PERL} ${.CURDIR}/../../en/gallery/prune.pl ${.CURDIR}/../../en/gallery/gallery.db /dev/null | \
	${PERL} -ne 'chomp; m/([-\w]+):\s+(\d+)/ and print qq/<!ENTITY num./.lc($$1).qq/ CDATA "$$2">\n/'\
	> gallery.inc

### Revision checking
REVFILES=	${DOCS:M*.sgml:S/.sgml$/.revinc/g}
BUILDTOP=	../..
DIR_IN_LOCAL=	gallery

.include "../../web.mk"

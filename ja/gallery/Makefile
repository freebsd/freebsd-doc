# $FreeBSD: www/ja/gallery/Makefile,v 1.11 2000/10/02 07:54:40 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.10

LOCALTOP= ..

.if exists(${LOCALTOP}/Makefile.conf)
.include "${LOCALTOP}/Makefile.conf"
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
REVCHECK=	yes

.include "${LOCALTOP}/web.mk"

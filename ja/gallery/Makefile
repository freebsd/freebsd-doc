# $FreeBSD: www/ja/gallery/Makefile,v 1.12 2000/10/02 09:16:06 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.11

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
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

.include "${WEB_PREFIX}/share/mk/web.site.mk"

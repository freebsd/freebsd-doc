# $FreeBSD: www/en/gallery/Makefile,v 1.11 2000/11/07 04:05:14 kuriyama Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

INDEXLINK= gallery.html

DATA+=	gallery.html cgallery.html npgallery.html pgallery.html

CLEANFILES+= cgallery.html npgallery.html pgallery.html gallery.html

gallery.html: gallery.xml gallery.xsl
	xsltproc gallery.xsl gallery.xml > gallery.html
	-tidy -i -m -f /dev/null gallery.html

cgallery.html: gallery.xml gallery-entry.xsl
	xsltproc --param type \'commercial\' gallery-entry.xsl gallery.xml > cgallery.html
	-tidy -i -m -f /dev/null cgallery.html

npgallery.html: gallery.xml gallery-entry.xsl
	xsltproc --param type \'nonprofit\' gallery-entry.xsl gallery.xml > npgallery.html
	-tidy -i -m -f /dev/null npgallery.html

pgallery.html: gallery.xml gallery-entry.xsl
	xsltproc --param type \'personal\' gallery-entry.xsl gallery.xml > pgallery.html
	-tidy -i -m -f /dev/null pgallery.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

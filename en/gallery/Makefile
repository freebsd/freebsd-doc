# $FreeBSD: www/en/gallery/Makefile,v 1.12 2001/08/07 15:55:35 nik Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XSLT=	env SGML_CATALOG_FILES=/usr/local/share/xml/dtd/xhtml/xhtml.soc \
	xsltproc --catalogs

INDEXLINK= gallery.html

DATA+=	gallery.html cgallery.html npgallery.html pgallery.html

CLEANFILES+= cgallery.html npgallery.html pgallery.html gallery.html

gallery.html: gallery.xml gallery.xsl ../includes.xsl
	${XSLT} gallery.xsl gallery.xml > gallery.html
	-tidy -i -m -f /dev/null gallery.html

cgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'commercial\' gallery-entry.xsl gallery.xml > cgallery.html
	-tidy -i -m -f /dev/null cgallery.html

npgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'nonprofit\' gallery-entry.xsl gallery.xml > npgallery.html
	-tidy -i -m -f /dev/null npgallery.html

pgallery.html: gallery.xml gallery-entry.xsl
	${XSLT} --param type \'personal\' gallery-entry.xsl gallery.xml > pgallery.html
	-tidy -i -m -f /dev/null pgallery.html

.include "${WEB_PREFIX}/share/mk/web.site.mk"

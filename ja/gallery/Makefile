# $FreeBSD: www/ja/gallery/Makefile,v 1.14 2001/09/05 08:35:15 kuriyama Exp $
# The FreeBSD Japanese Documentation Project
# Original revision: 1.13

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

XSLT=	env SGML_CATALOG_FILES=/usr/local/share/xml/dtd/xhtml/xhtml.soc \
	xsltproc --catalogs
SRC=	../../en/gallery/gallery.xml

INDEXLINK= gallery.html

DATA+=	gallery.html cgallery.html npgallery.html pgallery.html

CLEANFILES+= cgallery.html npgallery.html pgallery.html gallery.html

gallery.html: ${SRC} gallery.xsl ../includes.xsl
	${XSLT} gallery.xsl ${SRC} > gallery.html
#	-tidy -i -m -f /dev/null gallery.html

cgallery.html: ${SRC} gallery-entry.xsl
	${XSLT} --param type \'commercial\' gallery-entry.xsl ${SRC} > cgallery.html
#	-tidy -i -m -f /dev/null cgallery.html

npgallery.html: ${SRC} gallery-entry.xsl
	${XSLT} --param type \'nonprofit\' gallery-entry.xsl ${SRC} > npgallery.html
#	-tidy -i -m -f /dev/null npgallery.html

pgallery.html: ${SRC} gallery-entry.xsl
	${XSLT} --param type \'personal\' gallery-entry.xsl ${SRC} > pgallery.html
#	-tidy -i -m -f /dev/null pgallery.html

### Revision checking
REVCHECK=	yes

.include "${WEB_PREFIX}/share/mk/web.site.mk"

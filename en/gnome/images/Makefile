# $FreeBSD: www/en/gnome/images/Makefile,v 1.19 2004/03/03 06:06:25 marcus Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# For screenshots, please create 320x240 thumbnails of the images, and name
# them <imagename>-tn.png.  This will minimize the load time for the index
# page.  If your source shot isn't of normal geometry, restrict the height
# to 240 pixels and let the width vary.  You can use the convert tool
# included with ImageMagick to do this:
#
# convert -geometry x240 <imagename>.png <imagename>-tn.png

DATA=	ss11.png
DATA+=	ss11-tn.png
DATA+=	ss12.png
DATA+=	ss12-tn.png
DATA+=	ss13.png
DATA+=	ss13-tn.png
DATA+=	ss14.png
DATA+=	ss14-tn.png
DATA+=	ss15.png
DATA+=	ss15-tn.png
DATA+=	ss16.png
DATA+=	ss16-tn.png
DATA+=	ss17.png
DATA+=	ss17-tn.png
DATA+=	gnome.png

.include "${WEB_PREFIX}/share/mk/web.site.mk"

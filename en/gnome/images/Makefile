# $FreeBSD: www/en/gnome/images/Makefile,v 1.16 2003/12/28 00:15:24 adamw Exp $

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# For screenshots, please create 320x240 thumbnails of the images, and name
# them <imagename>-tn.png.  This will minimize the load time for the index
# page.  You can use the convert tool included with ImageMagick to do this:
#
# convert -geometry 320x240\! <imagename>.png <imagename>-tn.png

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
DATA+=	gnome.png

.include "${WEB_PREFIX}/share/mk/web.site.mk"

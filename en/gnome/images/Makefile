# $FreeBSD: www/en/gnome/images/Makefile,v 1.30 2005/01/06 05:38:48 adamw Exp $

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
#
# Screenshots should be named according to the GNOME release they show.
# E.g. the fourth screenshot for GNOME 2.6 is ss26-4.png, and the thumbnail
# is ss26-4-tn.png

DATA+=	ss28-1.png
DATA+=	ss28-1-tn.png
DATA+=	ss28-2.png
DATA+=	ss28-2-tn.png
DATA+=	ss28-3.png
DATA+=	ss28-3-tn.png
DATA+=	ss28-4.png
DATA+=	ss28-4-tn.png
DATA+=	ss28-5.png
DATA+=	ss28-5-tn.png
DATA+=	ss28-6.png
DATA+=	ss28-6-tn.png
DATA+=	gnome.png

# FreeBSD GNOME Vanity Project

DATA+=	adamw.jpg
DATA+=	ahze.jpg
#DATA+=	bland.jpg
DATA+=	hippobutt.jpg
DATA+=	kwm.jpg
DATA+=	marcus.jpg
DATA+=	pav.jpg

.include "${WEB_PREFIX}/share/mk/web.site.mk"

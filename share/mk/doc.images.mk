#
# $FreeBSD: doc/share/mk/doc.images.mk,v 1.2 2000/07/18 16:30:45 nik Exp $
#
# This include file <doc.images.mk> handles image processing.
#
# There are two types of images that must be handled:
#
#  1.  Images from the library directory, that are shared across multiple
#      documents.
#
#  2.  Images that are document specific.
#
# For library images this file ensures that they are copied in to the 
# documents directory so that they can be reference properly.
#
# For library images *and* document specific images, this file ensures
# that the images are converted from their repository format to the
# correct output format.
#
# Note that this latter functionality is not yet implemented.
#

#
# Using library images
# --------------------
#
# Each document that wants to use one or more library images  has to
# list them in the LIB_IMAGES variable.  For example, a document that wants 
# to use callouts 1 thru 4 has to list
#
#  LIB_IMAGES= callouts/1.png callouts/2.png callouts/3.png callouts/4.png
#
# in the controlling Makefile.
#
# This code ensures they exist in the current directory, and copies them in
# as necessary.
#

#
# The name of the directory that contains all the library images for this
# language and encoding
#
LIB_IMAGES_DIR?=	${.CURDIR}/../../share/images

#
# The name of the directory *in* the document directory where files and
# directory hierarchies should be copied to.  "images" is too generic, and
# might clash with local document images, so use "imagelib" by default 
# instead.  If you redefine this then you must also update the
# %callout-graphics-path% variable in the .dsl file.
#
LOCAL_LIB_IMAGES_DIR?= imagelib

CP?=		/bin/cp
MKDIR?=		/bin/mkdir

#
# Create a target for each image used from the library.  This target just
# ensures that each image required is copied from its location in 
# ${LIB_IMAGES_DIR} to the same place in ${LOCAL_LIB_IMAGES_DIR}.
#
.for _curimage in ${LIB_IMAGES}
${LOCAL_LIB_IMAGES_DIR}/${_curimage}: ${LIB_IMAGES_DIR}/${_curimage}
	@[ -d ${LOCAL_LIB_IMAGES_DIR}/${_curimage:H} ] || ${MKDIR} -p ${LOCAL_LIB_IMAGES_DIR}/${_curimage:H}
	${INSTALL} -C -c ${LIB_IMAGES_DIR}/${_curimage} ${LOCAL_LIB_IMAGES_DIR}/${_curimage}
.endfor

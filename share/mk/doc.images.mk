#
# $FreeBSD: doc/share/mk/doc.images.mk,v 1.9 2001/06/22 10:12:23 nik Exp $
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

#
# Using document specific images
# ------------------------------
#
# The images that each document provides *from the repository* are listed in
# the IMAGES variable.
#
# We then need to build a list of images that must be generated from these.
# This is to handle the case where a document might include some images as
# bitmaps and some as vector images in the repository, but where, depending
# on the output format, you want all the images in one format or another.
#
# This list of generated images can then be cleaned in the clean target
# later
#
# This is the same for each format.  To use IMAGES_GEN_PNG as an example,
# the substitution means "First match, using M, all the components of
# ${IMAGES} that match the '*.eps' regexp.  Then, search/replace the .eps
# in the matching filenames with .png.  Finally, stick the results in the
# ${IMAGES_GEN_PNG} variable."  ${IMAGES_GEN_PNG} then contains the names
# of all the .eps images listed, but with a .png extension.  This is the
# list of files we need to generate if we need PNG format images.
#
# The PDF generation, when it's looking for file 'foo', will first try
# foo.pdf, and it will try foo.png.  There's no point converting PNG files
# to PDF, as they'll be used directly.  However, we can convert the EPS files
# to PDF, and hopefully get better quality.
#

IMAGES_GEN_PNG=${IMAGES:M*.eps:S/.eps$/.png/}
IMAGES_GEN_EPS=${IMAGES:M*.png:S/.png$/.eps/}
IMAGES_GEN_PDF=${IMAGES:M*.eps:S/.eps$/.pdf/}

CLEANFILES+= ${IMAGES_GEN_PNG} ${IMAGES_GEN_EPS} ${IMAGES_GEN_PDF}

IMAGES_PNG=${IMAGES:M*.png} ${IMAGES_GEN_PNG} ${IMAGES:M*.scr:S/.scr$/.png/}
IMAGES_EPS=${IMAGES:M*.eps} ${IMAGES_GEN_EPS}

# The default resolution eps2png (82) assumes a 640x480 monitor, and is too
# low for the typical monitor in use today. The resolution of 100 looks
# much better on these monitors without making the image too large for
# a 640x480 monitor.
EPS2PNG_RES?= 100

# We only need to list ${IMAGES_GEN_PDF} here.  If all the source files are
# EPS then they'll be in this variable; if any of the source files are PNG
# then we can use them directly, and don't need to list them.
IMAGES_PDF=${IMAGES_GEN_PDF}

# Use suffix rules to convert .scr files to .png files
.SUFFIXES:	.scr .png

.scr.png:
	scr2png < ${.IMPSRC} > ${.TARGET}

# We can't use suffix rules to generate the rules to convert EPS to PNG and
# PNG to EPS.  This is because a .png file can depend on a .eps file, and
# vice versa, leading to a loop in the dependency graph.  Instead, build
# the targets on the fly.

.for _curimage in ${IMAGES_GEN_PNG}
${_curimage}: ${_curimage:S/.png$/.eps/}
	peps -r ${EPS2PNG_RES} -p -o ${.TARGET} ${.ALLSRC}
.endfor

.for _curimage in ${IMAGES_GEN_EPS}
${_curimage}: ${_curimage:S/.eps$/.png/}
	pngtopnm ${.ALLSRC} | pnmtops -noturn > ${.TARGET}
.endfor

.for _curimage in ${IMAGES_GEN_PDF}
${_curimage}: ${_curimage:S/.pdf$/.eps/}
	epstopdf --outfile=${.TARGET} ${_curimage:S/.pdf$/.eps/}
.endfor

#
# Using library images
# --------------------
#
# Each document that wants to use one or more library images has to
# list them in the IMAGES_LIB variable.  For example, a document that wants 
# to use callouts 1 thru 4 has to list
#
#  IMAGES_LIB= callouts/1.png callouts/2.png callouts/3.png callouts/4.png
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
IMAGES_LIB_DIR?=	${.CURDIR}/../../share/images

#
# The name of the directory *in* the document directory where files and
# directory hierarchies should be copied to.  "images" is too generic, and
# might clash with local document images, so use "imagelib" by default 
# instead.  If you redefine this then you must also update the
# %callout-graphics-path% variable in the .dsl file.
#
LOCAL_IMAGES_LIB_DIR?= imagelib

CP?=		/bin/cp
MKDIR?=		/bin/mkdir

#
# Create a target for each image used from the library.  This target just
# ensures that each image required is copied from its location in 
# ${IMAGES_LIB_DIR} to the same place in ${LOCAL_IMAGES_LIB_DIR}.
#
.for _curimage in ${IMAGES_LIB}
${LOCAL_IMAGES_LIB_DIR}/${_curimage}: ${IMAGES_LIB_DIR}/${_curimage}
	@[ -d ${LOCAL_IMAGES_LIB_DIR}/${_curimage:H} ] || ${MKDIR} -p ${LOCAL_IMAGES_LIB_DIR}/${_curimage:H}
	${INSTALL} -C -c ${IMAGES_LIB_DIR}/${_curimage} ${LOCAL_IMAGES_LIB_DIR}/${_curimage}
.endfor

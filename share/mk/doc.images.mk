#
# $FreeBSD$
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

IMAGES_EN?=
LOCAL_IMAGES_EN?=

#
# The name of the directory that contains all the library images for this
# language and encoding
#
IMAGES_EN_DIR?=	${.CURDIR}/../../../share/images

.for _curimage in ${IMAGES_EN}
LOCAL_IMAGES_EN += ${IMAGES_EN_DIR}/${DOC}s/${.CURDIR:T}/${_curimage}
.endfor

_IMAGES_PNG= ${IMAGES:M*.png}
_IMAGES_PNG+= ${LOCAL_IMAGES_EN:M*.png}
_IMAGES_EPS= ${IMAGES:M*.eps}
_IMAGES_EPS+= ${LOCAL_IMAGES_EN:M*.eps}
_IMAGES_SCR= ${IMAGES:M*.scr}
_IMAGES_SCR+= ${LOCAL_IMAGES_EN:M*.scr}
_IMAGES_TXT= ${IMAGES:M*.txt}
_IMAGES_TXT+= ${LOCAL_IMAGES_EN:M*.txt}
_IMAGES_PIC= ${IMAGES:M*.pic}
_IMAGES_PIC+= ${LOCAL_IMAGES_EN:M*.pic}

IMAGES_GEN_PNG= ${_IMAGES_EPS:S/.eps$/.png/} ${_IMAGES_SCR:S/.scr$/.png/} ${_IMAGES_PIC:S/.pic$/.png/}
IMAGES_GEN_EPS= ${_IMAGES_PNG:S/.png$/.eps/} ${_IMAGES_SCR:S/.scr$/.eps/} ${_IMAGES_PIC:S/.pic$/.eps/}

CLEANFILES+= ${IMAGES_GEN_PNG} ${IMAGES_GEN_EPS} ${_IMAGES_PIC:S/.pic$/.ps/}

IMAGES_PNG= ${_IMAGES_PNG} ${IMAGES_GEN_PNG}
IMAGES_EPS= ${_IMAGES_EPS} ${IMAGES_GEN_EPS}

LOCAL_IMAGES= ${IMAGES}
LOCAL_IMAGES_PNG= ${_IMAGES_PNG}
LOCAL_IMAGES_EPS= ${_IMAGES_EPS}
LOCAL_IMAGES_TXT= ${_IMAGES_TXT}
LOCAL_IMAGES_PNG+= ${IMAGES_GEN_PNG}
LOCAL_IMAGES_EPS+= ${IMAGES_GEN_EPS}

# The default resolution eps2png (82) assumes a 640x480 monitor, and is too
# low for the typical monitor in use today. The resolution of 100 looks
# much better on these monitors without making the image too large for
# a 640x480 monitor.
EPS2PNM_RES?=	100

#
# Use suffix rules to convert .scr files to other formats
.SUFFIXES:	.scr .pic .png .ps .eps .txt

#
# There are many rules around here that use > ${.TARGET}
# so that on failure, may leave corrupt files behind.
# Make sure to remove them.
#
.DELETE_ON_ERROR:

.scr.png:
	${SCR2PNG} ${SCR2PNGOPTS} < ${.IMPSRC} > ${.TARGET}

## If we want grayscale, convert with ppmtopgm before running through pnmtops
.if defined(GREYSCALE_IMAGES)
.scr.eps:
	tmpfile=$$(mktemp ${.TARGET}.XXXXXXXX); \
	${SCR2PNG} ${SCR2PNGOPTS} < ${.ALLSRC} | \
		${PNGTOPNM} ${PNGTOPNMOPTS} | \
		${PPMTOPGM} ${PPMTOPGMOPTS} | \
		${PNMTOPS} ${PNMTOPSOPTS} > $$tmpfile && \
		${MV} -f $$tmpfile ${.TARGET}
.else
.scr.eps:
	tmpfile=$$(mktemp ${.TARGET}.XXXXXXXX); \
	${SCR2PNG} ${SCR2PNGOPTS} < ${.ALLSRC} | \
		${PNGTOPNM} ${PNGTOPNMOPTS} | \
		${PNMTOPS} ${PNMTOPSOPTS} > $$tmpfile && \
		${MV} -f $$tmpfile ${.TARGET}
.endif

# The .txt files need to have any trailing spaces trimmed from
# each line, which is why the output from ${SCR2TXT} is run
# through ${SED}
.scr.txt:
	${SCR2TXT} ${SCR2TXTOPTS} < ${.IMPSRC} | ${SED} -E -e 's/ +$$//' > ${.TARGET}

.pic.png: ${.TARGET:S/.png$/.eps/}
	${EPSGEOM} -offset ${EPSGEOMOPTS} ${.TARGET:S/.png$/.eps/} \
		| ${EPS2PNM} ${EPS2PNMOPTS} \
		-g`${EPSGEOM} -geom ${EPSGEOMOPTS} ${.TARGET:S/.png$/.eps/}` - \
		| ${PNMTOPNG} > ${.TARGET}

.pic.ps:
	tmpfile=$$(mktemp ${.TARGET}.XXXXXXXX); \
	${PIC2PS} ${.ALLSRC} > $$tmpfile && ${MV} -f $$tmpfile ${.TARGET}

# When ghostscript built with A4=yes is used, ps2epsi's paper size also
# becomes the A4 size.  However, the ps2epsi fails to convert grops(1)
# outputs, which is the letter size, and we cannot change ps2epsi's paper size
# from the command line.  So ps->eps suffix rule is defined.  In the rule,
# gs(1) is used to generate the bitmap preview and the size of the
# bounding box.
#
# ps2epsi.ps in GS 8.70 requires $outfile before the conversion and it
# must contain %%BoundingBox line which the "gs -sDEVICE=bbox" outputs
# (the older versions calculated BBox directly in ps2epsi.ps).
.ps.eps:
	tmpfile=$$(mktemp ${.TARGET}.XXXXXXXX); \
	${PS2BBOX} ${PS2BBOXOPTS} ${.ALLSRC} 2> $$tmpfile >$$tmpfile.err && \
	${SETENV} outfile=$$tmpfile ${PS2EPS} ${PS2EPSOPTS} < ${.ALLSRC} >>$$tmpfile.err 2>&1 && \
	(echo "save countdictstack mark newpath /showpage {} def /setpagedevice {pop} def";\
		echo "%%EndProlog";\
		echo "%%Page: 1 1";\
		echo "%%BeginDocument: ${.ALLSRC}";\
	) >> $$tmpfile; \
	${SED}	-e '/^%%BeginPreview:/,/^%%EndPreview[^!-~]*$$/d' \
		-e '/^%!PS-Adobe/d' \
		-e '/^%%[A-Za-z][A-Za-z]*[^!-~]*$$/d'\
		-e '/^%%[A-Za-z][A-Za-z]*: /d' < ${.ALLSRC} >> $$tmpfile; \
	(echo "%%EndDocument";\
		echo "%%Trailer";\
		echo "cleartomark countdictstack exch sub { end } repeat restore";\
		echo "%%EOF";\
	) >> $$tmpfile; \
	test ! -s $$tmpfile.err && \
	{ ${MV} -f $$tmpfile ${.TARGET} ; ${RM} -f $$tmpfile.err ; } \
	|| { ${CAT} $$tmpfile.err ; ${RM} -f $$tmpfile.err $$tmpfile ; false ; }

# We can't use suffix rules to generate the rules to convert EPS to PNG and
# PNG to EPS.  This is because a .png file can depend on a .eps file, and
# vice versa, leading to a loop in the dependency graph.  Instead, build
# the targets on the fly.

.for _curimage in ${_IMAGES_EPS:S/.eps$/.png/}
${_curimage}: ${_curimage:S/.png/.eps/}
	${EPSGEOM} -offset ${EPSGEOMOPTS} ${.ALLSRC} \
		| ${EPS2PNM} ${EPS2PNMOPTS} \
		-g`${EPSGEOM} -geom ${EPSGEOMOPTS} ${.ALLSRC}` - \
		| ${PNMTOPNG} > ${.TARGET}
.endfor

.for _curimage in ${_IMAGES_PNG:S/.png$/.eps/}
${_curimage}: ${_curimage:S/.eps$/.png/}
	${PNGTOPNM} ${PNGTOPNMOPTS} ${.ALLSRC} | \
		${PNMTOPS} ${PNMTOPSOPTS} > ${.TARGET}
.endfor

.if ${.OBJDIR} != ${.CURDIR}
.for _curimage in ${IMAGES}
${.OBJDIR}/${_curimage}: ${_curimage}
	@${CP} -p ${.ALLSRC} ${.TARGET}
.endfor
.endif

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

IMAGES_LIB?=
LOCAL_IMAGES_LIB ?=

#
# The name of the directory that contains all the library images for this
# language and encoding
#
IMAGES_LIB_DIR?=	${.CURDIR}/../../../share/images

#
# The name of the directory *in* the document directory where files and
# directory hierarchies should be copied to.  "images" is too generic, and
# might clash with local document images, so use "imagelib" by default
# instead.
#
LOCAL_IMAGES_LIB_DIR?= imagelib
CLEANDIRS+=	${LOCAL_IMAGES_LIB_DIR}

#
# Create a target for each image used from the library.  This target just
# ensures that each image required is copied from its location in
# ${IMAGES_LIB_DIR} to the same place in ${LOCAL_IMAGES_LIB_DIR}.
#

.for _curimage in ${IMAGES_LIB}
LOCAL_IMAGES_LIB += ${LOCAL_IMAGES_LIB_DIR}/${_curimage}
${LOCAL_IMAGES_LIB_DIR}/${_curimage}: ${IMAGES_LIB_DIR}/${_curimage}
	@[ -d ${LOCAL_IMAGES_LIB_DIR}/${_curimage:H} ] || \
		${MKDIR} -p ${LOCAL_IMAGES_LIB_DIR}/${_curimage:H}
	${CP} -p ${IMAGES_LIB_DIR}/${_curimage} \
		 ${LOCAL_IMAGES_LIB_DIR}/${_curimage}
.endfor

.if !empty(IMAGES_LIB)
CLEANFILES+= ${IMAGES_LIB:S|^|${LOCAL_IMAGES_LIB_DIR}/|}
.endif

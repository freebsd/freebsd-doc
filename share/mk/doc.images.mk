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

IMAGES_GEN_PNG= ${_IMAGES_EPS:S/.eps$/.png/}
IMAGES_GEN_EPS= ${_IMAGES_PNG:S/.png$/.eps/}
IMAGES_GEN_PDF= ${_IMAGES_EPS:S/.eps$/.pdf/}
IMAGES_SCR_PNG= ${_IMAGES_SCR:S/.scr$/.png/}
IMAGES_SCR_EPS= ${_IMAGES_SCR:S/.scr$/.eps/}
IMAGES_SCR_PDF= ${_IMAGES_SCR:S/.scr$/.pdf/}
IMAGES_SCR_TXT= ${_IMAGES_SCR:S/.scr$/.txt/}
IMAGES_PIC_PNG= ${_IMAGES_PIC:S/.pic$/.png/}
IMAGES_PIC_EPS= ${_IMAGES_PIC:S/.pic$/.eps/}
IMAGES_PIC_PDF= ${_IMAGES_PIC:S/.pic$/.pdf/}
IMAGES_GEN_PDF+= ${IMAGES_PIC_PDF} ${IMAGES_SCR_PDF}

CLEANFILES+= ${IMAGES_GEN_PNG} ${IMAGES_GEN_EPS} ${IMAGES_GEN_PDF}
CLEANFILES+= ${IMAGES_SCR_PNG} ${IMAGES_SCR_EPS} ${IMAGES_SCR_TXT}
CLEANFILES+= ${IMAGES_PIC_PNG} ${IMAGES_PIC_EPS} ${_IMAGES_PIC:S/.pic$/.ps/}

IMAGES_PNG= ${_IMAGES_PNG} ${IMAGES_GEN_PNG} ${IMAGES_SCR_PNG} ${IMAGES_PIC_PNG}
IMAGES_EPS= ${_IMAGES_EPS} ${IMAGES_GEN_EPS} ${IMAGES_SCR_EPS} ${IMAGES_PIC_EPS}
IMAGES_TXT= ${_IMAGES_TXT} ${IMAGES_SCR_TXT}

LOCAL_IMAGES= ${IMAGES}
LOCAL_IMAGES_PNG= ${_IMAGES_PNG}
LOCAL_IMAGES_EPS= ${_IMAGES_EPS}
LOCAL_IMAGES_TXT= ${_IMAGES_TXT}
LOCAL_IMAGES_PNG+= ${IMAGES_GEN_PNG} ${IMAGES_SCR_PNG} ${IMAGES_PIC_PNG}
LOCAL_IMAGES_EPS+= ${IMAGES_GEN_EPS} ${IMAGES_SCR_EPS} ${IMAGES_PIC_EPS}
LOCAL_IMAGES_TXT+= ${IMAGES_SCR_TXT}

# The default resolution eps2png (82) assumes a 640x480 monitor, and is too
# low for the typical monitor in use today. The resolution of 100 looks
# much better on these monitors without making the image too large for
# a 640x480 monitor.
EPS2PNM_RES?=	100

# We need to list ${_IMAGES_PNG} here since the images might be in a
# shared image directory.
IMAGES_PDF= ${IMAGES_GEN_PDF} ${_IMAGES_PNG}

SCR2PNG?=	${PREFIX}/bin/scr2png
SCR2PNGOPTS?=	${SCR2PNGFLAGS}
SCR2TXT?=	${PREFIX}/bin/scr2txt
SCR2TXTOPTS?=	-l ${SCR2TXTFLAGS}
SED?=		/usr/bin/sed
EPS2PNM?=	${PREFIX}/bin/gs
EPS2PNMOPTS?=	-q -dBATCH -dGraphicsAlphaBits=4 -dTextAlphaBits=4 \
		-dEPSCrop -r${EPS2PNM_RES}x${EPS2PNM_RES} \
		-dNOPAUSE -dSAFER -sDEVICE=pnm -sOutputFile=-
#
# epsgeom is a perl script for 1) extracting geometry information
# from a .eps file and 2) arrange it for ghostscript's pnm driver.
#
EPSGEOM?=	${PERL} ${DOC_PREFIX}/share/misc/epsgeom
EPSGEOMOPTS?=	${EPS2PNM_RES} ${EPS2PNM_RES}
PNMTOPNG?=	${PREFIX}/bin/pnmtopng
PNMTOPNGOPTS?=	${PNGTOPNGFLAGS}
PNGTOPNM?=	${PREFIX}/bin/pngtopnm
PNGTOPNMOPTS?=	${PNGTOPNMFLAGS}
PPMTOPGM?=	${PREFIX}/bin/ppmtopgm
PPMTOPGMOPTS?=	${PPMTOPGMFLAGS}
PNMTOPS?=	${PREFIX}/bin/pnmtops
PNMTOPSOPTS?=	-noturn ${PNMTOPSFLAGS}
EPSTOPDF?=	${PREFIX}/bin/epstopdf
EPSTOPDFOPTS?=	${EPSTOPDFFLAGS}
#
PIC2PS?=	${GROFF} -p -S -Wall -mtty-char -man
#
PS2EPS?=	${PREFIX}/bin/gs
PS2EPSOPTS?=	-q -dNOPAUSE -dSAFER -dDELAYSAFER \
		-sPAPERSIZE=letter -r72 -sDEVICE=bit \
		-sOutputFile=/dev/null ${PS2EPSFLAGS} ps2epsi.ps
PS2BBOX?=	${PREFIX}/bin/gs
PS2BBOXOPTS?=	-q -dNOPAUSE -dBATCH -dSAFER -dDELAYSAFER \
		-sPAPERSIZE=letter -r72 -sDEVICE=bbox \
		-sOutputFile=/dev/null ${PS2BBOXFLAGS}
#
# Use suffix rules to convert .scr files to other formats
.SUFFIXES:	.scr .pic .png .ps .eps .txt

.scr.png:
	${SCR2PNG} ${SCR2PNGOPTS} < ${.IMPSRC} > ${.TARGET}

## If we want grayscale, convert with ppmtopgm before running through pnmtops
.if defined(GREYSCALE_IMAGES)
.scr.eps:
	${SCR2PNG} ${SCR2PNGOPTS} < ${.ALLSRC} | \
		${PNGTOPNM} ${PNGTOPNMOPTS} | \
		${PPMTOPGM} ${PPMTOPGMOPTS} | \
		${PNMTOPS} ${PNMTOPSOPTS} > ${.TARGET}
.else
.scr.eps:
	${SCR2PNG} ${SCR2PNGOPTS} < ${.ALLSRC} | \
		${PNGTOPNM} ${PNGTOPNMOPTS} | \
		${PNMTOPS} ${PNMTOPSOPTS} > ${.TARGET}
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
	${PIC2PS} ${.ALLSRC} > ${.TARGET}

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
	${PS2BBOX} ${PS2BBOXOPTS} ${.ALLSRC} > ${.TARGET} 2>&1
	${SETENV} outfile=${.TARGET} ${PS2EPS} ${PS2EPSOPTS} < ${.ALLSRC} 1>&2
	(echo "save countdictstack mark newpath /showpage {} def /setpagedevice {pop} def";\
		echo "%%EndProlog";\
		echo "%%Page: 1 1";\
		echo "%%BeginDocument: ${.ALLSRC}";\
	) >> ${.TARGET}
	${SED}	-e '/^%%BeginPreview:/,/^%%EndPreview[^!-~]*$$/d' \
		-e '/^%!PS-Adobe/d' \
		-e '/^%%[A-Za-z][A-Za-z]*[^!-~]*$$/d'\
		-e '/^%%[A-Za-z][A-Za-z]*: /d' < ${.ALLSRC} >> ${.TARGET}
	(echo "%%EndDocument";\
		echo "%%Trailer";\
		echo "cleartomark countdictstack exch sub { end } repeat restore";\
		echo "%%EOF";\
	) >> ${.TARGET}

# We can't use suffix rules to generate the rules to convert EPS to PNG and
# PNG to EPS.  This is because a .png file can depend on a .eps file, and
# vice versa, leading to a loop in the dependency graph.  Instead, build
# the targets on the fly.

.for _curimage in ${IMAGES_GEN_PNG}
${_curimage}: ${_curimage:S/.png$/.eps/}
	${EPSGEOM} -offset ${EPSGEOMOPTS} ${.ALLSRC} \
		| ${EPS2PNM} ${EPS2PNMOPTS} \
		-g`${EPSGEOM} -geom ${EPSGEOMOPTS} ${.ALLSRC}` - \
		| ${PNMTOPNG} > ${.TARGET}
.endfor

.for _curimage in ${IMAGES_GEN_EPS}
${_curimage}: ${_curimage:S/.eps$/.png/}
	${PNGTOPNM} ${PNGTOPNMOPTS} ${.ALLSRC} | \
		${PNMTOPS} ${PNMTOPSOPTS} > ${.TARGET}
.endfor

.for _curimage in ${IMAGES_GEN_PDF}
${_curimage}: ${_curimage:S/.pdf$/.eps/}
	${EPSTOPDF} ${EPSTOPDFOPTS} --outfile=${.TARGET} ${.ALLSRC}
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
# instead.  If you redefine this then you must also update the
# %callout-graphics-path% variable in the .dsl file.
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

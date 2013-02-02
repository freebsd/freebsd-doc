#
# $FreeBSD$
#

CP?=		/bin/cp
CAT?=		/bin/cat
ECHO_CMD?=	echo
LN?=		/bin/ln
MKDIR?=		/bin/mkdir
RM?=		/bin/rm
MV?=		/bin/mv
HTML2TXT?=	${PREFIX}/bin/w3m
HTML2TXTOPTS?=	-dump ${HTML2TXTFLAGS}
ISPELL?=	ispell
ISPELLOPTS?=	-l -p /usr/share/dict/freebsd ${ISPELLFLAGS}
.if exists(/usr/bin/perl)
PERL?=		/usr/bin/perl
.elif exists(/usr/local/bin/perl)
PERL?=		/usr/local/bin/perl
.else
PERL?=		perl
.endif
REALPATH?=	/bin/realpath
SETENV?=	/usr/bin/env
XSLTPROC?=	${PREFIX}/bin/xsltproc
XMLLINT?=	${PREFIX}/bin/xmllint

BUNZIP2?=	/usr/bin/bunzip2
FETCH?=		/usr/bin/fetch
FIND?=		/usr/bin/find
LN?=		/bin/ln
SH?=		/bin/sh
SORT?=		/usr/bin/sort
TRUE?=		/usr/bin/true

AWK?=		/usr/bin/awk
GREP?=		/usr/bin/grep
SED?=		/usr/bin/sed

PKG_CREATE?=	/usr/sbin/pkg_create
TAR?=		/usr/bin/tar
TOUCH?=		/usr/bin/touch
XARGS?=		/usr/bin/xargs

BZIP2?=		bzip2
BZIPOPTS?=	-qf9
GZIP?=		gzip
GZIPOPTS?=	-qf9
ZIP?=		${PREFIX}/bin/zip
ZIPOPTS?=	-j9

.if exists(${PREFIX}/bin/jade) && !defined(OPENJADE)
JADE?=		${PREFIX}/bin/jade
.else
JADE?=		${PREFIX}/bin/openjade
JADEFLAGS+=	-V openjade
.endif

FOP?=		${PREFIX}/bin/fop
FOPOPTS?=

GROFF?=		groff
HTML2PDB?=	${PREFIX}/bin/iSiloBSD
HTML2PDBOPTS?=	-y -d0 -Idef ${HTML2PDBFLAGS}
DVIPS?=		${PREFIX}/bin/dvips
.if defined(PAPERSIZE)
DVIPSOPTS?=	-t ${PAPERSIZE:L}
.endif
DVIPSOPTS+=	${DVIPSFLAGS}

#
# In teTeX 3.0 and later, pdfetex(1) is used as the default TeX
# engine for JadeTeX and tex(1) cannot be used as ${TEX_CMD} anymore
# due to incompatibility of the format file.  Since the teTeX 3.0
# distribution has "${PREFIX}/share/texmf-dist/LICENSE.texmf,"
# it is checked here to determine which TeX engine should be used.
.if exists(${PREFIX}/share/texmf-dist/LICENSE.texmf)
TEX_CMD?=	${PREFIX}/bin/etex
PDFTEX_CMD?=	${PREFIX}/bin/pdfetex
.else
TEX_CMD?=	${PREFIX}/bin/tex
PDFTEX_CMD?=	${PREFIX}/bin/pdftex
.endif
LATEX_CMD?=	${PREFIX}/bin/latex
JADETEX_CMD?=	${TEX_CMD} "&jadetex"
JADETEX_PREPROCESS?=	/bin/cat
PDFJADETEX_CMD?=${PDFTEX_CMD} "&pdfjadetex"
PDFJADETEX_PREPROCESS?= /bin/cat
PS2PDF?=	${PREFIX}/bin/ps2pdf
FOP_CMD?=	${PREFIX}/share/fop/fop.sh
XEP_CMD?=	sh ${HOME}/XEP/xep.sh
JAVA_CMD?=	${PREFIX}/bin/javavm
SAXON_CMD?=	${JAVA_CMD} -jar ${PREFIX}/share/java/classes/saxon.jar

#
# Currently, we have to use the FixRTF utility available as textproc/fixrtf
# to apply several RTF fixups:
#
# 1. Embed PNGs into RTF. (Option: -p)
# 2. Embed FreeBSD-specific information into RTF, such as organization name,
#    building time. But unfortunately, so far only Microsoft Word can read
#    them. In contrast, Microsoft Word Viewer and OpenOffice even cannot read
#    this kind of information from RTF created by Microsoft Word and
#    OpenOffice. (Option: -i)
# 3. Do some locale-specific fixing. (Option: -e <encoding>)
#
# This is a transitional solution before Jade/OpenJade provides these features.
#
FIXRTF?=	${PREFIX}/bin/fixrtf
FIXRTFOPTS?=	-i -p
.if defined(SP_ENCODING)
FIXRTFOPTS+=	-e ${SP_ENCODING}
.endif

SCR2PNG?=	${PREFIX}/bin/scr2png
SCR2PNGOPTS?=	${SCR2PNGFLAGS}
SCR2TXT?=	${PREFIX}/bin/scr2txt
SCR2TXTOPTS?=	-l ${SCR2TXTFLAGS}
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

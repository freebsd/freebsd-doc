# 
# $FreeBSD$
#
# Build the FreeBSD Handbook (Japanese).
#
# Original revision: 1.51
#

# ------------------------------------------------------------------------
#
# Handbook-specific variables
#
#	WITH_PGPKEYS	The print version of the handbook only prints PGP
#			fingerprints by default.  If you would like for the
#			entire key to be displayed, then set this variable.
#			This option has no affect on the HTML formats.
#
# Handbook-specific targets
#
#       pgpkeyring      This target will read the contents of
#                       pgpkeys/chapter.sgml and will extract all of
#                       the pgpkeys to standard out.  This output can then
#                       be redirected into a file and distributed as a 
#                       public keyring of FreeBSD developers that can
#                       easily be imported into PGP/GPG.
#
# ------------------------------------------------------------------------

MAINTAINER=kuriyama@FreeBSD.ORG

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

#IMAGES = advanced-networking/isdn-bus.eps
#IMAGES+= advanced-networking/isdn-twisted-pair.eps
#IMAGES+= advanced-networking/natd.eps
#IMAGES+= install/userconfig.scr
#IMAGES+= install/userconfig2.scr
#IMAGES+= install/hdwrconf.scr
#IMAGES+= install/probstart.scr
#IMAGES+= install/main1.scr
#IMAGES+= install/sysinstall-exit.scr
#IMAGES+= install/main-doc.scr
#IMAGES+= install/docmenu1.scr
#IMAGES+= install/main-keymap.scr
#IMAGES+= install/keymap.scr
#IMAGES+= install/main-options.scr
#IMAGES+= install/options.scr
#IMAGES+= install/main-std.scr
#IMAGES+= install/fdisk-drive1.scr
#IMAGES+= install/fdisk-edit1.scr
#IMAGES+= install/fdisk-edit2.scr
#IMAGES+= install/boot-mgr.scr
#IMAGES+= install/fdisk-drive2.scr
#IMAGES+= install/disklabel-ed1.scr
#IMAGES+= install/disklabel-auto.scr
#IMAGES+= install/disklabel-root1.scr
#IMAGES+= install/disklabel-root2.scr
#IMAGES+= install/disklabel-fs.scr
#IMAGES+= install/disklabel-root3.scr
#IMAGES+= install/disklabel-ed2.scr
#IMAGES+= install/dist-set.scr
#IMAGES+= install/dist-set2.scr
#IMAGES+= install/media.scr
#IMAGES+= install/ed0-conf.scr
#IMAGES+= install/ed0-conf2.scr
#IMAGES+= install/ftp-anon1.scr
#IMAGES+= install/ftp-anon2.scr
#IMAGES+= install/nfs-server-edit.scr
#IMAGES+= install/security.scr
#IMAGES+= install/console-saver1.scr
#IMAGES+= install/console-saver2.scr
#IMAGES+= install/console-saver3.scr
#IMAGES+= install/console-saver4.scr
#IMAGES+= install/timezone1.scr
#IMAGES+= install/timezone2.scr
#IMAGES+= install/timezone3.scr
#IMAGES+= install/mouse1.scr
#IMAGES+= install/mouse2.scr
#IMAGES+= install/mouse3.scr
#IMAGES+= install/mouse4.scr
#IMAGES+= install/mouse5.scr
#IMAGES+= install/mouse6.scr
#IMAGES+= install/xf86setup.scr
#IMAGES+= install/desktop.scr
#IMAGES+= install/pkg-cat.scr
#IMAGES+= install/pkg-sel.scr
#IMAGES+= install/pkg-install.scr
#IMAGES+= install/pkg-confirm.scr
#IMAGES+= install/adduser1.scr
#IMAGES+= install/adduser2.scr
#IMAGES+= install/adduser3.scr
#IMAGES+= install/mainexit.scr
#IMAGES+= install/disk-layout.eps
#IMAGES+= install/edit-inetd-conf.scr

# Images from the cross-document image library
#IMAGES_LIB=  callouts/1.png
#IMAGES_LIB+= callouts/2.png
#IMAGES_LIB+= callouts/3.png
#IMAGES_LIB+= callouts/4.png
#IMAGES_LIB+= callouts/5.png

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml
SRCS+= advanced-networking/chapter.sgml
SRCS+= basics/chapter.sgml
SRCS+= bibliography/chapter.sgml
SRCS+= config/chapter.sgml
SRCS+= boot/chapter.sgml
SRCS+= cutting-edge/chapter.sgml
SRCS+= disks/chapter.sgml
SRCS+= eresources/chapter.sgml
SRCS+= install/chapter.sgml
SRCS+= introduction/chapter.sgml
SRCS+= kernelconfig/chapter.sgml
SRCS+= l10n/chapter.sgml
SRCS+= linuxemu/chapter.sgml
SRCS+= mail/chapter.sgml
SRCS+= mirrors/chapter.sgml
SRCS+= pgpkeys/chapter.sgml
SRCS+= ppp-and-slip/chapter.sgml
SRCS+= printing/chapter.sgml
SRCS+= security/chapter.sgml
SRCS+= serialcomms/chapter.sgml
SRCS+= sound/chapter.sgml
SRCS+= users/chapter.sgml
SRCS+= x11/chapter.sgml
SRCS+= ports/chapter.sgml
SRCS+= colophon.sgml

# Entities
SRCS+= chapters.ent 

# Japanese only
SRCS+=	jcontrib/chapter.sgml

SYMLINKS=	${DESTDIR} index.html handbook.html

# Turn on all the chapters.
CHAPTERS?= ${SRCS:M*chapter.sgml}

SGMLFLAGS+= ${CHAPTERS:S/\/chapter.sgml//:S/^/-i chap./}

# XXX The Handbook build currently overflows some internal, hardcoded 
# limits in pdftex.  Until we split the Handbook up, build the PDF 
# version using ps2pdf instead of pdftex.

PS2PDF?=	${PREFIX}/bin/ps2pdf

book.tex-pdf:
	${TOUCH} book.tex-pdf

book.pdf: book.ps
	${PS2PDF} book.ps book.pdf

pgpkeyring: pgpkeys/chapter.sgml
	@${JADE} -V nochunks ${JADEOPTS} -d ${DSLPGP} -t sgml ${MASTERDOC}

DOC_PREFIX?= ${.CURDIR}/../../..

.for p in ftp cvsup
mirrors/chapter.sgml.${p}.inc: ${DOC_PREFIX}/share/sgml/mirrors.xml ${DOC_PREFIX}/share/sgml/mirrors.xsl ${DOC_PREFIX}/ja_JP.eucJP/share/sgml/mirrors.xsl ${DOC_PREFIX}/ja_JP.eucJP/share/sgml/transtable.xsl ${DOC_PREFIX}/ja_JP.eucJP/share/sgml/transtable.xml
	${XSLTPROC} ${XSLTPROCOPTS} --param 'proto' "'$p'" \
	    ${DOC_PREFIX}/ja_JP.eucJP/share/sgml/mirrors.xsl \
	    ${DOC_PREFIX}/share/sgml/mirrors.xml \
	    | sed -e "s,<\([^ >]*\)\([^>]*\)/>,<\1\2></\1>,;s,</anchor>,," > $@
SRCS+= mirrors/chapter.sgml.${p}.inc
CLEANFILES+= mirrors/chapter.sgml.${p}.inc
.endfor

#
# Handbook-specific variables
#
.if defined(WITH_PGPKEYS)
JADEFLAGS+=	-V withpgpkeys
.endif

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# The FreeBSD Documentation Project
# The FreeBSD French Documentation Project
#
# $FreeBSD$
# $Id: Makefile,v 1.9 2002-10-12 21:47:11 blackend Exp $
# Original revision: 1.61
#
# Build the FreeBSD Handbook.
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

MAINTAINER=blackend@FreeBSD.org

DOC?= book

FORMATS?= html-split

HAS_INDEX= true

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

#IMAGES = advanced-networking/isdn-bus.eps
#IMAGES+= advanced-networking/isdn-twisted-pair.eps
#IMAGES+= advanced-networking/natd.eps
IMAGES = ../../../en_US.ISO8859-1/books/handbook/install/userconfig.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/userconfig2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/hdwrconf.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/probstart.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/main1.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/sysinstall-exit.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/main-doc.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/docmenu1.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/main-keymap.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/keymap.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/main-options.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/options.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/main-std.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/fdisk-drive1.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/fdisk-edit1.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/fdisk-edit2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/boot-mgr.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/fdisk-drive2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/disklabel-ed1.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/disklabel-auto.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/disklabel-root1.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/disklabel-root2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/disklabel-fs.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/disklabel-root3.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/disklabel-ed2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/dist-set.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/dist-set2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/media.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/ed0-conf.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/ed0-conf2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/ftp-anon1.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/ftp-anon2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/nfs-server-edit.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/security.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/console-saver1.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/console-saver2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/console-saver3.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/console-saver4.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/timezone1.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/timezone2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/timezone3.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/mouse1.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/mouse2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/mouse3.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/mouse4.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/mouse5.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/mouse6.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/xf86setup.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/desktop.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/pkg-cat.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/pkg-sel.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/pkg-install.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/pkg-confirm.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/adduser1.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/adduser2.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/adduser3.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/mainexit.scr
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/disk-layout.eps
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/edit-inetd-conf.scr

IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/example-dir1.eps
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/example-dir2.eps
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/example-dir3.eps
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/example-dir4.eps
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/example-dir5.eps
#IMAGES+= vinum/vinum-concat.pic
#IMAGES+= vinum/vinum-mirrored-vol.pic
#IMAGES+= vinum/vinum-raid10-vol.pic
#IMAGES+= vinum/vinum-raid5-org.pic
#IMAGES+= vinum/vinum-simple-vol.pic
#IMAGES+= vinum/vinum-striped-vol.pic
#IMAGES+= vinum/vinum-striped.pic

# Images from the cross-document image library
IMAGES_LIB=  callouts/1.png
IMAGES_LIB+= callouts/2.png
IMAGES_LIB+= callouts/3.png
IMAGES_LIB+= callouts/4.png
IMAGES_LIB+= callouts/5.png
IMAGES_LIB+= callouts/6.png
IMAGES_LIB+= callouts/7.png
IMAGES_LIB+= callouts/8.png
IMAGES_LIB+= callouts/9.png
IMAGES_LIB+= callouts/10.png

#
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS+= book.sgml
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
SRCS+= multimedia/chapter.sgml
SRCS+= desktop/chapter.sgml
SRCS+= pgpkeys/chapter.sgml
SRCS+= ppp-and-slip/chapter.sgml
SRCS+= printing/chapter.sgml
SRCS+= security/chapter.sgml
SRCS+= serialcomms/chapter.sgml
SRCS+= users/chapter.sgml
SRCS+= vinum/chapter.sgml
SRCS+= x11/chapter.sgml
SRCS+= ports/chapter.sgml
SRCS+= preface/preface.sgml
SRCS+= colophon.sgml

# Entities
SRCS+= chapters.ent

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

#
# Handbook-specific variables
#
.if defined(WITH_PGPKEYS)
JADEFLAGS+=	-V withpgpkeys
.endif

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

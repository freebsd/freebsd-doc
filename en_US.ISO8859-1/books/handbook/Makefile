# 
# $FreeBSD: doc/en_US.ISO8859-1/books/handbook/Makefile,v 1.44 2001/08/16 05:19:51 dd Exp $
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
# ------------------------------------------------------------------------

MAINTAINER=nik@FreeBSD.org

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

IMAGES = advanced-networking/isdn-bus.eps
IMAGES+= advanced-networking/isdn-twisted-pair.eps
IMAGES+= advanced-networking/natd.eps
IMAGES+= install/userconfig.scr
IMAGES+= install/userconfig2.scr
IMAGES+= install/hdwrconf.scr
IMAGES+= install/probstart.scr
IMAGES+= install/main1.scr
IMAGES+= install/sysinstall-exit.scr
IMAGES+= install/main-doc.scr
IMAGES+= install/docmenu1.scr
IMAGES+= install/main-keymap.scr
IMAGES+= install/keymap.scr
IMAGES+= install/main-options.scr
IMAGES+= install/options.scr
IMAGES+= install/main-std.scr
IMAGES+= install/fdisk-drive1.scr
IMAGES+= install/fdisk-edit1.scr
IMAGES+= install/fdisk-edit2.scr
IMAGES+= install/boot-mgr.scr
IMAGES+= install/fdisk-drive2.scr
IMAGES+= install/disklabel-ed1.scr
IMAGES+= install/disklabel-auto.scr
IMAGES+= install/disklabel-root1.scr
IMAGES+= install/disklabel-root2.scr
IMAGES+= install/disklabel-fs.scr
IMAGES+= install/disklabel-root3.scr
IMAGES+= install/disklabel-ed2.scr
IMAGES+= install/dist-set.scr
IMAGES+= install/dist-set2.scr
IMAGES+= install/media.scr
IMAGES+= install/ed0-conf.scr
IMAGES+= install/ed0-conf2.scr
IMAGES+= install/ftp-anon1.scr
IMAGES+= install/ftp-anon2.scr
IMAGES+= install/nfs-server-edit.scr
IMAGES+= install/security.scr
IMAGES+= install/console-saver1.scr
IMAGES+= install/console-saver2.scr
IMAGES+= install/console-saver3.scr
IMAGES+= install/console-saver4.scr
IMAGES+= install/timezone1.scr
IMAGES+= install/timezone2.scr
IMAGES+= install/timezone3.scr
IMAGES+= install/mouse1.scr
IMAGES+= install/mouse2.scr
IMAGES+= install/mouse3.scr
IMAGES+= install/mouse4.scr
IMAGES+= install/mouse5.scr
IMAGES+= install/mouse6.scr
IMAGES+= install/xf86setup.scr
IMAGES+= install/desktop.scr
IMAGES+= install/pkg-cat.scr
IMAGES+= install/pkg-sel.scr
IMAGES+= install/pkg-install.scr
IMAGES+= install/pkg-confirm.scr
IMAGES+= install/adduser1.scr
IMAGES+= install/adduser2.scr
IMAGES+= install/adduser3.scr
IMAGES+= install/mainexit.scr
IMAGES+= install/disk-layout.eps

# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  book.sgml
SRCS+= advanced-networking/chapter.sgml
SRCS+= backups/chapter.sgml
SRCS+= basics/chapter.sgml
SRCS+= bibliography/chapter.sgml
SRCS+= config/chapter.sgml
SRCS+= boot/chapter.sgml
SRCS+= contrib/chapter.sgml
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
SRCS+= authors.ent 
SRCS+= chapters.ent 

SYMLINKS=	${DESTDIR} index.html handbook.html

# Turn on all the chapters.
CHAPTERS?= ${SRCS:M*chapter.sgml}

SGMLFLAGS+= ${CHAPTERS:S/\/chapter.sgml//:S/^/-i chap./}

# XXX The Handbook build currently overflows some internal, hardcoded 
# limits in pdftex.  Until we split the Handbook up, build the PDF 
# version using ps2pdf instead of pdftex.

book.tex-pdf:
	touch book.tex-pdf

book.pdf: book.ps
	ps2pdf book.ps book.pdf

DOC_PREFIX?= ${.CURDIR}/../../..

#
# Handbook-specific variables
#
.if defined(WITH_PGPKEYS)
JADEFLAGS+=	-V withpgpkeys
.endif

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

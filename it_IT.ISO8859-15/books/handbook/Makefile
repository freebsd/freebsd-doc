#
# $FreeBSD$
#
# Crea il Manuale di FreeBSD.
#

# ------------------------------------------------------------------------
#
# Variabili specifiche del Manuale
#
#       WITH_PGPKEYS    La versione stampata del manuale riporta solo i
#                       fingerprints PGP di base.  Se vuoi visualizzare
#                       le chiavi intere, allora setta questa variabile.
#                       Questa opzione non ha effetto sui formati HTML.
#
# Targets specifici del Manuale
#
#       pgpkeyring      Questo target leggerà il contenuto del file
#                       pgpkeys/chapter.sgml ad estrarrà tutte le chiavi
#                       pgp sullo standard output.  Questo output può
#                       quindi essere rediretto su un file e distribuito
#                       come un keyring pubblico degli sviluppatori di
#                       FreeBSD che può essere facilmente importato in
#                       PGP/GPG.
#
# ------------------------------------------------------------------------

MAINTAINER= sysadmin@alexdupre.com

DOC?= book

FORMATS?= html-split

HAS_INDEX= true

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

IMAGES = ../../../en_US.ISO8859-1/books/handbook/advanced-networking/isdn-bus.eps
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/advanced-networking/isdn-twisted-pair.eps
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/advanced-networking/natd.eps
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/install/userconfig.scr
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
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/vinum/vinum-concat.pic
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/vinum/vinum-mirrored-vol.pic
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/vinum/vinum-raid10-vol.pic
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/vinum/vinum-raid5-org.pic
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/vinum/vinum-simple-vol.pic
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/vinum/vinum-striped-vol.pic
IMAGES+= ../../../en_US.ISO8859-1/books/handbook/vinum/vinum-striped.pic

# Immagini dalla libreria per tutti i documenti
IMAGES_LIB = callouts/1.png
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
# SRCS lista i singoli files SGML che compongono il documento. Modifiche
# a qualunque di questi files obbligano la ricreazione
#

# Contenuto SGML
SRCS = book.sgml
SRCS+= advanced-networking/chapter.sgml
SRCS+= basics/chapter.sgml
SRCS+= bibliography/chapter.sgml
SRCS+= config/chapter.sgml
SRCS+= boot/chapter.sgml
SRCS+= cutting-edge/chapter.sgml
SRCS+= desktop/chapter.sgml
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

# Attiva tutti i capitoli.
CHAPTERS?= ${SRCS:M*chapter.sgml}

SGMLFLAGS+= ${CHAPTERS:S/\/chapter.sgml//:S/^/-i chap./}

# XXX La creazione del Manuale attualmente sfora dei limiti interni,
# codificati in pdftex.  Finché non dividiamo il Manuale, crea la versione
# PDF usando ps2pdf invece di pdftex.

PS2PDF?=	${PREFIX}/bin/ps2pdf

book.tex-pdf:
	${TOUCH} book.tex-pdf

book.pdf: book.ps
	${PS2PDF} book.ps book.pdf

pgpkeyring: pgpkeys/chapter.sgml
	@${JADE} -V nochunks ${JADEOPTS} -d ${DSLPGP} -t sgml ${MASTERDOC}

DOC_PREFIX?= ${.CURDIR}/../../..

#
# Variabili specifiche del Manuale
#
.if defined(WITH_PGPKEYS)
JADEFLAGS+=	-V withpgpkeys
.endif

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

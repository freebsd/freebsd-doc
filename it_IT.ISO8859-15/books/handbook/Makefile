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
IMAGES+= install/edit-inetd-conf.scr

IMAGES+= install/example-dir1.eps
IMAGES+= install/example-dir2.eps
IMAGES+= install/example-dir3.eps
IMAGES+= install/example-dir4.eps
IMAGES+= install/example-dir5.eps
IMAGES+= vinum/vinum-concat.pic
IMAGES+= vinum/vinum-mirrored-vol.pic
IMAGES+= vinum/vinum-raid10-vol.pic
IMAGES+= vinum/vinum-raid5-org.pic
IMAGES+= vinum/vinum-simple-vol.pic
IMAGES+= vinum/vinum-striped-vol.pic
IMAGES+= vinum/vinum-striped.pic

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

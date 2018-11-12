# The FreeBSD Polish Documentation Project
#
# $FreeBSD$
# Original revision: 1.100
#
# Build the FreeBSD Handbook.
#

.PATH: ${.CURDIR}/../../share/xml/glossary

MAINTAINER=	doc@FreeBSD.org

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

IMAGES_EN = advanced-networking/isdn-bus.eps
IMAGES_EN+= advanced-networking/isdn-twisted-pair.eps
IMAGES_EN+= advanced-networking/natd.eps
IMAGES_EN+= advanced-networking/net-routing.pic
IMAGES_EN+= advanced-networking/static-routes.pic
IMAGES_EN+= geom/striping.pic
IMAGES_EN+= install/adduser1.scr
IMAGES_EN+= install/adduser2.scr
IMAGES_EN+= install/adduser3.scr
IMAGES_EN+= install/boot-mgr.scr
IMAGES_EN+= install/console-saver1.scr
IMAGES_EN+= install/console-saver2.scr
IMAGES_EN+= install/console-saver3.scr
IMAGES_EN+= install/console-saver4.scr
IMAGES_EN+= install/desktop.scr
IMAGES_EN+= install/disklabel-auto.scr
IMAGES_EN+= install/disklabel-ed1.scr
IMAGES_EN+= install/disklabel-ed2.scr
IMAGES_EN+= install/disklabel-fs.scr
IMAGES_EN+= install/disklabel-root1.scr
IMAGES_EN+= install/disklabel-root2.scr
IMAGES_EN+= install/disklabel-root3.scr
IMAGES_EN+= install/disk-layout.eps
IMAGES_EN+= install/dist-set.scr
IMAGES_EN+= install/dist-set2.scr
IMAGES_EN+= install/docmenu1.scr
IMAGES_EN+= install/ed0-conf.scr
IMAGES_EN+= install/ed0-conf2.scr
IMAGES_EN+= install/edit-inetd-conf.scr
IMAGES_EN+= install/fdisk-drive1.scr
IMAGES_EN+= install/fdisk-drive2.scr
IMAGES_EN+= install/fdisk-edit1.scr
IMAGES_EN+= install/fdisk-edit2.scr
IMAGES_EN+= install/ftp-anon1.scr
IMAGES_EN+= install/ftp-anon2.scr
IMAGES_EN+= install/hdwrconf.scr
IMAGES_EN+= install/keymap.scr
IMAGES_EN+= install/main1.scr
IMAGES_EN+= install/mainexit.scr
IMAGES_EN+= install/main-std.scr
IMAGES_EN+= install/main-options.scr
IMAGES_EN+= install/main-doc.scr
IMAGES_EN+= install/main-keymap.scr
IMAGES_EN+= install/media.scr
IMAGES_EN+= install/mouse1.scr
IMAGES_EN+= install/mouse2.scr
IMAGES_EN+= install/mouse3.scr
IMAGES_EN+= install/mouse4.scr
IMAGES_EN+= install/mouse5.scr
IMAGES_EN+= install/mouse6.scr
IMAGES_EN+= install/mta-main.scr
IMAGES_EN+= install/net-config-menu1.scr
IMAGES_EN+= install/net-config-menu2.scr
IMAGES_EN+= install/nfs-server-edit.scr
IMAGES_EN+= install/ntp-config.scr
IMAGES_EN+= install/options.scr
IMAGES_EN+= install/pkg-cat.scr
IMAGES_EN+= install/pkg-confirm.scr
IMAGES_EN+= install/pkg-install.scr
IMAGES_EN+= install/pkg-sel.scr
IMAGES_EN+= install/probstart.scr
IMAGES_EN+= install/routed.scr
IMAGES_EN+= install/security.scr
IMAGES_EN+= install/sysinstall-exit.scr
IMAGES_EN+= install/timezone1.scr
IMAGES_EN+= install/timezone2.scr
IMAGES_EN+= install/timezone3.scr
IMAGES_EN+= install/userconfig.scr
IMAGES_EN+= install/userconfig2.scr
IMAGES_EN+= install/xf86setup.scr
IMAGES_EN+= mail/mutt1.scr
IMAGES_EN+= mail/mutt2.scr
IMAGES_EN+= mail/mutt3.scr
IMAGES_EN+= mail/pine1.scr
IMAGES_EN+= mail/pine2.scr
IMAGES_EN+= mail/pine3.scr
IMAGES_EN+= mail/pine4.scr
IMAGES_EN+= mail/pine5.scr

IMAGES_EN+= install/example-dir1.eps
IMAGES_EN+= install/example-dir2.eps
IMAGES_EN+= install/example-dir3.eps
IMAGES_EN+= install/example-dir4.eps
IMAGES_EN+= install/example-dir5.eps
IMAGES_EN+= security/ipsec-network.pic
IMAGES_EN+= security/ipsec-crypt-pkt.pic
IMAGES_EN+= security/ipsec-encap-pkt.pic
IMAGES_EN+= security/ipsec-out-pkt.pic
IMAGES_EN+= vinum/vinum-concat.pic
IMAGES_EN+= vinum/vinum-mirrored-vol.pic
IMAGES_EN+= vinum/vinum-raid10-vol.pic
IMAGES_EN+= vinum/vinum-raid5-org.pic
IMAGES_EN+= vinum/vinum-simple-vol.pic
IMAGES_EN+= vinum/vinum-striped-vol.pic
IMAGES_EN+= vinum/vinum-striped.pic

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
# SRCS lists the individual XML files that make up the document. Changes
# to any of these files will force a rebuild
#

# XML content
SRCS+= audit/chapter.xml
SRCS+= book.xml
SRCS+= colophon.xml
SRCS+= advanced-networking/chapter.xml
SRCS+= basics/chapter.xml
SRCS+= bibliography/chapter.xml
SRCS+= boot/chapter.xml
SRCS+= config/chapter.xml
SRCS+= cutting-edge/chapter.xml
SRCS+= desktop/chapter.xml
SRCS+= disks/chapter.xml
SRCS+= eresources/chapter.xml
SRCS+= firewalls/chapter.xml
SRCS+= geom/chapter.xml
SRCS+= install/chapter.xml
SRCS+= introduction/chapter.xml
SRCS+= kernelconfig/chapter.xml
SRCS+= l10n/chapter.xml
SRCS+= linuxemu/chapter.xml
SRCS+= mac/chapter.xml
SRCS+= mail/chapter.xml
SRCS+= mirrors/chapter.xml
SRCS+= multimedia/chapter.xml
SRCS+= network-servers/chapter.xml
SRCS+= pgpkeys/chapter.xml
SRCS+= ports/chapter.xml
SRCS+= ppp-and-slip/chapter.xml
SRCS+= preface/preface.xml
SRCS+= printing/chapter.xml
SRCS+= security/chapter.xml
SRCS+= serialcomms/chapter.xml
SRCS+= users/chapter.xml
SRCS+= vinum/chapter.xml
SRCS+= x11/chapter.xml

# Entities
SRCS+= chapters.ent

SYMLINKS=	${DESTDIR} index.html handbook.html

# Turn on all the chapters.
CHAPTERS?= ${SRCS:M*chapter.xml}

XMLFLAGS+= ${CHAPTERS:S/\/chapter.xml//:S/^/-i chap./}
XMLFLAGS+= -i chap.freebsd-glossary

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

#
# rules generating lists of mirror site from XML database.
#
XMLDOCS=	lastmod:::mirrors.lastmod.inc \
		mirrors-ftp-index:::mirrors.xml.ftp.index.inc \
		mirrors-ftp:::mirrors.xml.ftp.inc \
		mirrors-cvsup-index:::mirrors.xml.cvsup.index.inc \
		mirrors-cvsup:::mirrors.xml.cvsup.inc \
		eresources-index:::eresources.xml.www.index.inc \
		eresources:::eresources.xml.www.inc
DEPENDSET.DEFAULT=	transtable mirror
XSLT.DEFAULT=		${XSL_MIRRORS}
XML.DEFAULT=		${XML_MIRRORS}

PARAMS.lastmod+=	--param 'target' "'lastmod'"
PARAMS.mirrors-ftp-index+=	--param 'type' "'ftp'" \
				--param 'proto' "'ftp'" \
				--param 'target' "'index'"
PARAMS.mirrors-ftp+=	--param 'type' "'ftp'" \
			--param 'proto' "'ftp'" \
			--param 'target' "'handbook/mirrors/chapter.xml'"
PARAMS.mirrors-cvsup-index+=	--param 'type' "'cvsup'" \
				--param 'proto' "'cvsup'" \
				--param 'target' "'index'"
PARAMS.mirrors-cvsup+=	--param 'type' "'cvsup'" \
			--param 'proto' "'cvsup'" \
			--param 'target' "'handbook/mirrors/chapter.xml'"
PARAMS.eresources-index+=	--param 'type' "'www'" \
				--param 'proto' "'http'" \
				--param 'target' "'index'"
PARAMS.eresources+=	--param 'type' "'www'" \
			--param 'proto' "'http'" \
			--param 'target' "'handbook/eresources/chapter.xml'"

EXTRAS=		mirrors.lastmod.inc \
		mirrors.xml.ftp.inc \
		mirrors.xml.ftp.index.inc \
		mirrors.xml.cvsup.inc \
		mirrors.xml.cvsup.index.inc \
		eresources.xml.www.inc \
		eresources.xml.www.index.inc

XMLDOCS_NO_SRCS=YES
CLEANFILES+= ${EXTRAS}

_extras: ${EXTRAS}
mirrors/chapter.xml: ${EXTRAS}

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

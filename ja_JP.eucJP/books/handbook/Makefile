#
# $FreeBSD$
#
# Build the FreeBSD Handbook (Japanese).
#
# Original revision: r47551
#

# ------------------------------------------------------------------------
# To add a new chapter to the Handbook:
#
# - Update this Makefile, chapters.ent and book.xml
# - Add a descriptive entry for the new chapter in preface/preface.xml
#
# ------------------------------------------------------------------------

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
#IMAGES_EN+= advanced-networking/pxe-nfs.png
IMAGES_EN+= advanced-networking/static-routes.pic
IMAGES_EN+= bsdinstall/bsdinstall-adduser1.png
IMAGES_EN+= bsdinstall/bsdinstall-adduser2.png
IMAGES_EN+= bsdinstall/bsdinstall-adduser3.png
IMAGES_EN+= bsdinstall/bsdinstall-boot-loader-menu.png
IMAGES_EN+= bsdinstall/bsdinstall-boot-options-menu.png
IMAGES_EN+= bsdinstall/bsdinstall-newboot-loader-menu.png
IMAGES_EN+= bsdinstall/bsdinstall-choose-mode.png
IMAGES_EN+= bsdinstall/bsdinstall-config-components.png
IMAGES_EN+= bsdinstall/bsdinstall-config-hostname.png
IMAGES_EN+= bsdinstall/bsdinstall-config-keymap.png
IMAGES_EN+= bsdinstall/bsdinstall-config-services.png
IMAGES_EN+= bsdinstall/bsdinstall-config-crashdump.png
IMAGES_EN+= bsdinstall/bsdinstall-configure-network-interface-ipv4-dhcp.png
IMAGES_EN+= bsdinstall/bsdinstall-configure-network-interface-ipv4.png
IMAGES_EN+= bsdinstall/bsdinstall-configure-network-interface-ipv4-static.png
IMAGES_EN+= bsdinstall/bsdinstall-configure-network-interface-ipv6.png
IMAGES_EN+= bsdinstall/bsdinstall-configure-network-interface-ipv6-static.png
IMAGES_EN+= bsdinstall/bsdinstall-configure-network-interface-slaac.png
IMAGES_EN+= bsdinstall/bsdinstall-configure-network-interface.png
IMAGES_EN+= bsdinstall/bsdinstall-configure-network-ipv4-dns.png
IMAGES_EN+= bsdinstall/bsdinstall-configure-wireless-accesspoints.png
IMAGES_EN+= bsdinstall/bsdinstall-configure-wireless-scan.png
IMAGES_EN+= bsdinstall/bsdinstall-configure-wireless-wpa2setup.png
IMAGES_EN+= bsdinstall/bsdinstall-distfile-extracting.png
IMAGES_EN+= bsdinstall/bsdinstall-distfile-fetching.png
IMAGES_EN+= bsdinstall/bsdinstall-distfile-verifying.png
IMAGES_EN+= bsdinstall/bsdinstall-final-confirmation.png
IMAGES_EN+= bsdinstall/bsdinstall-finalconfiguration.png
IMAGES_EN+= bsdinstall/bsdinstall-final-modification-shell.png
IMAGES_EN+= bsdinstall/bsdinstall-keymap-10.png
IMAGES_EN+= bsdinstall/bsdinstall-keymap-select-default.png
IMAGES_EN+= bsdinstall/bsdinstall-mainexit.png
IMAGES_EN+= bsdinstall/bsdinstall-netinstall-files.png
IMAGES_EN+= bsdinstall/bsdinstall-netinstall-mirrorselect.png
IMAGES_EN+= bsdinstall/bsdinstall-part-entire-part.png
IMAGES_EN+= bsdinstall/bsdinstall-part-guided-disk.png
IMAGES_EN+= bsdinstall/bsdinstall-part-guided-manual.png
IMAGES_EN+= bsdinstall/bsdinstall-part-manual-addpart.png
IMAGES_EN+= bsdinstall/bsdinstall-part-manual-create.png
IMAGES_EN+= bsdinstall/bsdinstall-part-manual-partscheme.png
IMAGES_EN+= bsdinstall/bsdinstall-part-review.png
IMAGES_EN+= bsdinstall/bsdinstall-post-root-passwd.png
IMAGES_EN+= bsdinstall/bsdinstall-set-clock-local-utc.png
IMAGES_EN+= bsdinstall/bsdinstall-timezone-confirm.png
IMAGES_EN+= bsdinstall/bsdinstall-timezone-country.png
IMAGES_EN+= bsdinstall/bsdinstall-timezone-region.png
IMAGES_EN+= bsdinstall/bsdinstall-timezone-zone.png
IMAGES_EN+= bsdinstall/bsdinstall-zfs-disk_info.png
IMAGES_EN+= bsdinstall/bsdinstall-zfs-disk_select.png
IMAGES_EN+= bsdinstall/bsdinstall-zfs-geli_password.png
IMAGES_EN+= bsdinstall/bsdinstall-zfs-menu.png
IMAGES_EN+= bsdinstall/bsdinstall-zfs-partmenu.png
IMAGES_EN+= bsdinstall/bsdinstall-zfs-vdev_invalid.png
IMAGES_EN+= bsdinstall/bsdinstall-zfs-vdev_type.png
IMAGES_EN+= bsdinstall/bsdinstall-zfs-warning.png
IMAGES_EN+= geom/striping.pic
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
#IMAGES_EN+= security/ipsec-network.pic
#IMAGES_EN+= security/ipsec-crypt-pkt.pic
#IMAGES_EN+= security/ipsec-encap-pkt.pic
#IMAGES_EN+= security/ipsec-out-pkt.pic
IMAGES_EN+= virtualization/parallels-freebsd1.png
IMAGES_EN+= virtualization/parallels-freebsd2.png
IMAGES_EN+= virtualization/parallels-freebsd3.png
IMAGES_EN+= virtualization/parallels-freebsd4.png
IMAGES_EN+= virtualization/parallels-freebsd5.png
IMAGES_EN+= virtualization/parallels-freebsd6.png
IMAGES_EN+= virtualization/parallels-freebsd7.png
IMAGES_EN+= virtualization/parallels-freebsd8.png
IMAGES_EN+= virtualization/parallels-freebsd9.png
IMAGES_EN+= virtualization/parallels-freebsd10.png
IMAGES_EN+= virtualization/parallels-freebsd11.png
IMAGES_EN+= virtualization/parallels-freebsd12.png
IMAGES_EN+= virtualization/parallels-freebsd13.png
IMAGES_EN+= virtualization/virtualpc-freebsd1.png
IMAGES_EN+= virtualization/virtualpc-freebsd2.png
IMAGES_EN+= virtualization/virtualpc-freebsd3.png
IMAGES_EN+= virtualization/virtualpc-freebsd4.png
IMAGES_EN+= virtualization/virtualpc-freebsd5.png
IMAGES_EN+= virtualization/virtualpc-freebsd6.png
IMAGES_EN+= virtualization/virtualpc-freebsd7.png
IMAGES_EN+= virtualization/virtualpc-freebsd8.png
IMAGES_EN+= virtualization/virtualpc-freebsd9.png
IMAGES_EN+= virtualization/virtualpc-freebsd10.png
IMAGES_EN+= virtualization/virtualpc-freebsd11.png
IMAGES_EN+= virtualization/virtualpc-freebsd12.png
IMAGES_EN+= virtualization/virtualpc-freebsd13.png
IMAGES_EN+= virtualization/vmware-freebsd01.png
IMAGES_EN+= virtualization/vmware-freebsd02.png
IMAGES_EN+= virtualization/vmware-freebsd03.png
IMAGES_EN+= virtualization/vmware-freebsd04.png
IMAGES_EN+= virtualization/vmware-freebsd05.png
IMAGES_EN+= virtualization/vmware-freebsd06.png
IMAGES_EN+= virtualization/vmware-freebsd07.png
IMAGES_EN+= virtualization/vmware-freebsd08.png
IMAGES_EN+= virtualization/vmware-freebsd09.png
IMAGES_EN+= virtualization/vmware-freebsd10.png
IMAGES_EN+= virtualization/vmware-freebsd11.png
IMAGES_EN+= virtualization/vmware-freebsd12.png

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
IMAGES_LIB+= callouts/11.png
IMAGES_LIB+= callouts/12.png
IMAGES_LIB+= callouts/13.png
IMAGES_LIB+= callouts/14.png
IMAGES_LIB+= callouts/15.png

#
# SRCS lists the individual XML files that make up the document. Changes
# to any of these files will force a rebuild
#

# XML content
#SRCS+= audit/chapter.xml
SRCS+= book.xml
SRCS+= bsdinstall/chapter.xml
SRCS+= colophon.xml
#SRCS+= dtrace/chapter.xml
#SRCS+= freebsd-glossary.xml
SRCS+= advanced-networking/chapter.xml
SRCS+= basics/chapter.xml
SRCS+= bibliography/chapter.xml
SRCS+= boot/chapter.xml
SRCS+= config/chapter.xml
SRCS+= cutting-edge/chapter.xml
SRCS+= desktop/chapter.xml
SRCS+= disks/chapter.xml
SRCS+= eresources/chapter.xml
#SRCS+= firewalls/chapter.xml
#SRCS+= zfs/chapter.xml
#SRCS+= filesystems/chapter.xml
#SRCS+= geom/chapter.xml
SRCS+= introduction/chapter.xml
#SRCS+= jails/chapter.xml
SRCS+= kernelconfig/chapter.xml
SRCS+= l10n/chapter.xml
SRCS+= linuxemu/chapter.xml
#SRCS+= mac/chapter.xml
SRCS+= mail/chapter.xml
SRCS+= mirrors/chapter.xml
SRCS+= multimedia/chapter.xml
#SRCS+= network-servers/chapter.xml
SRCS+= pgpkeys/chapter.xml
SRCS+= ports/chapter.xml
SRCS+= ppp-and-slip/chapter.xml
SRCS+= preface/preface.xml
SRCS+= printing/chapter.xml
SRCS+= security/chapter.xml
SRCS+= serialcomms/chapter.xml
SRCS+= users/chapter.xml
#SRCS+= virtualization/chapter.xml
SRCS+= x11/chapter.xml

# Entities
SRCS+= chapters.ent

# Japanese only
SRCS+=	jcontrib/chapter.xml

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
PARAMS.eresources-index+=	--param 'type' "'www'" \
				--param 'proto' "'http'" \
				--param 'target' "'index'"
PARAMS.eresources+=	--param 'type' "'www'" \
			--param 'proto' "'http'" \
			--param 'target' "'handbook/eresources/chapter.xml'"

SRCS+=		mirrors.lastmod.inc \
		mirrors.xml.ftp.inc \
		mirrors.xml.ftp.index.inc \
		eresources.xml.www.inc \
		eresources.xml.www.index.inc

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

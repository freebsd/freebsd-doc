# 
# $FreeBSD$
#
# Build the FreeBSD Handbook.
#

MAINTAINER=	statue@freebsd.sinica.edu.tw

DOC?= zh-tut

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

DSLHTML=	freebsd.dsl
DSLPRINT=	freebsd.dsl
# 
# SRCS lists the individual SGML files that make up the document. Changes
# to any of these files will force a rebuild
#

# SGML content
SRCS=  zh-tut.sgml
SRCS+= chapters/ack.sgml
SRCS+= chapters/compose.sgml
SRCS+= chapters/converter.sgml
SRCS+= chapters/charmap.sgml
SRCS+= chapters/devel.sgml
SRCS+= chapters/dict.sgml
SRCS+= chapters/difficult.sgml
SRCS+= chapters/faq.sgml
SRCS+= chapters/fonts.sgml
SRCS+= chapters/l10n.sgml
SRCS+= chapters/mailclient.sgml
SRCS+= chapters/message.sgml
SRCS+= chapters/multimedia.sgml
SRCS+= chapters/net.sgml
SRCS+= chapters/other.sgml
SRCS+= chapters/outta.sgml
SRCS+= chapters/preface.sgml
SRCS+= chapters/print.sgml
SRCS+= chapters/software.sgml
SRCS+= chapters/stepbystep.sgml
SRCS+= chapters/view.sgml
SRCS+= chapters/wm.sgml
SRCS+= chapters/xwin.sgml

# Entities
SRCS+= authors.ent 
SRCS+= chapters.ent 

IMAGES=		images/20020527-2.png
IMAGES+=	images/20020527.png
IMAGES+=	images/Eterm.png
IMAGES+=	images/IglooFTP.png
IMAGES+=	images/abiword.png
IMAGES+=	images/acroread.png
IMAGES+=	images/applet.png
IMAGES+=	images/arphicttf.png
IMAGES+=	images/aterm.png
IMAGES+=	images/bbsnet.png
IMAGES+=	images/bg5pdf.png
IMAGES+=	images/bg5ps.png
IMAGES+=	images/big5con.png
IMAGES+=	images/cccii.png
IMAGES+=	images/cce.png
IMAGES+=	images/cid-gv.png
IMAGES+=	images/cjk.png
IMAGES+=	images/cjk-lyx.png
IMAGES+=	images/cwtexttf.png
IMAGES+=	images/cxterm.png
IMAGES+=	images/dict.png
IMAGES+=	images/dvipdfmx.png
IMAGES+=	images/edict-big5.png
IMAGES+=	images/fzzdxfw.png
IMAGES+=	images/fortunetw.png
IMAGES+=	images/gaim.png
IMAGES+=	images/gnuls.png
IMAGES+=	images/hanzim.png
IMAGES+=	images/hztty.png
IMAGES+=	images/irssi.png
IMAGES+=	images/joe.png
IMAGES+=	images/kde-print.png
IMAGES+=	images/kfont_3_1.png
IMAGES+=	images/kmerlin.png
IMAGES+=	images/konq_3_1.png
IMAGES+=	images/konq_3_2.png
IMAGES+=	images/konq_3_3.png
IMAGES+=	images/konq_3_4.png
IMAGES+=	images/konqueror.png
IMAGES+=	images/konsole.png
IMAGES+=	images/ldap.png
IMAGES+=	images/lynx.png
IMAGES+=	images/licq.png
IMAGES+=	images/man.png
IMAGES+=	images/mlterm.png
IMAGES+=	images/mplayer.png
IMAGES+=	images/moefonts-cid.png
IMAGES+=	images/moettf.png
IMAGES+=	images/mozilla.png
IMAGES+=	images/mutt.png
IMAGES+=	images/nautilus.png
IMAGES+=	images/ncftp3.png
IMAGES+=	images/ntfs.png
IMAGES+=	images/ntuttf.png
IMAGES+=	images/openoffice.png
IMAGES+=	images/oxford.png
IMAGES+=	images/php-imagettftext.png
IMAGES+=	images/php-pdf.png
IMAGES+=	images/pydict.png
IMAGES+=	images/qe.png
IMAGES+=	images/qkmj.png
IMAGES+=	images/qterm.png
IMAGES+=	images/rxvt.png
IMAGES+=	images/showttf.png
IMAGES+=	images/stardict.png
IMAGES+=	images/stardict2.png
IMAGES+=	images/swing.png
IMAGES+=	images/sylpheed.png
IMAGES+=	images/tcltk.png
IMAGES+=	images/tcsh.png
IMAGES+=	images/tin.png
IMAGES+=	images/tintin++.png
IMAGES+=	images/ttf2pt1.png
IMAGES+=	images/ve.png
IMAGES+=	images/vim.png
IMAGES+=	images/vnc.png
IMAGES+=	images/wangttf.png
IMAGES+=	images/windowmaker.png
IMAGES+=	images/xchat.png
IMAGES+=	images/xcin25.png
IMAGES+=	images/xmms.png
IMAGES+=	images/xpdf.png
IMAGES+=	images/zhcon.png

URL_RELPREFIX?= ../../../..
DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

# $Id: Makefile,v 1.28 1999-03-02 18:08:34 motoyuki Exp $
# Original revision: 1.34
# The FreeBSD Japanese Documentation Project

.NOTPARALLEL:

DOC=	handbook
DOCDIR=${SHAREDIR}/doc/ja
FORMATS?= html roff
SGMLOPTS+=-e EUC-JP
SGMLOPTS+=-links

SRCS= anoncvs.sgml authors.sgml backups.sgml basics.sgml bibliography.sgml boothelp.sgml
SRCS+= booting.sgml contrib.sgml crypt.sgml ctm.sgml current.sgml cvsup.sgml
SRCS+= cyclades.sgml development.sgml dialup.sgml dialout.sgml
SRCS+= disks.sgml diskless.sgml dma.sgml eresources.sgml esdi.sgml 
SRCS+= firewalls.sgml german.sgml glossary.sgml goals.sgml
SRCS+= handbook.sgml history.sgml hw.sgml install.sgml isdn.sgml
SRCS+= kerberos.sgml kernelconfig.sgml kerneldebug.sgml kernelopts.sgml
SRCS+= lists.sgml mail.sgml makeworld.sgml memoryuse.sgml vm.sgml
SRCS+= mirrors.sgml nfs.sgml nutshell.sgml pgpkeys.sgml policies.sgml
SRCS+= porting.sgml ports.sgml ppp.sgml printing.sgml
SRCS+= quotas.sgml relnotes.sgml routing.sgml russian.sgml
SRCS+= serial.sgml scsi.sgml scsihd.sgml sections.sgml sio.sgml skey.sgml
SRCS+= slipc.sgml slips.sgml stable.sgml submitters.sgml synching.sgml 
SRCS+= term.sgml userppp.sgml uart.sgml linuxemu.sgml
SRCS+= jcontrib.sgml jmembers.sgml

.include <bsd.sgml.mk>

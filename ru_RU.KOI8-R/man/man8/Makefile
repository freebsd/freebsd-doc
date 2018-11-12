# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/man/man8/Makefile,v 1.10 2007/11/20 06:53:29 ru Exp $

MAN=	bsdlabel.8 \
	fdisk.8 \
	gjournal.8 \
	intro.8 \
	mount_ntfs.8 \
	nanobsd.8

.if ${MACHINE_ARCH} == "i386" || ${MACHINE_ARCH} == "amd64"
MLINKS=	bsdlabel.8 disklabel.8
.endif

.include <bsd.prog.mk>

#
#    The FreeBSD Documentation Project
#    The FreeBSD French Documentation Project
#
#    Compilation du Manuel de Reference de FreeBSD
#
#    $FreeBSD$
#    Original revision: 1.25
#

#
# Nik is only the maintainer until Sebastien GIORIA's commit privs are
# sorted out and he can maintain this.
#
MAINTAINER=nik@FreeBSD.ORG

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

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
SRCS+= contrib/chapter.sgml
SRCS+= cutting-edge/chapter.sgml
SRCS+= disks/chapter.sgml
SRCS+= eresources/chapter.sgml
SRCS+= hw/chapter.sgml
SRCS+= install/chapter.sgml
SRCS+= internals/chapter.sgml
SRCS+= introduction/chapter.sgml
SRCS+= kernelconfig/chapter.sgml
SRCS+= kerneldebug/chapter.sgml
SRCS+= kernelopts/chapter.sgml
SRCS+= l10n/chapter.sgml
SRCS+= linuxemu/chapter.sgml
SRCS+= mail/chapter.sgml
SRCS+= mirrors/chapter.sgml
SRCS+= pgpkeys/chapter.sgml
SRCS+= policies/chapter.sgml
SRCS+= ppp-and-slip/chapter.sgml
SRCS+= printing/chapter.sgml
SRCS+= quotas/chapter.sgml
SRCS+= security/chapter.sgml
SRCS+= serialcomms/chapter.sgml
SRCS+= staff/chapter.sgml
SRCS+= x11/chapter.sgml
SRCS+= ports/chapter.sgml

# Entities
SRCS+= chapters.ent 

# XXX The Handbook build currently overflows some internal, hardcoded 
# limits in pdftex.  Until we split the Handbook up, build the PDF 
# version using ps2pdf instead of pdftex.

PS2PDF?=        ${PREFIX}/bin/ps2pdf

book.tex-pdf:
	${TOUCH} book.tex-pdf

book.pdf: book.ps
	${PS2PDF} book.ps book.pdf

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

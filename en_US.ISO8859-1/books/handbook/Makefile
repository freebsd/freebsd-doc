# 
# $FreeBSD: doc/en_US.ISO8859-1/books/handbook/Makefile,v 1.37 2001/07/12 01:40:31 murray Exp $
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
SRCS+= hw/chapter.sgml
SRCS+= install/chapter.sgml
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
SRCS+= security/chapter.sgml
SRCS+= serialcomms/chapter.sgml
SRCS+= sound/chapter.sgml
SRCS+= staff/chapter.sgml
SRCS+= users/chapter.sgml
SRCS+= x11/chapter.sgml
SRCS+= ports/chapter.sgml

# Entities
SRCS+= authors.ent 
SRCS+= chapters.ent 

SYMLINKS=	${DESTDIR} index.html handbook.html

# Turn on all the chapters.
CHAPTERS?= ${SRCS:M*chapter.sgml}

JADEFLAGS+= ${CHAPTERS:S/\/chapter.sgml//:S/^/-i chap./}

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

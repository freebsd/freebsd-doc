#
# $FreeBSD$
#
# Μορφοποίηση του Εγχειριδίου του FreeBSD
#
# %SOURCE%	en_US.ISO8859-1/books/handbook/Makefile
# %SRCID%	1.1
#

# ------------------------------------------------------------------------
#
# Μεταβλητές σχετικές με το Εγχειρίδιο
#
#       WITH_PGPKEYS    Η εκτυπώσιμη μορφή του εγχειριδίου περιέχει κανονικά
#                       μόνο τα fingerprints από τα PGP κλειδιά.  Αν θέλετε
#                       να εκτυπώνονται ολόκληρα τα κλειδιά, τότε αυτή η
#                       μεταβλητή πρέπει να είναι 'defined'.  Αυτή η επιλογή
#                       δεν επηρεάζει σε τίποτα τις μορφές HTML.
#
# Make targets μόνο για το Εγχειρίδιο
#
#       pgpkeyring      This target will read the contents of
#                       pgpkeys/chapter.sgml and will extract all of
#                       the pgpkeys to standard out.  This output can then
#                       be redirected into a file and distributed as a 
#                       public keyring of FreeBSD developers that can
#                       easily be imported into PGP/GPG.
#
# ------------------------------------------------------------------------

.PATH: ${.CURDIR}/../../share/sgml/glossary

MAINTAINER=	doc@FreeBSD.org

DOC?=		book

FORMATS?=	html-split

HAS_INDEX=	true
USE_PS2PDF=	yes

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

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
# Η λίστα SRCS περιέχει όλα τα SGML αρχεία που αποτελούν μέρη του κειμένου.
# Αλλαγές σε οποιοδήποτε από αυτά τα αρχεία προκαλούν rebuild.
#

# SGML content
SRCS+= audit/chapter.sgml
SRCS+= book.sgml
SRCS+= colophon.sgml
SRCS+= freebsd-glossary.sgml
SRCS+= advanced-networking/chapter.sgml
SRCS+= basics/chapter.sgml
SRCS+= bibliography/chapter.sgml
SRCS+= boot/chapter.sgml
SRCS+= config/chapter.sgml
SRCS+= cutting-edge/chapter.sgml
SRCS+= desktop/chapter.sgml
SRCS+= disks/chapter.sgml
SRCS+= eresources/chapter.sgml
SRCS+= firewalls/chapter.sgml
SRCS+= geom/chapter.sgml
SRCS+= install/chapter.sgml
SRCS+= introduction/chapter.sgml
SRCS+= jails/chapter.sgml
SRCS+= kernelconfig/chapter.sgml
SRCS+= l10n/chapter.sgml
SRCS+= linuxemu/chapter.sgml
SRCS+= mac/chapter.sgml
SRCS+= mail/chapter.sgml
SRCS+= mirrors/chapter.sgml
SRCS+= multimedia/chapter.sgml
SRCS+= network-servers/chapter.sgml
SRCS+= pgpkeys/chapter.sgml
SRCS+= ports/chapter.sgml
SRCS+= ppp-and-slip/chapter.sgml
SRCS+= preface/preface.sgml
SRCS+= printing/chapter.sgml
SRCS+= security/chapter.sgml
SRCS+= serialcomms/chapter.sgml
SRCS+= users/chapter.sgml
SRCS+= vinum/chapter.sgml
SRCS+= virtualization/chapter.sgml
SRCS+= x11/chapter.sgml

# Entities
SRCS+= chapters.ent

SYMLINKS=	${DESTDIR} index.html handbook.html

# Turn on all the chapters.
CHAPTERS?= ${SRCS:M*chapter.sgml}

SGMLFLAGS+= ${CHAPTERS:S/\/chapter.sgml//:S/^/-i chap./}
SGMLFLAGS+= -i chap.freebsd-glossary

pgpkeyring: pgpkeys/chapter.sgml
	@${JADE} -V nochunks ${OTHERFLAGS} ${JADEOPTS} -d ${DSLPGP} -t sgml ${MASTERDOC}

#
# Handbook-specific variables
#
.if defined(WITH_PGPKEYS)
JADEFLAGS+=	-V withpgpkeys
.endif

URL_RELPREFIX?=	../../../..
DOC_PREFIX?=	${.CURDIR}/../../..

#
# rules generating lists of mirror site from XML database.
#
XMLDOCS=	mirrors-ftp:::mirrors.sgml.ftp.inc.tmp \
		mirrors-cvsup:::mirrors.sgml.cvsup.inc.tmp \
		eresources:::eresources.sgml.www.inc.tmp
DEPENDSET.DEFAULT=	transtable mirror
XSLT.DEFAULT=		${XSL_MIRRORS}
XML.DEFAULT=		${XML_MIRRORS}
NO_TIDY.DEFAULT=	yes

PARAMS.mirrors-ftp+=	--param 'type' "'ftp'" \
			--param 'proto' "'ftp'" \
			--param 'target' "'handbook/mirrors/chapter.sgml'"
PARAMS.mirrors-cvsup+=	--param 'type' "'cvsup'" \
			--param 'proto' "'cvsup'" \
			--param 'target' "'handbook/mirrors/chapter.sgml'"
PARAMS.eresources+=	--param 'type' "'www'" \
			--param 'proto' "'http'" \
			--param 'target' "'handbook/eresources/chapter.sgml'"

SRCS+=		mirrors.sgml.ftp.inc \
		mirrors.sgml.cvsup.inc \
		eresources.sgml.www.inc

CLEANFILES+=	mirrors.sgml.ftp.inc mirrors.sgml.ftp.inc.tmp \
		mirrors.sgml.cvsup.inc mirrors.sgml.cvsup.inc.tmp \
		eresources.sgml.www.inc eresources.sgml.www.inc.tmp

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

.for p in ftp cvsup
mirrors.sgml.${p}.inc: mirrors.sgml.${p}.inc.tmp
	${SED} -e 's,<\([^ >]*\)\([^>]*\)/>,<\1\2></\1>,;s,</anchor>,,'\
	    < $@.tmp > $@ || (${RM} -f $@ && false)
.endfor

eresources.sgml.www.inc: eresources.sgml.www.inc.tmp
	${SED} -e 's,<\([^ >]*\)\([^>]*\)/>,<\1\2></\1>,;s,</anchor>,,'\
	    < $@.tmp > $@ || (${RM} -f $@ && false)

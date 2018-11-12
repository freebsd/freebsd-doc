#
# $FreeBSD$
#
# Crea l'Introduzione a Unix.
#

MAINTAINER= ale@FreeBSD.org

DOC?= book

FORMATS?= html-split

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

#
# SRCS lista i singoli files SGML che compongono il documento. Modifiche
# a qualunque di questi files obbligano la ricreazione
#

# Contenuto SGML
SRCS = book.sgml
SRCS+= bibliography/chapter.sgml
SRCS+= command-summary/chapter.sgml
SRCS+= commands/chapter.sgml
SRCS+= editors/chapter.sgml
SRCS+= getting-started/chapter.sgml
SRCS+= glossary/chapter.sgml
SRCS+= history/chapter.sgml
SRCS+= preface/chapter.sgml
SRCS+= shell-programming/chapter.sgml
SRCS+= shells/chapter.sgml
SRCS+= special-features/chapter.sgml
SRCS+= structure/chapter.sgml
SRCS+= system-resource/chapter.sgml
SRCS+= text-processing/chapter.sgml

# Entities
SRCS+= chapters.ent

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

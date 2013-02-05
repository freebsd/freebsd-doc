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
# SRCS lista i singoli files XML che compongono il documento. Modifiche
# a qualunque di questi files obbligano la ricreazione
#

# Contenuto XML
SRCS = book.xml
SRCS+= bibliography/chapter.xml
SRCS+= command-summary/chapter.xml
SRCS+= commands/chapter.xml
SRCS+= editors/chapter.xml
SRCS+= getting-started/chapter.xml
SRCS+= glossary/chapter.xml
SRCS+= history/chapter.xml
SRCS+= preface/chapter.xml
SRCS+= shell-programming/chapter.xml
SRCS+= shells/chapter.xml
SRCS+= special-features/chapter.xml
SRCS+= structure/chapter.xml
SRCS+= system-resource/chapter.xml
SRCS+= text-processing/chapter.xml

# Entities
SRCS+= chapters.ent

DOC_PREFIX?= ${.CURDIR}/../../..

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

#
# $FreeBSD$
#
# Build the FreeBSD Chinese FAQ
#

MAINTAINER=vanilla@FreeBSD.org ijliao@FreeBSD.org clive@FreeBSD.org \
	   clsung@FreeBSD.org chinsan@FreeBSD.org

DOC?= book

FORMATS?= html-split html

INSTALL_COMPRESSED?= gz
INSTALL_ONLY_COMPRESSED?=

WITH_BIBLIOXREF_TITLE?=YES
#
# SRCS lists the individual XML files that make up the document. Changes
# to any of these files will force a rebuild
#

# XML content
SRCS=  book.xml

DOC_PREFIX?= ${.CURDIR}/../../..
.include "${DOC_PREFIX}/share/mk/doc.project.mk"

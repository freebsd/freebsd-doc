#
# $FreeBSD: doc/share/mk/doc.project.mk,v 1.7 2000/10/08 19:16:32 nik Exp $
#
# This include file <doc.project.mk> is the FreeBSD Documentation Project 
# co-ordination make file.
#
# This file includes the other makefiles, which contain enough
# knowledge to perform their duties without the system make files.
#

# ------------------------------------------------------------------------
#
# Document-specific variables:
#
#	DOC		This _must_ be set if there is a document to
#			build.  It should be without prefix.
#
#	DOCFORMAT	Format of the document.  Defaults to docbook.
#			docbook is also the only option currently.
#
# 	MAINTAINER	This denotes who is responsible for maintaining
# 			this section of the project.  If unset, set to
# 			doc@FreeBSD.org
#

# ------------------------------------------------------------------------
#
# User-modifiable variables:
#
#	PREFIX		Standard path to document-building applications
#			installed to serve the documentation build
#			process, usually by installing the docproj port
#			or package.  Default is ${LOCALBASE} or /usr/local
#
#	NOINCLUDEMK	Whether to include the standard BSD make files,
#			or just to emulate them poorly.  Set this if you
#			aren't on FreeBSD, or a compatible sibling.  By
#			default is not set.
#

# ------------------------------------------------------------------------
#
# Make files included:
#
#	doc.install.mk	Installation specific information, including
#			ownership and permissions.
#
#	doc.subdir.mk	Subdirectory related configuration, including
#			handling "obj" builds.
#
# DOCFORMAT-specific make files, like:
#
#	doc.docbook.mk	Building and installing docbook documentation.
#			Currently the only method.
#

# Document-specific defaults
DOCFORMAT?=	docbook
MAINTAINER?=	doc@FreeBSD.org

# Master list of known target formats.  The doc.<format>.mk files implement 
# the code to convert from their source format to one or more of these target
# formats
ALL_FORMATS=	html html.tar html-split html-split.tar txt rtf ps pdf tex dvi tar pdb

# User-modifiable
LOCALBASE?=	/usr/local
PREFIX?=	${LOCALBASE}
PRI_LANG?=	en_US.ISO_8859-1

# Image processing (contains code used by the doc.<format>.mk files, so must
# be listed first).
.include "doc.images.mk"

# Format-specific configuration
.if defined(DOC)
.if ${DOCFORMAT} == "docbook"
.include "doc.docbook.mk"
.endif
.if ${DOCFORMAT} == "html"
.include "doc.html.mk"
.endif
.endif

# Subdirectory glue and ownership information.
.include "doc.subdir.mk"
.include "doc.install.mk"


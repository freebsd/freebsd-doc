#
# $FreeBSD$
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
# 	doc.common.mk	targets and variables commonly used in doc/ and
#			www/ tree.
#
# DOCFORMAT-specific make files, like:
#
#	doc.docbook.mk	Building and installing docbook documentation.
#			Currently the only method.
#

# 'make obj' doesn't really work for the docs, disable it
#NO_OBJ?= YES

# Document-specific defaults
DOCFORMAT?=	docbook
MAINTAINER?=	doc@FreeBSD.org

# Master list of known target formats.  The doc.<format>.mk files implement
# the code to convert from their source format to one or more of these target
# formats
ALL_FORMATS=	html html.tar html-split html-split.tar txt rtf pdf tex dvi tar

.include "doc.commands.mk"

# User-modifiable
LOCALBASE?=	/usr/local
PREFIX?=	${LOCALBASE}
PRI_LANG?=	en_US.ISO8859-1

# Image processing (contains code used by the doc.<format>.mk files, so must
# be listed first).
.include "doc.images.mk"

# targets and variables commonly used in doc/ and www/ tree.
.include "doc.common.mk"

DOC_LOCAL_MK=	${DOC_PREFIX}/${LANGCODE}/share/mk/doc.local.mk

.if exists(${DOC_LOCAL_MK})
.include "${DOC_LOCAL_MK}"
.endif

# Ownership information.
.include "doc.install.mk"

# XML specific configuration
.include "doc.xml.mk"

# Format-specific configuration
.if defined(DOC)
.if ${DOCFORMAT} == "docbook"
.include "doc.docbook.mk"

.if !defined(DOCBOOK_DEPS_DISABLE) || ${DOCBOOK_DEPS_DISABLE} != "YES"
.include "doc.docbook-dep.mk"
.endif

.endif
.if ${DOCFORMAT} == "slides"
.include "doc.slides.mk"
.endif
.endif

# Subdirectory glue.
.include "doc.subdir.mk"

#
# parallel build for target "all" and "clean"
#
# by default we are using all available CPUs. You can override 
# this on the command line with `make -j<number> p-all' or with the
# variable `make NCPU=<number> p-all'
#
NCPU?= ${.MAKE.JOBS:U${:!/sbin/sysctl -n hw.ncpu!}}

p-all p-clean p-po:
	make -V SUBDIR | sed -E 's/[ ]+$$//' | tr " " "\n" | \
		sed -E 's/^/make -C /; s/$$/ ${.TARGET:S/^p-//}/' | \
		tr '\n' '\0' | xargs -0 -n1 -P${NCPU} /bin/sh -c


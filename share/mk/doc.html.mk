#
# $FreeBSD: doc/share/mk/doc.html.mk,v 1.6 2001/03/13 18:29:06 nik Exp $
#
# This include file <doc.html.mk> handles building and installing of
# HTML documentation in the FreeBSD Documentation Project.
#
# Documentation using DOCFORMAT=html is expected to be marked up
# according to the HTML DTD
#

# ------------------------------------------------------------------------
#
# Document-specific variables
#
#	DOC		This should be set to the name of the HTML
#			marked-up file, without the .sgml or .docb suffix.
#			
#			It also determins the name of the output files -
#			${DOC}.html.
#
#	DOCBOOKSUFFIX	The suffix of your document, defaulting to .sgml
#
#	SRCS		The names of all the files that are needed to
#			build this document - This is useful if any of
#			them need to be generated.  Changing any file in
#			SRCS causes the documents to be rebuilt.
#

# ------------------------------------------------------------------------
#
# Variables used by both users and documents:
#
#	TIDYFLAGS	Additional flags to pass to Tidy.  Typically
#			used to set "-raw" flag to handle 8bit characters.
#
#	EXTRA_CATALOGS	Additional catalog files that should be used by
#			any SGML processing applications.
#
#	NO_TIDY		If you do not want to use tidy, set this to "YES".
#
# Documents should use the += format to access these.
#

MASTERDOC?=	${.CURDIR}/${DOC}.sgml

KNOWN_FORMATS=	html txt tar pdb

HTMLCATALOG=	${PREFIX}/share/sgml/html/catalog

.if ${MACHINE_ARCH} == "alpha"
OPENJADE=	yes
.endif

.if defined(OPENJADE)
NSGMLS?=	onsgmls
SGMLNORM?=	osgmlnorm
.else
NSGMLS?=	nsgmls
SGMLNORM?=	sgmlnorm
.endif

# ------------------------------------------------------------------------
#

.for _curformat in ${FORMATS}
_cf=${_curformat}
.if ${_cf} == "html"
_docs+= ${DOC}.html
CLEANFILES+= ${DOC}.html
.elif ${_cf} == "txt"
_docs+= ${DOC}.txt
CLEANFILES+= ${DOC}.html ${DOC}.txt
.elif ${_cf} == "tar"
_docs+= ${DOC}.tar
.elif ${_cf} == "pdb"
_docs+= ${DOC}.pdb ${.CURDIR:T}.pdb
+CLEANFILES+= ${DOC}.pdb ${.CURDIR:T}.pdb
.else
# Create a 'bogus' doc for any other format we don't support.  This is so
# that we can fake up a target for it later on, and this target can print
# the warning message about the unsupported format. 
_docs+= ${DOC}.${_curformat}
.endif
.endfor

#
# Build a list of install-${format}.${compress_format} targets to be
# by "make install". Also, add ${DOC}.${format}.${compress_format} to
# ${_docs} and ${CLEANFILES} so they get built/cleaned by "all" and
# "clean".
#

.if defined(INSTALL_COMPRESSED) && !empty(INSTALL_COMPRESSED)
.for _curformat in ${FORMATS}
_cf=${_curformat}
.for _curcomp in ${INSTALL_COMPRESSED}
.if ${_cf} != "html-split"
_curinst+= install-${_curformat}.${_curcomp}
_docs+= ${DOC}.${_curformat}.${_curcomp}
CLEANFILES+= ${DOC}.${_curformat}.${_curcomp}
.endif
.endfor
.endfor
.endif

.MAIN: all

all: ${_docs}

${DOC}.html: ${SRCS}
	${SGMLNORM} -c ${HTMLCATALOG} ${.ALLSRC} > ${.TARGET}
.if !defined(NO_TIDY)
	-tidy -i -m -f /dev/null ${TIDYFLAGS} ${.TARGET}
.endif

${DOC}.txt: ${DOC}.html
	links -dump ${.ALLSRC} > ${.TARGET}

${DOC}.pdb: ${DOC}.html
	iSiloBSD -y -d0 -Idef ${DOC}.html ${DOC}.pdb

${.CURDIR:T}.pdb: ${DOC}.pdb
	ln -f ${DOC}.pdb ${.CURDIR}.pdb

${DOC}.tar: ${SRCS}
	tar cf ${.TARGET} ${.ALLSRC}

#
# Build targets for any formats we've missed that we don't handle.
#
.for _curformat in ${ALL_FORMATS}
.if !target(${DOC}.${_curformat})
${DOC}.${_curformat}:
	@echo \"${_curformat}\" is not a valid output format for this document.
.endif
.endfor

# ------------------------------------------------------------------------
#
# Validation targets
#

#
# Lets you quickly check that the document conforms to the DTD without
# having to convert it to any other formats
#

lint validate:
	${NSGMLS} -s -c ${HTMLCATALOG} ${MASTERDOC}

# ------------------------------------------------------------------------
#
# Compress targets
#

#
# The list of compression extensions this Makefile knows about. If you
# add new compression schemes, add to this list (which is a list of
# extensions, hence bz2, *not* bzip2) and extend the _PROG_COMPRESS_*
# targets.
#

KNOWN_COMPRESS=	gz bz2 zip

#
# You can't build suffix rules to do compression, since you can't
# wildcard the source suffix. So these are defined .USE, to be tacked on
# as dependencies of the compress-* targets.
#

_PROG_COMPRESS_gz: .USE
	gzip -9 -c ${.ALLSRC} > ${.TARGET}

_PROG_COMPRESS_bz2: .USE
	bzip2 -9 -c ${.ALLSRC} > ${.TARGET}

_PROG_COMPRESS_zip: .USE
	zip -j -9 ${.TARGET} ${.ALLSRC}

#
# Build a list of targets for each compression scheme and output format.
# Don't compress the html-split output format.
#
.for _curformat in ${KNOWN_FORMATS}
_cf=${_curformat}
.for _curcompress in ${KNOWN_COMPRESS}
${DOC}.${_cf}.${_curcompress}: ${DOC}.${_cf} _PROG_COMPRESS_${_curcompress}
.endfor
.endfor

#
# Build targets for any formats we've missed that we don't handle.
#
.for _curformat in ${ALL_FORMATS}
.for _curcompress in ${KNOWN_COMPRESS}
.if !target(${DOC}.${_curformat}.${_curcompress})
${DOC}.${_curformat}.${_curcompress}:
	@echo \"${_curformat}.${_curcompress}\" is not a valid output format for this document.
.endif
.endfor
.endfor


# ------------------------------------------------------------------------
#
# Install targets
#
# Build install-* targets, one per allowed value in FORMATS.
#
# "beforeinstall" and "afterinstall" are hooks in to this process.
# Redefine them to do things before and after the files are installed,
# respectively.

#
# Build a list of install-format targets to be installed. These will be
# dependencies for the "realinstall" target.
#

.if !defined(INSTALL_ONLY_COMPRESSED) || empty(INSTALL_ONLY_COMPRESSED)
_curinst+= ${FORMATS:S/^/install-/g}
.endif

realinstall: ${_curinst}

.for _curformat in ${KNOWN_FORMATS}
_cf=${_curformat}
.if !target(install-${_cf})
install-${_cf}: ${DOC}.${_cf}
	@[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	${INSTALL_DOCS} ${.ALLSRC} ${DESTDIR}

.for _compressext in ${KNOWN_COMPRESS}
install-${_cf}.${_compressext}: ${DOC}.${_cf}.${_compressext}
	@[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	${INSTALL_DOCS} ${.ALLSRC} ${DESTDIR}
.endfor
.endif
.endfor

#
# Build install- targets for any formats we've missed that we don't handle.
#

.for _curformat in ${ALL_FORMATS}
.if !target(install-${_curformat})
install-${_curformat}:
	@echo \"${_curformat}\" is not a valid output format for this document.

.for _compressext in ${KNOWN_COMPRESS}
install-${_curformat}.${_compressext}:
	@echo \"${_curformat}.${_compressext}\" is not a valid output format for this document.
.endfor
.endif
.endfor

# ------------------------------------------------------------------------
#
# Package building
#

#
# realpackage is what is called in each subdirectory when a package
# target is called, or, rather, package calls realpackage in each
# subdirectory as it goes.
#
# packagelist returns the list of targets that would be called during
# package building.
#

realpackage: ${FORMATS:S/^/package-/}
packagelist:
	@echo ${FORMATS:S/^/package-/}

#
# Build a list of package targets for each output target.  Each package
# target depends on the corresponding install target running.
#

.for _curformat in ${KNOWN_FORMATS}
_cf=${_curformat}
package-${_curformat}: install-${_curformat}
	@echo ${DOC}.${_curformat} > PLIST
	@pkg_create -v -c -"FDP ${.CURDIR:T} ${_curformat} package" \
		-d -"FDP ${.CURDIR:T} ${_curformat} package" -f PLIST \
		-p ${DESTDIR} ${PACKAGES}/${.CURDIR:T}.${LANGCODE}.${_curformat}.tgz
.endfor

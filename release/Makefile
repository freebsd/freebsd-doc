# $FreeBSD$
#
# Documentation release building.  These are used to create
# distributions of the documentation files only.  These recipes are
# intended to mimic src/release/Makefile; the principal difference is
# that much of the complexity brought about by the chroot environment
# is unneeded.
#
DOC_PREFIX?=	${.CURDIR}/..

MKISOFS?=	mkisofs
TAR?=		/usr/bin/tar
TOUCH?=		/usr/bin/touch

#
# Targets:
#
# release	Create a clean build of the documentation files,
#		obeying the usual specifications such as FORMATS=,
#		DOC_LANG=, etc.
#
# rerelease	Similar to release, except that existing documentation
#		renderings are preserved and installed.
#
# Configuration variables:
#
# BUILDNAME	Identification string to be placed in BUILDNAME file
#		in the top directory of the release.
#
# DOCROOTDIR	Top directory to use for document release building.
#		This directory need not exist, and will be created
#		if necessary.  This variable MUST be defined.
#
# MAKE_ISOS	If defined, this will enable creation of an ISO image
#		from the document release.  Creation of ISO images
#		requires a mkisofs binary in the invoking user's path.
#
DATE!=		date +%Y%m%d
BUILDNAME?=	${DATE}

#
# Set defaults for FORMATS and DOC_LANG.  To preserve POLA, these
# should be reflect the defaults.
#
FORMATS?=	html
DOC_LANG?=	en_US.ISO8859-1

#
# Miscellaneous but mandatory options for the build get set here.
# The Japanese translation team has a set of manual pages; we turn
# these off (at least for now) because we have not worked their
# install target into our scheme.
#
MISCOPTIONS+=	NO_JPMAN=yes

DOCSTAGEDIR=	${DOCROOTDIR}/doc
DOCBUILDFILE=	${DOCROOTDIR}/doc/BUILD.TXT

rerelease release:
.if !defined(DOCROOTDIR)
	@${ECHO} "To make a release you must define DOCROOTDIR" && false
.endif
	@${ECHO} ">>> make ${.TARGET} started on `LC_ALL=C TZ=GMT date`"
# If we're doing a release (from scratch), clean out DOCROOTDIR
# (this is the equivalent of CHROOTDIR for src/release).
.if make(release)
	${RM} -rf ${DOCROOTDIR}
	${MKDIR} ${DOCROOTDIR}
	${MKDIR} ${DOCROOTDIR}/obj
	find ${DOC_PREFIX} -type d -a \! -name CVS | sed -e s,^,${DOCROOTDIR}/obj, | xargs ${MKDIR}
	${MKDIR} ${DOCSTAGEDIR}
.endif
# Build documents in the obj area and install them to our staging area.
# We do this so as to avoid interference with any built documents that
# happen to be sitting under ${DOC_PREFIX}, which might be built with
# different options, etc.
	cd ${DOC_PREFIX} && env MAKEOBJDIRPREFIX=${DOCROOTDIR}/obj ${MAKE} all install DOCDIR=${DOCSTAGEDIR} ${MISCOPTIONS}
# Copy any files in our texts/ directory to the staging area.
	${TAR} --exclude CVS -cf - -C ${.CURDIR}/texts . | \
		${TAR} xf - -C ${DOCSTAGEDIR}
# Construct the BUILD.TXT file with the documentation build info.
	${RM} -f ${DOCBUILDFILE}
	${TOUCH} ${DOCBUILDFILE}
	${ECHO} "FreeBSD Documentation ${BUILDNAME}" >> ${DOCBUILDFILE}
	${ECHO} "Generated on:	`LC_ALL=C TZ=GMT date`" >> ${DOCBUILDFILE}
	${ECHO} "Formats:	${FORMATS}" >> ${DOCBUILDFILE}
	${ECHO} "Languages:	${DOC_LANG}" >> ${DOCBUILDFILE}
# Make ISO images if desired.
.if defined(MAKE_ISOS)
	cd ${DOCROOTDIR} && ${MKISOFS} -r -J -V fbsd_doc -o doc.iso ${DOCSTAGEDIR}
.endif
	@${ECHO} ">>> make ${.TARGET} finished on `LC_ALL=C TZ=GMT date`"

.include "${DOC_PREFIX}/share/mk/doc.project.mk"

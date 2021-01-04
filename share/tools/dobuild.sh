#!/bin/sh
# Copyright (c) 2001 Wolfram Schneider <wosch@FreeBSD.org>
# Copyright (c) 2001 Dima Dorfman <dd@FreeBSD.org>
# Copyright (c) 2004 Simon L. Nielsen <simon@FreeBSD.org>
#
# Build the FreeBSD docs from the Git repository.
#
#
# Major variables:
#
#	PATH		- The search path as interpreted by the shell.
#	DOCGIT		- Url to the FreeBSD doc Git repository.
#	BUILDDIR	- Where the checked out copies of the files are stored.
#	DESTDIR		- Where the rendered copies should wind up.
#	BUILDARGS	- Arguments to pass to make(1) when {build,install}ing.
#	INSTARGS	- Arguments to pass to make(1) when installing.
#	WEBMAILTO	- Address to send mail to if the build fails.
#
#	subtrees	- List of directores in $BUILDDIR which are from SCM.
#
# Variables which are in uppercase are derived from the environment
# unless they don't exist, in which case a value suitable for
# www.FreeBSD.org is used.  Variables in lowercase can't be safely
# changed without editing other parts of the script; thus, their value
# in the environment is ignored.
#
# Exit codes:
#
#	0	- success
#	1	- unknown failure
#	2	- failure in Git operations
#	3	- failure in make operations
#

#
# NOTE: This script is not automatically updated on the builder.
#

# WARNING!  This script depend on dobuild_wrap.sh setting the
# configuration variables in the enviroment.
#
if [ -f "${PWD}/local.conf" ]; then
	. ${PWD}/local.conf
fi

if [ -z "${DOBUILDWRAP}" ]; then
	echo "Error: This script should only be called from dobuild_wrap.sh!"
	exit 1
fi

# Only install some compression types
INSTALL_COMPRESSED=${COMPTYPES}; export INSTALL_COMPRESSED

# Abort on all errors
set -e

umask 002
cd $BUILDDIR || exit 1

# Remove the old copies.
if [ -z "${NOCLEAN}" ]; then
	echo "===> Removing old stuff"
	rm -Rf doc out 2>/dev/null || true
	chflags -R noschg doc out 2>/dev/null || true
	rm -Rf doc out 2>/dev/null

	echo "===> Check out the new doc"
	git clone ${GITARGS} -b main ${DOCGIT} doc || exit 2
fi

cd $BUILDDIR/doc || exit 1
mkdir -p $DOCDIR
mkdir -p $DOCDIR/packages
rm -f ${BUILDDIR}/packages # TMP
ln -s ${DOCDIR}/packages ${BUILDDIR}/doc/packages

if [ -d ${PATCHDIR} -a -n "$(find ${PATCHDIR} -name \*.patch)" ]; then
	echo "===> Patching bugs in doc tree"
	for p in `echo ${PATCHDIR}/*.patch`; do
		patch < ${p}
	done
fi

echo "===> Building doc"
time make ${BUILDARGS} all || exit 3

echo "===> Installing doc package to temp roots"
time make ${INSTARGS} install || exit 3

#echo "===> Building doc packages"
#time make ${BUILDARGS} package || exit 3

# XXX TODO, check for correct string when tex run out of resources
#echo "===> Testing for broken tex output"
#grep 'hash' $LOGFILE > /dev/null && \
#    (echo "Error: Possible TeX out of resources."; false)

#OKFILENAME

# build a string to use with find(1) to identify
# uncompressed files to be copied
UNCOMP_FIND_STR=""
for fmt in ${UNCOMPRESSED_FORMATS}; do
  UNCOMP_FIND_STR="${UNCOMP_FIND_STR}( -name article.${fmt} -or -name book.${fmt} ) -or "
done
# add outer parens, remove the final "-or "
UNCOMP_FIND_STR="( ${UNCOMP_FIND_STR%-or } )"

if [ -n "${UNCOMP_FIND_STR}" ]; then
  echo "copying uncompressed formats: ${UNCOMPRESSED_FORMATS}"
  cd ${BUILDDIR}/doc
  find -X ??_* ${UNCOMP_FIND_STR} -print0 \
  | xargs -0 -I % install -v -C -o docbuild -g docbuild -m 444 % ${DOCDIR}/%
fi

rm -rf ${OUTDIR}/*
mkdir -p ${OUTDIR}
cp -Rp ${DOCDIR}/* ${OUTDIR}

exit 0

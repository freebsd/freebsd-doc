#!/bin/sh
#
# Copyright (c) 2004 Simon L. Nielsen <simon@FreeBSD.org>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#

#
# Wrapper around doc build.  Simplifies main build script.
# NOTE: This script is not automatically updated on the builder.

if [ -f "${PWD}/local.conf" ]; then
	. ${PWD}/local.conf
fi

#
# Default configuration.
#
DEFAULT_PATH=/bin:/usr/bin:/usr/local/bin
DEFAULT_BUILDROOT=/local0/docbuild
DEFAULT_DOCGIT="https://git.freebsd.org/doc.git"
DEFAULT_BUILDARGS="NO_JPMAN=yes GEN_INDEX=yes"
DEFAULT_INSTARGS="NO_JPMAN=yes GEN_INDEX=yes INSTALL_ONLY_COMPRESSED=yes"
# Must keep space between addresses.
DEFAULT_WEBMAILTO="doceng@FreeBSD.org, wblock@wonkity.com"
#DEFAULT_FORMATS="html html.tar html-split html-split.tar txt ps pdf rtf pdb"
#DEFAULT_FORMATS="html html.tar html-split html-split.tar txt ps pdf epub"
DEFAULT_FORMATS="html html.tar html-split html-split.tar txt pdf epub"
DEFAULT_UNCOMPRESSED_FORMATS="pdf epub"
DEFAULT_COMPTYPES="bz2 zip"

#
# Variable setup.
#
BUILDROOT=${BUILDROOT:-${DEFAULT_BUILDROOT}}; export BUILDROOT
PATH="${PATH}:${DEFAULT_PATH}"; export PATH
DOCGIT=${DOCGIT:-${DEFAULT_DOCGIT}}; export DOCGIT
BUILDDIR=${BUILDDIR:-${BUILDROOT}/build}; export BUILDDIR
DOCDIR=${DOCDIR:-${BUILDROOT}/build/out}; export DOCDIR
FORMATS=${FORMATS:-${DEFAULT_FORMATS}}; export FORMATS
UNCOMPRESSED_FORMATS=${UNCOMPRESSED_FORMATS:-${DEFAULT_UNCOMPRESSED_FORMATS}}; export UNCOMPRESSED_FORMATS
COMPTYPES=${COMPTYPES:-${DEFAULT_COMPTYPES}}; export COMPTYPES
BUILDARGS=${BUILDARGS:-${DEFAULT_BUILDARGS}}; export BUILDARGS
INSTARGS=${INSTARGS:-${DEFAULT_INSTARGS}}; export INSTARGS
WEBMAILTO=${WEBMAILTO:-${DEFAULT_WEBMAILTO}}; export WEBMAILTO
PATCHDIR=${PATCHDIR:-${BUILDROOT}/patches}; export PATCHDIR
OUTDIR=${OUTDIR:-${BUILDROOT}/docout}; export OUTDIR
LOGROOT=${LOGBUILDROOT:-${BUILDROOT}/logs}; export LOGROOT
LOGDIR=${LOGROOT}/$(date +%Y%m%d%H%M%S); export LOGDIR
LOGFILE=${LOGDIR}/buildlog; export LOGFILE
LOCKFILE=${LOCKFILE:-${BUILDROOT}/lock}; export LOCKFILE
STATUSFILE=${LOGDIR}/status.xml; export STATUSFILE
BUILDSFILE=${LOGROOT}/builds.xml; export BUILDSFILE

DOBUILDWRAP="yes"; export DOBUILDWRAP

# Run the actual script inside a lock so only one instance can run at
# the time.
lockf -t 0 ${LOCKFILE} /bin/sh << 'E*O*F'
	if [ ! -d ${LOGDIR} ]; then
		mkdir -p ${LOGDIR}
	fi
	LOGFILE_REL=${LOGFILE##${LOGROOT}/}
	echo "<build>"						 > ${STATUSFILE}
	echo " <buildhost>$(hostname)</buildhost>"		>> ${STATUSFILE}
	echo " <starttime>$(date +%Y%m%d%H%M%S)</starttime>"	>> ${STATUSFILE}
	echo " <logfile>${LOGFILE_REL}</logfile>"		>> ${STATUSFILE}
	echo " <status>running</status>"			>> ${STATUSFILE}
	echo "</build>"						>> ${STATUSFILE}

	echo '<builds>'						 > ${BUILDSFILE}
	find ${LOGROOT} -name status.xml | xargs cat		>> ${BUILDSFILE}
	echo '</builds>'					>> ${BUILDSFILE}

	# Do the actual build.
	starttime=$(date +%s)
	sh -x ${BUILDROOT}/dobuild.sh > ${LOGFILE} 2>&1
	ret=$?
	touch ${LOGFILE}
	endtime=$(date +%s)
	runtime=$((${endtime} - ${starttime}))

	# Remove the status and "footer" of ${STATUSFILE}.
	keeplines=$(($(wc -l < ${STATUSFILE}) - 2))
	mv ${STATUSFILE} ${STATUSFILE}.tmp
	head -n ${keeplines} ${STATUSFILE}.tmp > ${STATUSFILE}
	rm -f ${STATUSFILE}.tmp

	echo " <endtime>$(date +%Y%m%d%H%M%S)</endtime>"	>> ${STATUSFILE}
	echo " <runtime>${runtime}</runtime>"			>> ${STATUSFILE}
	echo " <retcode>${ret}</retcode>"			>> ${STATUSFILE}
	if [ ${ret} -eq 0 ]; then
		echo " <status>completed</status>"		>> ${STATUSFILE}
	else
		echo " <status>failed</status>"			>> ${STATUSFILE}
	fi

	if [ ${ret} -ne 0 ]; then
		tail -100 ${LOGFILE} | \
			mail -s "FreeBSD FTP doc build failed" ${WEBMAILTO}
	fi

	if egrep '^! TeX capacity exceeded' ${LOGFILE} > /dev/null; then
		egrep '^! TeX capacity exceeded' ${LOGFILE} | \
			mail -s "FreeBSD FTP doc build warning" ${WEBMAILTO}
		echo " <warning>Possibly out of TeX resources.</warning>" \
			>> ${STATUSFILE}
	fi
	echo "</build>"						>> ${STATUSFILE}

	echo '<builds>'						 > ${BUILDSFILE}
	find ${LOGROOT} -name status.xml | xargs cat		>> ${BUILDSFILE}
	echo '</builds>'					>> ${BUILDSFILE}
E*O*F


exit 0

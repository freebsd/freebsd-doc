#!/bin/sh
#
# Copyright (c) 2021 Fernando Apesteguia <fernape@FreeBSD.org>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Check for aspell. Everything else is in base.
COMMAND=msgexec
if ! command -v ${COMMAND} >/dev/null; then
	echo "${COMMAND} not found, please run 'pkg install docproj'"
	exit 1
fi

usage()
{
	echo "${0} <path_to_po_file> <language>"
	echo "Example: ${0} documentation/content/es/articles/bsdl-gpl/_index.po es"
}

if [ ${#} -ne 2 ]; then
	usage
	exit 1
fi

PO_FILE="${1}"
LANG="${2}"

# msgexec acts as a driver, invoking a command for every
# translated text

CURDIR=$(dirname "${0}")
msgexec -i "${PO_FILE}" "${CURDIR}"/po_check_entry.sh "${LANG}"

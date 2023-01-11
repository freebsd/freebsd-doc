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
COMMAND=aspell
if ! command -v ${COMMAND} >/dev/null; then
	echo "${COMMAND} not found, please run 'pkg install aspell $your_lang-aspell'"
	exit 1
fi

LANG="${1}"

if [ -z "${LANG}" ]; then
	echo "No language specified"
	exit 1
fi

translation=$(cat /dev/stdin)

# Build a grep(1) filter with all the words aspell(1) could not find in this
# translated text.

filter=
for word in $(echo "${translation}" | aspell list --lang="${LANG}");do
	tmp=$(printf "%s" "${word}|")
	filter="${filter}${tmp}"
done

filter=$(echo "${filter}" | sed -e 's/|$//g')

# Highlight the translation in the text providing the user with some context about
# where the reported words are used.
if [ -n "${filter}" ]; then
	echo "----------- translation -----------" 
	echo "${translation}" | grep -Ew --color "${filter}" 
	echo
fi

#!/bin/sh
#
# Copyright (c) 2021 Danilo G. Baio <dbaio@FreeBSD.org>
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


if [ "$1" = "" ] || [ "$2" = "" ]; then
	echo "Need to inform which component and|or language."
	echo "$0 documentation|website pt_BR|es"
	exit 1
fi

COMPONENT="$1"
LANGUAGE="$2"

# po4a-translate option: -k, --keep
#   Minimal threshold for translation percentage to keep (i.e. write)
#   the resulting file (default: 80). I.e. by default, files have to be
#   translated at least at 80% to get written.
#   # KEEP_ENV=10 ./tools/translate.sh documentation pt_BR
KEEP="${KEEP_ENV:-80}"

if [ "$LANGUAGE" = "en" ]; then
	echo "Language 'en' can't be translated."
	exit 1
fi

if [ ! -d "$COMPONENT/content/$LANGUAGE" ]; then
	echo "$COMPONENT/content/$LANGUAGE does not exist."
	exit 1
fi

for pofile in $(find "$COMPONENT/content/$LANGUAGE/" -name "*.po" ); do
	name=$(basename -s .po "$pofile")
	if [ "$name" = "chapters-order" ]; then
		continue
	fi

	dirbase=$(dirname "$pofile")
	adoc_lang="$dirbase/$name.adoc"
	adoc_orig=$(echo "$adoc_lang" | sed s,$COMPONENT/content/$LANGUAGE,$COMPONENT/content/en,)

	echo "....."
	echo "$pofile"

	po4a-translate \
		--format asciidoc \
		--option compat=asciidoctor \
		--option yfm_keys=title,part,description \
		--master "$adoc_orig" \
		--master-charset "UTF-8" \
		--po "$pofile" \
		--localized "$adoc_lang" \
		--localized-charset "UTF-8" \
		--keep "$KEEP"

done


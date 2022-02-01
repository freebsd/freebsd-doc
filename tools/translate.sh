#!/bin/sh
#
# Copyright (c) 2021 Danilo G. Baio <dbaio@FreeBSD.org>
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

#########################################################
# This is a temporary fix for po4a-translate command	#
# po4a: Fix YAML Front Matter / tags and trademarks	#
# https://wiki.freebsd.org/Doc/IdeaList#Translation	#
# $1: File to fix					#
#########################################################
fixup_lists()
{
	sed -i '' -E -e "s/(tags|trademarks).*'\[(.*)]'/\1: [\2]/g" "${1}"
}

#########################################################
# Fix includes. In a few cases we want to include the	#
# master (aka English) version of the includes		#
# $1: file to fix					#
# $2: language						#
#########################################################
fixup_includes()
{
	# Replace ...shared/en/... with shared/$LANGUAGE
	# content/en with content/$LANGUAGE in includes
	sed -i '' -E -e "s,include::(.*)shared/en/,include::\1shared/${2}/," \
		-e "s,\{include-path\}(contrib*),content/en/articles/contributors/\1," \
		-e "s,include-path: content/en/,include-path: content/${2}/," \
		-e "s,(include::.*)contrib-develinmemoriam(.*),include::{include-path}contrib-develinmemoriam\2," \
		-e "s,(:chapters-path: |include::)content/en/books,\1content/${2}/books," \
		"${1}"
}

if [ "$1" = "" ] || [ "$2" = "" ]; then
	echo "Need to inform component and language:"
	echo "  $0 documentation es"
	echo "A third (optional) argument can be informed to translate only a specific document:"
	echo "  $0 documentation pt-br articles/bsdl-gpl"
	exit 1
fi

COMPONENT="$1"
LANGUAGE="$2"
SEARCH_RESTRICT="$3"

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

for pofile in $(find "$COMPONENT/content/$LANGUAGE/$SEARCH_RESTRICT" -name "*.po"); do
	name=$(basename -s .po "$pofile")
	if [ "$name" = "chapters-order" ]; then
		continue
	fi

	dirbase=$(dirname "$pofile")
	adoc_lang="$dirbase/$name.adoc"
	adoc_orig=$(echo "$adoc_lang" | sed s,$COMPONENT/content/$LANGUAGE,$COMPONENT/content/en,)

	echo "....."
	echo "$pofile"

	po4a-updatepo \
		--format asciidoc \
		--option compat=asciidoctor \
		--option tablecells=1 \
		--option yfm_keys=title,part,description \
		--master "$adoc_orig" \
		--master-charset "UTF-8" \
		--copyright-holder "The FreeBSD Project" \
		--package-name "FreeBSD Documentation" \
		--po "$pofile"
	if [ -f "${pofile}~" ]; then
		rm -f "${pofile}~"
	fi

	po4a-translate \
		--format asciidoc \
		--option compat=asciidoctor \
		--option tablecells=1 \
		--option yfm_keys=title,part,description \
		--master "$adoc_orig" \
		--master-charset "UTF-8" \
		--po "$pofile" \
		--localized "$adoc_lang" \
		--localized-charset "UTF-8" \
		--keep "$KEEP"

	fixup_lists "${adoc_lang}"
	fixup_includes "${adoc_lang}" "${LANGUAGE}"
done


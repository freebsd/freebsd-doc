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


ALL_COMPONENTS="documentation
website"

COMPONENTS="${1:-$ALL_COMPONENTS}"

GIT_IGNORE_FILES="toc-examples.adoc
toc-figures.adoc
toc-tables.adoc
toc.adoc
toc-1.adoc
toc-2.adoc
toc-3.adoc
toc-4.adoc
toc-5.adoc"

IGNORE_FILES="contrib-386bsd
contrib-additional
contrib-committers
contrib-corealumni
contrib-develalumni
contrib-portmgralumni"

for remove_file in $GIT_IGNORE_FILES; do
	find documentation/content/en/ -name "$remove_file" -delete -print || exit 1
done

for component in $COMPONENTS; do

	if [ ! -d "$component/content/en" ]; then
		echo "Directory '$component/content/en' not found."
		exit 1
	fi

	for document in $(find "$component/content/en/" -name "*.adoc" ); do
		name=$(basename -s .adoc "$document")

		# Ignore some files
		if [ "$name" = "chapters-order" ]; then
			continue
		fi

		if [ "$document" = "documentation/content/en/books/books.adoc" ]; then
			continue
		fi

		if echo "$IGNORE_FILES" | grep -q -w "$name"; then
			continue
		fi

		dirbase=$(dirname "$document")
		echo "$document"

		po4a-updatepo \
			--format asciidoc \
			--option compat=asciidoctor \
			--option tablecells=1 \
			--option yfm_keys=title,part,description \
			--master "$document" \
			--master-charset "UTF-8" \
			--copyright-holder "The FreeBSD Project" \
			--package-name "FreeBSD Documentation" \
			--po "$dirbase/$name.po"
		if [ -f "$dirbase/$name.po~" ]; then
			rm -f "$dirbase/$name.po~"
		fi
	done
done


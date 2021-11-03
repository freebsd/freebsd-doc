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

# shellcheck disable=SC3043


LOCALBASE="/usr/local"
ASCIIDOCTORPDF_CMD="${LOCALBASE}/bin/asciidoctor-pdf"

build_pdf() {
	if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]; then
		exit 1
	fi

	local doc_type="$1"
	local doc_lang="$2"
	local doc_name="$3"

	local cur_dir_source="content/$doc_lang/$doc_type/$doc_name/"
	local cur_dir_output="public/$doc_lang/$doc_type/$doc_name/"

	if [ ! -d "$cur_dir_output" ]; then
		mkdir -p "$cur_dir_output"
	fi

	if [ "$doc_type" = "books" ]; then
		local asciidoctor_type="book"

		if [ -f "${cur_dir_source}book.adoc" ]; then
			local asciidoctor_file_name="book.adoc"
		else
			local asciidoctor_file_name="_index.adoc"
		fi
	fi

	if [ "$doc_type" = "articles" ]; then
		local asciidoctor_type="article"
		local asciidoctor_file_name="_index.adoc"
	fi

	$ASCIIDOCTORPDF_CMD \
		-r ./shared/lib/man-macro.rb \
		-r ./shared/lib/git-macro.rb \
		-r ./shared/lib/packages-macro.rb \
		-r ./shared/lib/inter-document-references-macro.rb \
		-r ./shared/lib/sectnumoffset-treeprocessor.rb \
		-r ./shared/lib/cross-document-references-macro.rb \
		--doctype="$asciidoctor_type" \
		-a skip-front-matter \
		-a lang=${doc_lang} \
		-a isonline=1 \
		-a env-beastie=1 \
		-a pdf-theme=default-with-fallback-font \
		-o "${cur_dir_output}${doc_name}_${doc_lang}.pdf" \
		"${cur_dir_source}${asciidoctor_file_name}"
}


# build_epub()


main() {
	if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]; then
		echo "Needs parameters (type, language and format)."
		echo "$0 articles en pdf"
		exit 1
	fi

	local doc_type="$1"
	local doc_lang="$2"
	local doc_format="$3"

	if [ ! "$doc_type" = "articles" ] && [ ! "$doc_type" = "books" ]; then
		echo "First parameter needs to be 'articles' or 'books'"
		exit 1
	fi

	if [ ! "$doc_format" = "pdf" ]; then
		# Default pdf
		doc_format="pdf"
	fi

	for document in $(find "content/$doc_lang/$doc_type/" -type d -mindepth 1 -maxdepth 1 | awk -F '/' '{ print $4 }' | sort -n); do
		if [ "$doc_format" = "pdf" ] && [ "$document" = "pgpkeys" ]; then
			continue
		fi

		if [ "$doc_format" = "pdf" ]; then
			echo "asciidoctor build_pdf: $doc_type $doc_lang $document $doc_format"
			build_pdf "$doc_type" "$doc_lang" "$document"
		fi

	done
}

main "$@"

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

if [ "$USE_RUBYGEMS" = "YES" ]; then
	GEMBASE="${GEM_PATH}"
else
	GEMBASE="${LOCALBASE}"
fi

ASCIIDOCTORPDF_CMD="${GEMBASE}/bin/asciidoctor-pdf"
ASCIIDOCTOREPUB3_CMD="${GEMBASE}/bin/asciidoctor-epub3"

build_pdf() {
	if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]; then
		exit 1
	fi

	local doc_type="$1"
	local doc_lang="$2"
	local doc_name="$3"

	local cur_dir_source="content/$doc_lang/$doc_type/$doc_name/"
	local cur_dir_output="public/$doc_lang/$doc_type/$doc_name/"

	local theme_font=""

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

	# Check non default fonts
	case "$doc_lang" in
		zh-cn)
			if [ ! -f "$LOCALBASE/share/docproj-fonts-cjk/NotoSansSC-Medium.otf" ]; then
				echo "  font not found, skipping pdf build"
				return
			fi
			theme_font="-a pdf-theme=./shared/zh-cn/zh-cn-theme.yml -a pdf-fontsdir=$LOCALBASE/share/docproj-fonts-cjk"
			;;
		zh-tw)
			if [ ! -f "$LOCALBASE/share/docproj-fonts-cjk/NotoSansTC-Medium.otf" ]; then
				echo "  font not found, skipping pdf build"
				return
			fi
			theme_font="-a pdf-theme=./shared/zh-tw/zh-tw-theme.yml -a pdf-fontsdir=$LOCALBASE/share/docproj-fonts-cjk/"
			;;
		*)
			theme_font="-a pdf-theme=default-with-fallback-font"
			;;
	esac

	$ASCIIDOCTORPDF_CMD \
		-r ./shared/lib/man-macro.rb \
		-r ./shared/lib/git-macro.rb \
		-r ./shared/lib/packages-macro.rb \
		-r ./shared/lib/inter-document-references-macro.rb \
		-r ./shared/lib/sectnumoffset-treeprocessor.rb \
		-r ./shared/lib/cross-document-references-macro.rb \
		--doctype="$asciidoctor_type" \
		-a skip-front-matter \
		-a lang="$doc_lang" \
		-a isonline=1 \
		-a env-beastie=1 \
		${theme_font} \
		-o "${cur_dir_output}${doc_name}_${doc_lang}.pdf" \
		"${cur_dir_source}${asciidoctor_file_name}"
}


build_epub() {
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

	$ASCIIDOCTOREPUB3_CMD \
		-r ./shared/lib/man-macro.rb \
		-r ./shared/lib/git-macro.rb \
		-r ./shared/lib/packages-macro.rb \
		-r ./shared/lib/inter-document-references-macro.rb \
		-r ./shared/lib/sectnumoffset-treeprocessor.rb \
		-r ./shared/lib/cross-document-references-macro.rb \
		--doctype="$asciidoctor_type" \
		-a skip-front-matter \
		-a lang="$doc_lang" \
		-a isonline=1 \
		-a env-beastie=1 \
		-o "${cur_dir_output}${doc_name}_${doc_lang}_POC_.epub" \
		"${cur_dir_source}${asciidoctor_file_name}"
}


archive() {
	if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]; then
		exit 1
	fi

	local doc_type="$1"
	local doc_lang="$2"
	local doc_name="$3"

	if [ -d "public/$doc_lang" ]; then
		local pub_dir="public/$doc_lang/$doc_type/$doc_name/"
	elif [ -d "public/$doc_type" ]; then
		# single language build
		local pub_dir="public/$doc_type/$doc_name/"
	fi

	if [ -f "${pub_dir}${doc_name}_${doc_lang}.tar.gz" ]; then
		rm -f "${pub_dir}${doc_name}_${doc_lang}.tar.gz"
	fi

	local source_doc_dir=""
	if [ -d "public/source/$doc_type/$doc_name/" ]; then
		source_doc_dir="public/source/$doc_type/$doc_name/"
	fi

	local image_doc_dir=""
	if [ -d "public/images/$doc_type/$doc_name/" ]; then
		image_doc_dir="public/images/$doc_type/$doc_name/"
	fi

	tar -czf "public/${doc_name}_${doc_lang}.tar.gz" \
		"$pub_dir" \
		public/css/ \
		public/fonts/ \
		public/images/FreeBSD-colors.svg \
		public/images/FreeBSD-monochromatic.svg \
		public/js/ \
		public/styles/ \
		$source_doc_dir \
		$image_doc_dir

	mv -f "public/${doc_name}_${doc_lang}.tar.gz" "$pub_dir"

}


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

	case "$doc_format" in
		pdf)
			for document in $(find "content/$doc_lang/$doc_type/" -type d -mindepth 1 -maxdepth 1 | awk -F '/' '{ print $4 }' | sort -n); do
				if [ "$document" = "pgpkeys" ]; then
					continue
				fi
				echo "asciidoctor build_pdf: $doc_type $doc_lang $document"
				build_pdf "$doc_type" "$doc_lang" "$document"
			done
			;;
		archive)
			for document in $(find "content/$doc_lang/$doc_type/" -type d -mindepth 1 -maxdepth 1 | awk -F '/' '{ print $4 }' | sort -n); do
				echo "generate archive: $doc_type $doc_lang $document"
				archive "$doc_type" "$doc_lang" "$document"
			done
			;;
		epub)
			for document in $(find "content/$doc_lang/$doc_type/" -type d -mindepth 1 -maxdepth 1 | awk -F '/' '{ print $4 }' | sort -n); do
				if [ "$document" = "pgpkeys" ]; then
					continue
				fi
				echo "asciidoctor epub: $doc_type $doc_lang $document"
				build_epub "$doc_type" "$doc_lang" "$document"
			done
			;;
		*)
			echo "Formats available: archive, pdf, epub"
			exit 1
			;;
	esac
}

main "$@"

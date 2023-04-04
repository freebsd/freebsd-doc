# Generate the FreeBSD website
#
# Copyright (c) 2020-2023, The FreeBSD Documentation Project
# Copyright (c) 2020-2023, Sergio Carlavilla <carlavilla@FreeBSD.org>
#
# Targets intended for use on the command line
#
# all (default)	-	generate the releases.toml and compile all the website
# run	-			serves the built website for local browsing
#
# The run target uses hugo's built-in webserver to make the built website
# available for local browsing.  The website should have been built prior
# to attempting to use the `run` target.  By default, hugo will start its
# webserver on port 1313.

MAINTAINER=carlavilla@FreeBSD.org

# List of all languages we have content for
ALL_LANGUAGES=	de el en es fr hu it ja nl ru tr zh-cn zh-tw

LOCALBASE?=	/usr/local

RUBY_CMD =	${LOCALBASE}/bin/ruby
HUGO_CMD =	${LOCALBASE}/bin/hugo
HUGO_ARGS?=
RUBYLIB =	../shared/lib
.export	RUBYLIB

.ifndef HOSTNAME
.  ifdef BIND
.HOST=$(BIND)
.  else
.HOST=localhost
.  endif
.else
.HOST=$(HOSTNAME)
.endif

.if defined(DOC_LANG) && !empty(DOC_LANG)
LANGUAGES=      ${DOC_LANG:S/,/ /g}
.if  ${LANGUAGES:Men} == ""
.warning "Warning: cannot skip 'en'; adding it back"
LANGUAGES+=	en
.endif
.else
LANGUAGES=	${ALL_LANGUAGES}
.endif

# Take the list of all languages, and take out the ones we have been
#   asked for via DOC_LANG.  We'll feed this to hugo.
SKIP_LANGS=
.for a in ${ALL_LANGUAGES}
.if ${LANGUAGES:M${a}} == ""
SKIP_LANGS+=	${a}
.endif
.endfor

.ORDER: all run

.ORDER: starting-message generate-releases
.ORDER: starting-message build
.ORDER: generate-releases build
.ORDER: build post-build
.ORDER: post-build end-message

all: starting-message generate-releases cgi-pre-permissions build post-build end-message
run: starting-message generate-releases cgi-pre-permissions run-local
clean: hugo-clean releases-clean

starting-message: .PHONY
	@echo "---------------------------------------------------------------"
	@echo "Building the website started on $$(date)"
	@echo " included languages: ${LANGUAGES}"
	@echo " excluded languages: ${SKIP_LANGS}"
	@echo "---------------------------------------------------------------"

end-message: .PHONY
	@echo "---------------------------------------------------------------"
	@echo "Building the website completed on $$(date)"
	@echo "---------------------------------------------------------------"

generate-releases: data/releases.toml

data/releases.toml:
	${RUBY_CMD} ./tools/releases-toml.rb

run-local: .PHONY
	HUGO_DISABLELANGUAGES="${SKIP_LANGS}" ${HUGO_CMD} server \
	    ${HUGO_ARGS} -D $(BIND:D--bind=$(BIND)) --baseURL="http://$(.HOST):1313"

build: .PHONY
	HUGO_DISABLELANGUAGES="${SKIP_LANGS}" ${HUGO_CMD} ${HUGO_ARGS}

post-build: cgi-permissions

cgi-pre-permissions:
.if exists(./public/cgi)
	@chmod 755 ./public/cgi/*.cgi
.endif

cgi-permissions:
	@chmod 555 ./public/cgi/*.cgi

hugo-clean:
	rm -fr public resources

releases-clean:
	rm -f data/releases.toml

generate-release:
.if empty(RELEASE) && empty(MAIN)
	@echo "Specify a release or use main. Example RELEASE=14.1 MAIN=true"
.else
.if exists(./tmp)
	rm -fr ./tmp
.endif
	@echo "---------------------------------------------------------------"
	@echo "Generating the release, be patient"
	@echo "---------------------------------------------------------------"
.if !empty(MAIN)
	git clone --depth 1 --branch main https://git.FreeBSD.org/src.git tmp
.elif !empty(RELEASE)
	git clone --depth 1 --branch releng/${RELEASE} https://git.FreeBSD.org/src.git tmp
.endif
	${HUGO_CMD} new --kind release releases/${RELEASE}R/
	${RUBY_CMD} ./tools/hardware-notes-processor.rb content/en/releases/${RELEASE}R/hardware.adoc
	rm -fr ./tmp
.endif

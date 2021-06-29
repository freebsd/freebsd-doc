# Generate the FreeBSD website
#
# Copyright (c) 2020-2021, The FreeBSD Documentation Project
# Copyright (c) 2020-2021, Sergio Carlavilla <carlavilla@FreeBSD.org>
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

PYTHON_CMD =	/usr/local/bin/python3
HUGO_CMD =	/usr/local/bin/hugo
HUGO_ARGS?=	--verbose
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

.ORDER: all run

.ORDER: starting-message generate-releases
.ORDER: starting-message build
.ORDER: generate-releases build
.ORDER: build post-build
.ORDER: post-build end-message

all: starting-message generate-releases build post-build end-message
run: starting-message generate-releases run-local
clean: hugo-clean releases-clean

starting-message: .PHONY
	@echo "---------------------------------------------------------------"
	@echo "Building the website started on $$(date)"
	@echo "---------------------------------------------------------------"

end-message: .PHONY
	@echo "---------------------------------------------------------------"
	@echo "Building the website completed on $$(date)"
	@echo "---------------------------------------------------------------"

generate-releases: data/releases.toml

data/releases.toml:
	${PYTHON_CMD} ./tools/releases-toml.py -p ./shared/releases.adoc

run-local: .PHONY
	${HUGO_CMD} server ${HUGO_ARGS} -D $(BIND:D--bind=$(BIND)) --baseURL="http://$(.HOST):1313"

build: .PHONY
	${HUGO_CMD} ${HUGO_ARGS}

post-build: cgi-permissions

cgi-permissions:
	@chmod 555 ./public/cgi/*.cgi

hugo-clean:
	rm -fr public resources

releases-clean:
	rm -f data/releases.toml

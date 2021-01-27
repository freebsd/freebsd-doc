# Generate the FreeBSD website
#
# Copyright (c) 2020-2021, The FreeBSD Documentation Project
# Copyright (c) 2020-2021, Sergio Carlavilla <carlavilla@FreeBSD.org>
#
# Targets intended for use on the command line
#
# all (default)	-	generate the releases.toml and compile all the website
# generate	-	generate the releases.toml and build all the website

MAINTAINER=carlavilla@FreeBSD.org

PYTHON_CMD =	/usr/local/bin/python3.7
HUGO_CMD =	/usr/local/bin/hugo

.ORDER: starting-message generate-books-toc
.ORDER: starting-message build
.ORDER: generate-books-toc build

all: starting-message generate-releases run
generate: starting-message generate-releases build .PHONY

starting-message: .PHONY
	@echo ---------------------------------------------------------------
	@echo                   Building the website
	@echo ---------------------------------------------------------------

generate-releases: .PHONY
	${PYTHON_CMD} ./tools/releases-toml.py -p ./shared/releases.adoc

run: .PHONY
	${HUGO_CMD} server -D

build: .PHONY
	${HUGO_CMD}

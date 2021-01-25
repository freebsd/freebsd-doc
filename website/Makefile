# Generate the FreeBSD website
#
# Copyright (c) 2020-2021, The FreeBSD Documentation Project
# Copyright (c) 2020-2021, Sergio Carlavilla <carlavilla@FreeBSD.org>
#
# Targets intended for use on the command line
#
# all (default)	-	generate the releases.toml and compile all the website
# generate	-	generate the releases.toml and build all the website
# copy-shared	-	move the shared AsciiDoc entities to the folder project

MAINTAINER=carlavilla@FreeBSD.org

PYTHON_CMD =	/usr/local/bin/python3.7
HUGO_CMD =	/usr/local/bin/hugo

all: starting-message generate-releases run
generate: starting-message generate-releases build
copy-shared: move-shared

starting-message:
	@echo ---------------------------------------------------------------
	@echo                   Building the website
	@echo ---------------------------------------------------------------

generate-releases:
	${PYTHON_CMD} ./tools/releases-toml.py -p ./shared/releases.adoc

run:
	${HUGO_CMD} server -D

build:
	${HUGO_CMD}

move-shared:
	cp -R ../shared ./shared

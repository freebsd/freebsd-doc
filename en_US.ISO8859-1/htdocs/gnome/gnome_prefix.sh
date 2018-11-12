#!/bin/sh
#
#-*- mode: Fundamental; tab-width: 4; -*-
# ex:ts=4
#
# Copyright (c) 2006 FreeBSD GNOME Team <gnome@FreeBSD.org>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $FreeBSD$
#
### BEGIN changeable variables
LOCALBASE=/usr/local
X11BASE=/usr/X11R6
#----
# Anything below shouldn't be edit unless you know what you are doing.
#----
dir=".gconf .gconfd .gnome .gnome2 .gnome2_private .gstreamer-0.10 \
	 .gstreamer-0.8 .icons .metacity .mozilla .themes"
list="lib/epiphany lib/firefox lib/gstreamer-0.8 lib/gstreamer-0.10 \
	  lib/mozilla lib/seamonkey lib/thunderbird share/gnome"
do_edit="no"
force="no"
scriptname=`basename $0`
### END of changeable variables

### Command line options
usage_exit () {
	echo
	echo "Usage: ${scriptname} [-f]" | /usr/bin/fmt 75 75
	exit 15
}

args=`getopt f $*`

if [ $? -ne 0 ]; then
    usage_exit
fi

set -- $args

for i; do
	case "$i" in
		-f)
			force="yes";
			shift;;
		--)
			shift; break;;
	esac
done
### END of command line options

### Start the real actions
for d in ${dir}; do
	if [ -d ~/${d} ]; then
		for p in ${list}; do
			for f in `find ~/${d} -type f -print0 | \
					  xargs -0 egrep -l "${X11BASE}/${p}" | \
					  sed -e 's|.*\.mozilla.*/pluginreg\.dat||g ; \
							  s|.*\.mozilla/.*\.default/.*||g' 2>/dev/null`; do

				if file ${f} | grep -qi text 2>/dev/null; then
					if [ "${force}" = "yes" ]; then
						export do_edit=yes
					else
						echo "Want to edit this file? [n]"
						echo "${f}"
						read EDIT

						case "$EDIT" in
							[yY]*)	export do_edit=yes ;;
						esac
					fi

					if [ "${do_edit}" = "yes" ]; then
						echo "EDIT: ${f}"
						sed -e "s|${X11BASE}/${p}|${LOCALBASE}/${p}|g ; \
						s|evolution-data-server-1.6|evolution-data-server-1.8|g ; \
						s|evolution/2.6|evolution/2.8|g ; \
						s|epiphany/2.14|epiphany/2.16|g ; \
						s|epiphany/2.15|epiphany/2.16|g" ${f} > ${f}.new;
						mv ${f}.new ${f};

						if [ "${force}" != "yes" ]; then
							unset do_edit
						fi
					fi
				fi
			done
		done
	fi
done
### End of the real actions

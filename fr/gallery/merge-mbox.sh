#!/bin/sh

# This script is dedicated to help gallery maintainer to parse source
# mailbox which contains letters submitted by
# http://www.FreeBSD.org/cgi/gallery.cgi and merge parsed information into 
# existing gallery.xml file.
#
# History:
#   31082001	Alexey Zelkin	Initial version
#
# Usage:
#  merge-mbox.sh src.mbox output.xml
#
# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.1

# source file
if ! [ -f "$1" ]; then
	echo "Could not open source mbox!"
	exit 1
fi

# destination file (copy of gallery.xml plus new items)
if [ "$2" = "" ]; then
	echo "You must specify output file name!"
	exit 1
fi

# cleanup mailbox
/usr/bin/egrep "^[commercial,nonprofit,personal]" $1 | /usr/bin/uniq | /usr/bin/sort > TMP.mbox

# make a copy of gallery.xml except closing </gallery> tag
/usr/bin/grep -v "^<\/gallery>$" gallery.xml > $2

# add XMLized new items
awk -F'\t' '{					\
	print "  <entry type=\""$1"\">";	\
	print "    <name>"$2"</name>";		\
	print "    <url>"$3"</url>";		\
	print "    <descr>"$4"</descr>";	\
	print "    <email>"$5"</email>";	\
	print "  </entry>";			\
	print "";				\
}' TMP.mbox >> $2

# add closing XML tag
echo "</gallery>" >> $2

# fixup URLs
mv $2 $2.tmp
/usr/bin/perl fixurls.pl $2.tmp $2

# cleanup
rm $2.tmp
rm TMP.mbox

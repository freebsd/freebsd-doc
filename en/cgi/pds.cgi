#!/bin/sh
# Copyright (c) 1997 Wolfram Schneider <wosch@FreeBSD.ORG>, Berlin.
# All rights reserved.
#
# pds.cgi - FreeBSD Ports download sources cgi script
#	    print a list of source files for a port
#

file="$QUERY_STRING"
file2="$file/Makefile"
CVSROOT=/home/ncvs; export CVSROOT

# set DISTDIR to a dummy  directory.
DISTDIR=/tmp/___pds.cgi___; export DISTDIR	

cat <<EOF
Content-type: text/html

EOF

case "$file" in 
    ports/*/*) ;;
	    *) echo "usage: pds module"; exit;;
esac

if [ -f "$CVSROOT/${file2},v" ]; then :
else
    echo "$file2 does not exist"
    exit
fi

# security check for  ../foo/bar and foo/../../bar/
case "$file2" in *..*) echo "$file2 does not exist"; exit;; esac

	cat <<EOF
<html>
<head>
<title>Sources for $file</title>
</head>
<body BGCOLOR="#ffffff" TEXT="#000000"
	vlink="c00000" link="#0000ff" alink="#eeee00">

<h1>Sources for $file</h1>

EOF
cvs -Q co -p $file2 | make -I /home/fenner/mk -f - bill-fetch | 
	perl -ne 'print qq{<a href="$1">$1</a><br>\n}
	    if m%((http|ftp)://\S+)%'
cat <<EOF

</body>
</html>
EOF

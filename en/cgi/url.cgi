#!/bin/sh
# Copyright (c) Oct 1997 Wolfram Schneider <wosch@FreeBSD.org>. Berlin.
# All rights reserved.
#
# url.cgi - make plain text URLs clickable
#
# $Id: url.cgi,v 1.3 1997-11-08 14:21:32 wosch Exp $

PATH=/bin:/usr/bin:/usr/local/bin; export PATH

url="$QUERY_STRING"
case "$url" in
    http://*.freebsd.* | http://localhost/* );;
    *) printf "Content-type: text/plain\n\n"
       printf "Wrong url: \"$url\"\n"
       printf "Only http://*.freebsd.* are allowed.\n";
       exit;;
esac

if lynx -dump -head "$url" 2>/dev/null | grep -q "text/plain"
then
    printf "Content-type: text/html\n\n<HTML><BODY><pre>\n"
    lynx -source "$url" | 
	perl -npe 's/</&lt;/g;
    s%(http://[^\s"\)\>,;]+)%<A HREF="$1">$1</A>%g;
    s%([\w\-\.]+\@[\w\-\.]+\.[a-z]+)%<A HREF="mailto:$1">$1</A>%g;'
    echo "</pre>";

    # add link to sources
    case "$url" in 
	*pub/FreeBSD/FreeBSD-current/ports/*/*/pkg/DESCR)
	    echo -n "<HR><a href=\"pds.cgi?"
	    echo "$url" | perl -npe 's%.*/(ports/[^/]+/[^/]+)/pkg/DESCR\s*%$1%'
	    echo "\">Sources</a>"
	    ;;
    esac
    echo "</BODY></HTML>"	
else
    printf "Location: $url\n";
    printf "Content-type: text/plain\n\n";
fi

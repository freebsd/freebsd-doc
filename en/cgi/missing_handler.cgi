#!/usr/bin/perl
# Copyright (c) Juli 1997. Wolfram Schneider <wosch@FreeBSD.org>, Berlin.
#
# missing_handler.cgi -  User friendly error response (Apache style)
#
#
# default apache message:
# ----------------------------------------------------------------------
# File Not found
# The requested URL /~wosch/test/bla was not found on this server.
# ----------------------------------------------------------------------
#
#
# missing_handler.cgi message:
# ----------------------------------------------------------------------
#                       FreeBSD.org - Document not found
#                                       
#   The file
#   
#      http://www.FreeBSD.org/~wosch/test/bla
#     
#   does not exist at this server. You are coming from
#   
#      http://www.freebsd.org/~wosch/test/error.html.
#     
#   The closest match to your request is http://www.freebsd.org.
#   Please contact the server administrator wosch@FreeBSD.org.
#   
#   Thank you very much!
#
#     _________________________________________________________________
#                                      
#   $Date: 1997-07-17 17:30:20 $
# ----------------------------------------------------------------------
#
#
# $Id: missing_handler.cgi,v 1.1 1997-07-17 17:30:20 wosch Exp $

# output title
$title = $ENV{'MISSING_HANDLER_TITLE'} || 
    'FreeBSD.org - Document not found';

# footer message
$footer = $ENV{'MISSING_HANDLER_FOOT'} || '';


# Server environment variables
$http_referer=$ENV{'HTTP_REFERER'};
$redirect_url=$ENV{'REDIRECT_URL'};
$server_admin=$ENV{'SERVER_ADMIN'};
$http_host=$ENV{'HTTP_HOST'};
$server_name=$ENV{'SERVER_NAME'};


# HTTP header
print "Content-type: text/html\n\n";

# HTML title
print <<EOF;
<html><head>
<title>$title</title>
</head>
<BODY BGCOLOR="#FFFFFF" TEXT="#000033" ALINK="#FFCC33">


<h1>$title</h1>
EOF

# HTML body
print qq[The file <blockquote><b>
http://$http_host$redirect_url
</b></blockquote>
does not exist at this server.\n];

if ($http_referer) {
    print qq{You are coming from 
<blockquote>
<a href="$http_referer">$http_referer</a>.
</blockquote>
<p>\n};
}

print qq[
The closest match to your request is 
<a href="http://$server_name">http://$server_name</a>.

Please contact the server administrator
<a href="mailto:$server_admin?subject=Document%20not%20found%20-%20http://$http_host$redirect_url">$server_admin</a>.<p>

Thank you very much!<p>
];

# HTML footer
print <<EOF;
<HR noshade>
$footer
\$Date: 1997-07-17 17:30:20 $
</body></html>
EOF

exit(0);

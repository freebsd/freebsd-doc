#!/usr/bin/perl -T
# Copyright (c) Juli 1997-2000. Wolfram Schneider <wosch@FreeBSD.org>, Berlin.
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
#      http://www.FreeBSD.org/~wosch/test/error.html.
#     
#   The closest match to your request is http://www.FreeBSD.org.
#   Please contact the server administrator wosch@FreeBSD.org.
#   
#   Thank you very much!
#
#     _________________________________________________________________
#                                      
# $FreeBSD: www/en/cgi/missing_handler.cgi,v 1.14 2003/05/18 17:45:20 ceri Exp $
# ----------------------------------------------------------------------

sub escape($) { $_ = $_[0]; s/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g; $_; }
sub escape2($) { $_ = $_[0]; s/</&lt;/g; s/>/&gt;/g; $_; }

# output title
$title = $ENV{'MISSING_HANDLER_TITLE'} || 
    'FreeBSD.org - Document not found';

# footer message
$footer = $ENV{'MISSING_HANDLER_FOOT'} || '';


# Server environment variables
$http_referer=escape($ENV{'HTTP_REFERER'});
$redirect_url=escape($ENV{'REDIRECT_URL'});
$server_admin=escape($ENV{'SERVER_ADMIN'});
$http_host=escape($ENV{'HTTP_HOST'});
$server_name=escape($ENV{'SERVER_NAME'});

# rfc1738 says that ";"|"/"|"?"|":"|"@"|"&"|"=" may be reserved.
$http_referer_url = escape2($ENV{'HTTP_REFERER'});
$http_referer_url =~ s/([^a-zA-Z0-9;\/?:&=])/sprintf("%%%02x",ord($1))/eg;
$redirect_url_save = escape2($ENV{'REDIRECT_URL'});
$redirect_url_save =~ s/([^a-zA-Z0-9;\/?:&=])/sprintf("%%%02x",ord($1))/eg;


$hsty_base = 'http://www.FreeBSD.org';
require './cgi-style.pl';
print &html_header($title);

# HTML body
print qq[The file <blockquote><b>
http://$http_host$redirect_url
</b></blockquote>
does not exist at this server.\n];

if ($http_referer) {
    print qq{You are coming from 
<blockquote>
<a href="$http_referer_url">$http_referer</a>.
</blockquote>
<p>\n};
}

print qq[
The closest match to your request is 
<a href="http://$server_name">http://$server_name</a>.

Please contact the members of the
FreeBSD Documentation Project &lt;<A HREF="mailto:freebsd-doc\@FreeBSD.ORG?subject=Document%20not%20found%20-%20http://$http_host$redirect_url_save&body=$http_referer_url">freebsd-doc\@FreeBSD.ORG</A>&gt; 
or the server administrator
<a href="mailto:$server_admin?subject=Document%20not%20found%20-%20http://$http_host$redirect_url_save&body=$http_referer_url">$server_admin</a>.<p>

<center>
Please try our 
<a href="http://www.FreeBSD.org/search/index-site.html">Site Map</a> or
<a href="http://www.FreeBSD.org/search/search.html">Search Page</a> 
</center>
<p>

<center>
<form action="http://www.FreeBSD.org/cgi/search.cgi" method="GET">
<input type="TEXT" name="words" size="25">
<input type="hidden" name="source" value="www">
<input type="hidden" name="max" value="60">
<input type="SUBMIT" value="Search">

</form>
</center>
<p>
Thank you very much!<p>
];

print&html_footer;
exit;

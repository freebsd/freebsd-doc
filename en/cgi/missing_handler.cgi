#!/usr/bin/perl
# Copyright (c) Juli 1997. Wolfram Schneider <wosch@FreeBSD.org>, Berlin.
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
#      http://www.freebsd.org/~wosch/test/error.html.
#     
#   The closest match to your request is http://www.freebsd.org.
#   Please contact the server administrator wosch@FreeBSD.org.
#   
#   Thank you very much!
#
#     _________________________________________________________________
#                                      
#   $FreeBSD$
# ----------------------------------------------------------------------
#
#
# $FreeBSD$

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

$hsty_base = '';
require 'cgi-style.pl';
print &html_header($title);

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

print&html_footer;
exit;

#!/usr/local/bin/perl -T
# $Id: getmsg.cgi,v 1.1 1998-02-26 23:49:52 jfieber Exp $

require "./cgi-lib.pl";
require "./cgi-style.pl";

my $messageroot = "/usr/local/www/db/text/";
&ReadParse(*formdata);
&Fetch($formdata{'fetch'});

exit 0;

sub Fetch
{
    local ($docid) = @_;
    local ($start, $end, $file) = split(/ /, $docid);
    print &short_html_header("FreeBSD Mail Archives");

    #
    # Check to ensure that (a) the specified file starts
    # with an approved pathname and (b) that it contains no
    # relative components (eg ..).  This is so that arbitrary
    # files cannot be accessed.
    #

    $file =~ s/\.\.//g;
    $file =~ s|/+|/|;

    if ($file =~ /^$messageroot/ && open(DATA, $file)) {
    	seek DATA, $start, 0;
    	read DATA, $message, $end - $start;
    	close(DATA);
    	print &MessageToHTML($message);
    } else {
    	print "<p>The specified message cannot be accessed.</p>\n";
    }

    print &html_footer;
    print "</BODY></HTML>\n";
}

sub EscapeHTML
{
    local ($_) = @_;
    s/&/&amp;/g;
    s/</&lt;/g;
    s/>/&gt;/g;
    return $_;
}

sub MessageToHTML
{
    my ($doc) = @_;
    my ($i, %hdr);
    my ($header, $body) = split(/\n\n/, $doc, 2);
    
    $body = &EscapeHTML($body);

    $header = &EscapeHTML($header);
    $header =~ s/\n  */ /g;

    foreach $i (split(/\n/, $header)) {
    	($field, $data) = split(/ /, $i, 2);
    	$hdr{$field} = $data;
    }

    $message = "<pre>\n";
    if (length($hdr{'Date:'}) > 0) {
    	$message .= "<strong>Date: </strong>     $hdr{'Date:'}\n";
    }
    if (length($hdr{'From:'}) > 0) {
    	$message .= "<strong>From: </strong>     $hdr{'From:'}\n";
    }
    if (length($hdr{'To:'}) > 0) {
    	$message .= "<strong>To: </strong>       $hdr{'To:'}\n";
    }
    if (length($hdr{'Cc:'}) > 0) {
    	$message .= "<strong>Cc: </strong>       $hdr{'Cc:'}\n";
    }
#    if (length($hdr{'Sender:'}) > 0) {
#    	$message .= "<strong>Sender: </strong>   $hdr{'Sender:'}\n";
#    }
    if (length($hdr{'Subject:'}) > 0) {
    	$message .= "<strong>Subject: </strong>  $hdr{'Subject:'}\n";
    }
    $message .= "</pre>\n";

    $message .= "<pre>\n$body\n</pre>\n";
    
    return $message;
}


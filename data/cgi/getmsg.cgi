#!/usr/local/bin/perl -T
#
# Given a filename, start offset and end offset of a mail message,
# read the message and format it nicely using HTML.
#
# by John Fieber
# February 26, 1998
#
# $Id: getmsg.cgi,v 1.3 1998-02-27 03:45:29 jfieber Exp $
#

require "./cgi-lib.pl";
require "./cgi-style.pl";
use POSIX qw(strftime);

#
# Files MUST be fully qualified and MUST start with this path.
#
$messagepath = "/usr/local/www/db/text/";

&ReadParse(*formdata);
&Fetch($formdata{'fetch'});
exit 0;

sub Fetch
{
    my ($docid) = @_;
    my ($start, $end, $file) = split(/ /, $docid);
    my ($message, @finfo);

    #
    # Check to ensure that (a) the specified file starts
    # with an approved pathname and (b) that it contains no
    # relative components (eg ..).  This is so that arbitrary
    # files cannot be accessed.
    #

    $file =~ s/\.\.//g;
    $file =~ s|/+|/|;

    if ($file =~ /^$messagepath/ && open(DATA, $file))
    {
	@finfo = stat DATA;
    	seek DATA, $start, 0;
    	read DATA, $message, $end - $start;
    	close(DATA);
	$message = &MessageToHTML($message);
	print "last-modified: " .
	    POSIX::strftime("%a, %d %b %Y %T GMT", gmtime($finfo[9])) . "\n";
    }
    else
    {
    	$message = "<p>The specified message cannot be accessed.</p>\n";
    }

    print &short_html_header("FreeBSD Mail Archives");
    print $message;
    print &html_footer;
    print "</BODY></HTML>\n";
}

sub EscapeHTML
{
    my ($text) = @_;
    $text =~ s/&/&amp;/g;
    $text =~ s/</&lt;/g;
    $text =~ s/>/&gt;/g;
    return $text;
}

sub MessageToHTML
{
    my ($doc) = @_;
    my ($header, $body) = split(/\n\n/, $doc, 2);
    my ($i, %hdr, $field, $data, $message);
    
    $body = &AddAnchors(&EscapeHTML($body));

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


sub AddAnchors
{
    my ($text) = @_;

    $text =~ s/(http|https|ftp|gopher|mailto|news|file)(:[^\s]*?\/?)(\W?\s)/<a href="$1$2">$1$2<\/a>$3/g;

    return $text;
}

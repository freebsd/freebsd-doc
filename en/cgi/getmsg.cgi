#!/usr/local/bin/perl -T
#
# Given a filename, start offset and end offset of a mail message,
# read the message and format it nicely using HTML.
#
# by John Fieber
# February 26, 1998
#
# $Id: getmsg.cgi,v 1.7 1998-03-18 19:40:33 wosch Exp $
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
    my ($mid) = '/~wosch/test/mid/mid.cgi';
    
    $body = &AddAnchors(&EscapeHTML($body));

    $header = &EscapeHTML($header);
    $header =~ s/\n[ \t]+/ /g;

    foreach $i (split(/\n/, $header)) {
    	($field, $data) = split(/ /, $i, 2);
	$field =~ y/A-Z/a-z/;
    	$hdr{$field} = $data;
    }

    $message = "<pre>\n";
    if (length($hdr{'date:'}) > 0) {
    	$message .= "<strong>Date: </strong>     $hdr{'date:'}\n";
    }
    if (length($hdr{'from:'}) > 0) {
    	$message .= "<strong>From: </strong>     $hdr{'from:'}\n";
    }
    if (length($hdr{'to:'}) > 0) {
    	$message .= "<strong>To: </strong>       $hdr{'to:'}\n";
    }
    if (length($hdr{'cc:'}) > 0) {
    	$message .= "<strong>Cc: </strong>       $hdr{'cc:'}\n";
    }
#    if (length($hdr{'sender:'}) > 0) {
#    	$message .= "<strong>Sender: </strong>   $hdr{'sender:'}\n";
#    }
    if (length($hdr{'subject:'}) > 0) {
    	$message .= "<strong>Subject: </strong>  $hdr{'subject:'}\n";
    }

    if ($hdr{'message-id:'}) {
	$hdr{'message-id:'} =~ 
	    s%;([^&]+)&%;<a href="$mid?db=irt&id=$1">$1</a>&%oi;
	$message .= "<strong>Message-ID: </strong>  $hdr{'message-id:'}\n";
    }

    if ($hdr{'resent-message-id:'}) {
	$hdr{'resent-message-id:'} =~ 
	    s%;([^&]+)&%;<a href="$mid?db=irt&id=$1">$1</a>&%oi;
	$message .= "<strong>Resent-Message-ID: </strong>  $hdr{'resent-message-id:'}\n";
    }

    if ($hdr{'in-reply-to:'}) {
	$hdr{'in-reply-to:'} =~
	    s%;([^&]+)&%;<a href="$mid?db=mid&id=$1">$1</a>&%oi;
	$message .= "<strong>In-Reply-To: </strong>  $hdr{'in-reply-to:'}\n";
    }

    if ($hdr{'references:'}) {
	$hdr{'references:'} =~
	    s%;([^&\s]+)&%;<a href="$mid?db=mid&id=$1">$1</a>&%goi;
	$message .= "<strong>References: </strong>  $hdr{'references:'}\n";
    }


    $message .= "</pre>\n";

    $message .= "<pre>\n$body\n</pre>\n";
    
    return $message;
}


sub AddAnchors
{
    my ($text) = @_;

    $text =~ s/(http|https|ftp|gopher|mailto|news|file)(:[^\s]*?\/?)(\W?\s)/<a href="$1$2">$1$2<\/a>$3/goi;

    return $text;
}

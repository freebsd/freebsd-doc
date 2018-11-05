#!/usr/bin/perl -T
#
# Given a filename, start offset and end offset of a mail message,
# read the message and format it nicely using HTML.
#
# by John Fieber
# February 26, 1998
#
# $FreeBSD$
#

require "./cgi-lib.pl";
require "./cgi-style.pl";
use POSIX qw(strftime);
#
# Site design includes setting a:visited to the same as a:link,
# which isn't good in archived messages, e.g., you want to follow
# links in commit messages and know which links you've visited.
# Override it inside the <pre> that is the message.
$t_style = qq`<style type="text/css">
pre a:visited { color: #220000; }
</style>
`;


#
# Files MUST be fully qualified and MUST start with this path.
#
$messagepath = "/usr/local/www/mailindex/archive/";
$messagepathcurrent = "/usr/local/www/mid/archive/";
$ftparchive = 'ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/mailing-lists/archive';

&ReadParse(*formdata);
&Fetch($formdata{'fetch'});
exit 0;

sub Fetch
{
    my ($docid) = @_;
    my ($start, $end, $file, $type) = split(/ /, $docid);
    my ($message, @finfo);

    #
    # Check to ensure that (a) the specified file starts
    # with an approved pathname and (b) that it contains no
    # relative components (eg ..).  This is so that arbitrary
    # files cannot be accessed.
    #

    $file =~ s/\.\.//g;
    $file =~ s|/+|/|;
    $file =~ s|^archive/|$messagepath/|;

    # read the full archive 
    if ($type eq 'archive') {
	# from the FreeBSD ftp server
	if ($file =~ s%^$messagepath%%o) {
	    print "Location: $ftparchive/$file.gz\n";
	    print "Content-type: text/plain\n\n";     
	    exit(0);
	}
	
	# from the local mail archive for current mails
	elsif ($file =~ m%^current/(cvs|svn|freebsd|p4|trustedbsd)-[a-z0-9-]+$% &&
	       open(DATA, "$messagepathcurrent$file")) {
	    print "Content-type: text/plain\n\n"; 
	    while(<DATA>) {
		print;
	    }
	    close(DATA);
	    exit(0);
	}
    }

    if (($file =~ /^$messagepath/ && -f $file && open(DATA, $file)) ||
	($file =~ m%^current/(cvs|svn|freebsd|p4|trustedbsd)-[a-z0-9-]+$% &&
	 open(DATA, "$messagepathcurrent$file")))
    {
	@finfo = stat DATA;
    	seek DATA, $start, 0;
	if ($end > $start && $start >= 0) {
	    read DATA, $message, $end - $start;
	} else {
	    # Unknown length, guess the end of the E-Mail
	    my($newline) = 0;
	    while(<DATA>) {
		last if ($newline && /^From .* \d{4}/);
		if (/^$/) { $newline = 1 } else { $newline = 0; }
		$message .= $_;
	    }
	}
    	close(DATA);
	print "last-modified: " .
	    POSIX::strftime("%a, %d %b %Y %T GMT", gmtime($finfo[9])) . "\n";

	# print E-Mail as plain ascii text
	if ($type eq 'raw') {
            print "Content-type: text/plain\n\n";
            print $message;
	    return;
        }	
	$message = &MessageToHTML($message, $file);
    }
    else
    {
    	$message = "<p>The specified message cannot be accessed.</p>\n";
    }

    print &short_html_header("FreeBSD Mail Archives");
    print $message;
    print &html_footer;
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
    my ($doc, $file) = @_;
    my ($header, $body) = split(/\n\n/, $doc, 2);
    my ($i, %hdr, $field, $data, $message);
    my ($mid) = 'mid.cgi';
    my ($mid_full_url) = 'https://docs.FreeBSD.org/cgi/mid.cgi';
    my ($tmid,$tirt,$tref);
    
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
	$tmid = $hdr{'message-id:'}; 
	$hdr{'message-id:'} =~ 
	    s%;([^&]+)&%;<a href="$mid?db=irt&amp;id=$1">$1</a>&%oi;
	$message .= "<strong>Message-ID: </strong> $hdr{'message-id:'}\n";
    }

    if ($hdr{'resent-message-id:'}) {
	$hdr{'resent-message-id:'} =~ 
	    s%;([^&]+)&%;<a href="$mid?db=irt&amp;id=$1">$1</a>&%oi;
	$message .= "<strong>Resent-Message-ID: </strong>$hdr{'resent-message-id:'}\n";
    }

    if ($hdr{'in-reply-to:'}) {
	$tirt = $hdr{'in-reply-to:'};
	$hdr{'in-reply-to:'} =~
	    s%;([^&]+)&%;<a href="$mid?db=mid&amp;id=$1">$1</a>&%oi;
	$message .= "<strong>In-Reply-To: </strong>$hdr{'in-reply-to:'}\n";
    }

    if ($hdr{'references:'}) {
	$tref = $hdr{'references:'};
	$hdr{'references:'} =~
	    s%;([^&\s]+)&%;<a href="$mid?db=mid&amp;id=$1">$1</a>&%goi;
	$message .= "<strong>References: </strong> $hdr{'references:'}\n";
    }


    $message .= "</pre>\n";
    $message .= "<hr noshade=\"noshade\"/>\n";

    if ($tmid =~ m%;([^&]+)&%) {
	$message .= qq{<a href="$mid?db=irt&amp;id=$1">Next in thread</a>\n};
    }

    if ($tirt  =~ m%;([^&]+)&% ||
	$tref  =~ m%;([^&]+)&%) {
	$message .= qq{| <a href="$mid?db=mid&amp;id=$1">Previous in thread</a>\n};
    }
    $message .= qq{| <a href="$ENV{'REQUEST_URI'}+raw">Raw E-Mail</a>\n};
    my $file2 = $file;
    if ($file2 =~ s%^$messagepath%archive/%oi ||
	$file2 =~ /^current/) {
    	$message .= qq{| <a href="/mail/$file2.html">Index</a>\n};
    }
    $message .= qq{| <a href="$ENV{'REQUEST_URI'}+archive">Archive</a>\n};
    $message .= qq{| <a href="../search/searchhints.html">Help</a>\n};

    my $tid = $tmid;
    $tid =~ s/^&lt;//;
    $tid =~ s/\@.*//;

    $message .= "<hr noshade=\"noshade\"/>\n";
    #$message .= qq{<div onclick="document.location='$mid_full_url?db=irt&amp;id=$tid'">\n};
    $message .= "<pre>\n$body\n</pre>\n";
    #$message .= qq{</div>\n};

    $message .= qq{<hr/>\n<p>Want to link to this message? Use this URL: &lt;};
    $message .= qq{<a href="} . $mid_full_url . '?' . $tid;
    $message .= qq{">$mid_full_url} . '?' . $tid . qq{</a>&gt;</p>};
    
    return $message;
}

sub strip_url
{
    my $url = shift;

    # strip trailing characters
    $url =~ s/&gt;?$//;
    $url =~ s/[.,;>\s\)]*$//;

    return $url;
}

sub AddAnchors
{
    my ($text) = @_;

    $text =~ s/(http|https|ftp)(:[\S]*?\/?)(\W?\s)/sprintf("<a href=\"%s\">%s<\/a>$3", &strip_url("$1$2"), "$1$2", $3)/egoi;

    return $text;
}

#!/usr/bin/perl
#
# Perl program to send mail.
#
# $FreeBSD: www/en/cgi/reg.cgi,v 1.7 2000/04/03 08:45:51 phantom Exp $

sub do_header;
sub close_body;

$mailprog = '/usr/sbin/sendmail';

print "Content-type: text/html\n\n";

if ($ENV{'REQUEST_METHOD'} eq "get") { $buffer = $ENV{'QUERY_STRING'}; }
else { read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'}); }

@nvpairs = split(/&/, $buffer);
foreach $pair (@nvpairs)
{
    ($name, $value) = split(/=/, $pair);

    $value =~ tr/+/ /;
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

    $FORM{$name} = $value;
}

if ($FORM{"emaila"} eq "") {
  print "<HTML>\n";
  print "<HEAD>\n";
  print "<TITLE>Entry Error: Email Field Blank</TITLE>\n";
  print "</HEAD>\n";
  print "<BODY BGCOLOR=\"\#FFFFFF\" TEXT=\"\#000000\">\n";
  print "<BASEFONT SIZE=4>\n";
  print "<P>Your email address was left blank.  Please enter it.\n";
  print "</BODY>\n";
  print "</HTML>\n";
  exit(0);
}

$recipient = $FORM{'recipient'};
exit(0) if $recipient !~ /^[a-z_\.\-]+\@freebsd\.org$/io; 
$sub_recipient = "majordomo\@FreeBSD.org";
#
# format the mail file
format MAIL =
~~ ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$value
.

my ($sub_announce, $sub_security, $unsub_announce, $unsub_security) = ();
$sub_announce = 1 if $FORM{"announce"} eq "yes";
$unsub_announce = 1 if $FORM{"announce"} eq "no";
$sub_security = 1 if $FORM{"security-notifications"} eq "yes";
$unsub_security = 1 if $FORM{"security-notifications"} eq "no";

# Open the mail file and write to it
# if user is subscribing to maillist 
# which they should be, otherwise why did they hit submit ?
if ( $sub_announce || $sub_security || $unsub_announce || $unsub_security ) {
open (MAIL, "|$mailprog $sub_recipient") || die "$mailprog not available.\n";
print MAIL "From: $FORM{'emaila'}\n";
print MAIL "Subject: \n\n";
    
$sub_announce and print MAIL "subscribe freebsd-announce $FORM{'emaila'}\n";
$unsub_announce and print MAIL "unsubscribe freebsd-announce $FORM{'emaila'}\n";
$sub_security and print MAIL "subscribe freebsd-security-notifications $FORM{'emaila'}\n";
$unsub_security and print MAIL "unsubscribe freebsd-security-notifications $FORM{'emaila'}\n";

close (MAIL);
} else {
  &do_header("No action");
  print "<P>No action chosen, hence no action taken.</p>";
  &close_body;
  exit;
}

&do_header("Subscription processed");
print "<P>Thank you, $FORM{'emaila'}, for your submission.\n";
print "<BR>The request will need to be authenticated; check your mailbox ";
print "for instructions on how to do this.\n";
&close_body;

sub do_header {
  my $title = @_;
  print "<HTML>\n";
  print "<HEAD>\n";
  print "<TITLE>$title</TITLE>\n";
  print "</HEAD>\n";
  print "<BODY BGCOLOR=\"\#FFFFFF\" TEXT=\"\#660000\">\n";
  print "<FONT SIZE=4> \n";
  print "<CENTER>\n";
  print "<IMG SRC=\"..\/gifs\/bar.gif\" BORDER=0 USEMAP=\"\#bar\">\n";
  print "<MAP NAME=\"bar\">\n";
  print "<AREA SHAPE=\"RECT\" COORDS=\"1,1,111,31\" HREF=\"../index.html\">\n";
  print "<AREA SHAPE=\"RECT\" COORDS=\"112,11,196,31\" HREF=\"../ports/index.html\">\n";
  print "<AREA SHAPE=\"RECT\" COORDS=\"196,12,257,33\" HREF=\"../support.html\">\n";
  print "<AREA SHAPE=\"RECT\" COORDS=\"256,12,365,33\" HREF=\"../docs.html\">\n";
  print "<AREA SHAPE=\"RECT\" COORDS=\"366,13,424,32\" HREF=\"../commercial.html\">\n";
  print "<AREA SHAPE=\"RECT\" COORDS=\"425,16,475,32\" HREF=\"../search/search.html\">\n";
  print "<AREA SHAPE=\"RECT\" COORDS=\"477,16,516,33\" HREF=\"../search/index-site.html\">\n";
  print "<AREA SHAPE=\"RECT\" COORDS=\"516,15,562,33\" HREF=\"../index.html\">\n";
  print "<AREA SHAPE=\"RECT\" COORDS=\"0,0,564,32\" HREF=\"../index.html\">\n";
  print "</MAP>\n";
}

sub close_body {
  print "</CENTER>\n";
  print "</BODY>\n";
  print "</HTML>\n";
}
1;


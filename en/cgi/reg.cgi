#!/usr/bin/perl

# Perl program to send mail.


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

# Open the mail file and write to it
open (MAIL, "|$mailprog $recipient") || die "$mailprog not available.\n";
print MAIL "From: $FORM{'emaila'}\n";
print MAIL "Subject: FreeBSD Registration from $FORM{'emaila'}\n\n";

print MAIL "<entry>\n";
print MAIL "<first>$FORM{'First'}</first>\n";
print MAIL "<last>$FORM{'Last'}</last>\n";
print MAIL "<email>$FORM{'emaila'}</email>\n";
print MAIL "<address>$FORM{'Address'}</address>\n";
print MAIL "<city>$FORM{'City'}</city>\n";
print MAIL "<state>$FORM{'State'}</state>\n";
print MAIL "<zip>$FORM{'Zip'}</zip>\n";
print MAIL "<options commerce_email=$FORM{'commerce_email'}";
print MAIL " announce=$FORM{'announce'} newsletter=$FORM{'newsletter'}>";
print MAIL " </options>\n";
print MAIL "<version>$FORM{'version'}</version>\n";
print MAIL "</entry>\n";
print MAIL "\n";
close (MAIL);

# Open the mail file and write to it
# if user is subscribing to maillist 
if ($FORM{"announce"} eq "yes") {
open (MAIL, "|$mailprog $sub_recipient") || die "$mailprog not available.\n";
print MAIL "From: $FORM{'emaila'}\n";
print MAIL "Subject: subscribe freebsd-announce $FORM{'emaila'}\n\n";
    
print MAIL "subscribe freebsd-announce $FORM{'emaila'}\n";

close (MAIL);
}
print "<HTML>\n";
print "<HEAD>\n";
print "<TITLE>Mail Sent</TITLE>\n";
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
print "<P>Thank you, $FORM{'First'} $FORM{'Last'}, for your registration.\n";
print "<BR>It has been submitted.\n";
if ($FORM{"announce"} eq "yes") {
print "<BR>As you requested, you have also been subscribed to announce\@FreeBSD.org.\n";
}
print "</CENTER>\n";
print "</BODY>\n";

1;

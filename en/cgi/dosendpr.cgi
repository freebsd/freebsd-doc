#!/usr/bin/perl
#
#  Send-pr perl script to send a pr.
#
# Copyright (c) 1996 Free Range Media
#
#  Copying and distribution permitted under the conditions of the
#  GNU General Public License Version 2.  
#     (http://www.gnu.ai.mit.edu/copyleft/gpl.html)
#
# $FreeBSD$

use Socket;
use CGI qw/:standard/;
use DB_File;
use Fcntl qw(:DEFAULT :flock);
require "./Gnats.pm"; import Gnats;

my $blackhole = "dnsbl.njabl.org";
my $openproxyip = "127.0.0.9";
my $blackhole_err = 0;
my $openproxy;

my $expiretime = 2700;
$dbpath = "/usr/local/www/var/confirm-code/sendpr-code.db";

# Maximum size of patch that we'll accept from send-pr.html.
$maxpatch = 102400;

my $patchbuf;
my $patchhandle;

# Environment variables to stuff in the PR header.
my @ENV_captures = qw/	REMOTE_HOST
			REMOTE_ADDR
			REMOTE_PORT
			HTTP_REFERER
			HTTP_CLIENT_IP
			HTTP_FORWARDED
			HTTP_VIA
			HTTP_X_FORWARDED_FOR	/;

# env2hdr (@ENV_captures)
# Returns X-header style headers for inclusion in the header of a PR
sub env2hdr (@) {
	my $headers = "";
	for my $var (shift @_) {
		next unless $ENV{$var};
		$headers .= "X-$var: $ENV{$var}\n";
	}
	return $headers;
}
		
# isopenproxy ($ip, $blackhole_zone, $positive_ip)
# Returns undef on error, 0 if DNS lookup fails, $positive_ip if verified
# proxy. A DNS lookup failing can either means that there was a network
# problem, or that the IP is not listed in the blackhole zone.
sub isopenproxy ($$$) {
	# If $? is already set, then a successful gethostbyname() leaves it set
	local $?;
	my ($ip, $zone, $proxyip) = @_;
	my ($reversed_ip, $packed);
	if (!defined $proxyip) { return undef };

	$reversed_ip = join('.', reverse split(/\./, $ip));
	$packed = gethostbyname("${reversed_ip}.${blackhole}");
	return undef if $?;

	if ($packed && (inet_ntoa($packed) eq $proxyip)) {
		return $proxyip;
	} else {
		return 0;
	}
}

sub prerror {
    print start_html("Problem Report Error");
    print "<p>There is an error in the configuration of the problem\n",
          "report form generator.  Please back up one page and report\n",
          "the problem to the owner of that page.<br />",
	  "Report <span class=\"prerror\">$_[0]</span>.</p>";
    print end_html();
    exit (1);
}

sub piloterror {
    print start_html("Problem Report Error");
    print "<p>There is an error with your problem\n",
          "report submission.\n",
	  "The problem was: <span class=\"prerror\">$_[0]</span>.</p>";
    print end_html();
    exit (1);
}

print header();

&prerror("request method problem") if $ENV{'REQUEST_METHOD'} eq 'GET';

if (!$submission_program) { &prerror("submit program problem"); }

if ($patchhandle = upload('patch')) {
    use bytes;
    unless (uploadInfo($patchhandle)->{'Content-Type'} =~ m!text/.*!) {
	&piloterror("Patch file has wrong content type");
    }
    read($patchhandle,$patchbuf,$maxpatch + 1);
    if (length($patchbuf) > $maxpatch) {
	&piloterror("Patch file too big (over ${maxpatch} bytes)");
    }
}

# Verify the code...

$db_obj = tie(%db_hash, 'DB_File', $dbpath, O_CREAT|O_RDWR, 0644)
                    or die "dbcreate $dbpath $!";
$fd = $db_obj->fd;
open(DB_FH, "+<&=$fd") or die "fdopen $!";

unless (flock (DB_FH, LOCK_EX | LOCK_NB)) {
    unless (flock (DB_FH, LOCK_EX)) { die "flock: $!" }
}

$codeentered = param('code-confirm');
$codeentered =~ s/.*/\U$&/;	# Turn input uppercase
$currenttime = time();
if (defined($codeentered) && $codeentered && $db_hash{$codeentered} && 
  (($currenttime - $expiretime) <= $db_hash{$codeentered})) {
    if (!param('email') || !param('originator') ||
        !param('synopsis')) {
	  print start_html("Problem Report Error");
	  print "<h1>Bad Data</h1><p>You need to specify at least your ",
              "electronic mail address, your name and a synopsis ",
              "of the problem.<br />  Please return to the form and add the ",
              "missing information.  Thank you.</p>";
          print end_html();

          exit(1);
    }
} else {
	print start_html("Problem Report Error");
	print "<h1>Incorrect confirmation code</h1><p>You need to enter the correct ",
          "code from the image displayed.  Please return to the form and enter the ",
          "code exactly as shown. Thank you.</p>";
        print end_html();

        exit(1);
}

# This code has now been used, so remove it.
delete $db_hash{"$codeentered"};

# Sweep for and remove expired codes.
foreach $randomcode (keys %db_hash) {
	if ( ($currenttime - $expiretime) >= $db_hash{$randomcode}) {
		delete $db_hash{"$randomcode"};
	}
}
$db_obj->sync();                   # to flush
flock(DB_FH, LOCK_UN);
undef $db_obj;                     # removing the last reference to the DB
                                   # closes it. Closing DB_FH is implicit.
untie %db_hash;


$openproxy = isopenproxy($ENV{'REMOTE_ADDR'}, $blackhole, $openproxyip);
if (defined $openproxy) {
	if ($openproxy) {
		&prerror("$ENV{'REMOTE_ADDR'} is an open proxy server");
	}
} else {
	$blackhole_err++;
}

# Build the PR.
$pr = "To: $submission_address\n" .
      "From: " . param('originator') . "<" . param('email') . ">\n" . 
      "Subject: " . param('synopsis') . "\n" .
      env2hdr(@ENV_captures);
if ($blackhole_err) {
      $pr .= "X-REMOTE_ADDR-Is-Open-Proxy: Maybe\n";
}

$pr .= "X-Send-Pr-Version: www-2.3\n\n" .
      ">Submitter-Id:\t" . param('submitterid') . "\n" .
      ">Originator:\t" . param('originator') . "\n" .
      ">Organization:\t" . param('organization') . "\n" .
      ">Confidential:\t" . param('confidential') . "\n" .
      ">Synopsis:\t" . param('synopsis') . "\n" .
      ">Severity:\t" . param('severity') . "\n" .
      ">Priority:\t" . param('priority') . "\n" .
      ">Category:\t" . param('category') . "\n" .
      ">Class:\t\t" . param('class') . "\n" .
      ">Release:\t" . param('release') . "\n" .
      ">Environment:\t" . param('environment') . "\n" .
      ">Description:\n" . param('description') . "\n" .
      ">How-To-Repeat:\n" . param('howtorepeat') . "\n" .
      ">Fix:\n" . param('fix');

if (length($patchbuf) > 0) {
	$pr .= "\n\nPatch attached with submission follows:\n\n"
	    . $patchbuf . "\n";
}

# remove any carriage returns that appear in the report.
$pr =~ s/\r//g;

if (open (SUBMIT, "|$submission_program")){

    print SUBMIT $pr;
    close (SUBMIT);
    print start_html("Thank you for the problem report");
    print "<h1>Thank You</h1>",
	  "<p>Thank you for the problem report.  You should receive confirmation",
	  " of your report by electronic mail within a day.</p>";
} else {
    print start_html("Error raising problem report");
    print "<h1>Error</h1><p>An error occured processing your problem report.</p>";
}
print end_html();

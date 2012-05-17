#!/usr/bin/perl -T
#
# $FreeBSD: www/en/cgi/confirm-code.cgi,v 1.8 2005/12/04 22:25:20 simon Exp $
#
# Copyright (c) 2003 Eric Anderson
# Copyright (c) 2005 Ceri Davies <ceri@FreeBSD.org>

use DB_File;
use Fcntl qw(:DEFAULT :flock);
use POSIX qw(strftime);
use strict;

require './cgi-lib.pl';

$ENV{"PATH"} = "/bin:/usr/bin";
$ENV{"TMPDIR"} = "/tmp";

my($fd, $db_obj, %db_hash, $currenttime, $randomcode, $pngbindata, $randompick, $pnmlist, $i);
my(%db, $expiretime, $rfc1123_expiry, $pnmcat, $pnmtopng, $pnmdatadir, $dbpath, $FORM_db);
# %in cannot be declared with 'my', or ReadParse fails.
use vars qw/ %in /;

############################################
# generate 8 character code from A-Z0-9 (no I,O,0,1 for clarity)
my @availchars = qw(A B C D E F G H J K L M N P Q R S T U V W X Y Z 
                 2 3 4 5 6 7 8 9);

$pnmcat = "/usr/local/bin/pnmcat";
$pnmtopng = "/usr/local/bin/pnmtopng";
$pnmdatadir = "../gifs/";
$expiretime = 0;	# Default for the Expires: header
############################################

# The code databases that we know about.  If a query comes in for
# anything else, we return a zero byte "image" (rather than an image
# with a rude word in, which was tempting).

%db = (
# The querypr one is not used, but stands as an example.
#	querypr => {
#		path => '/usr/local/www/var/confirm-code/querypr-code.db',
#		lifespan => 2700,
#	},
	sendpr => {
		path => '/usr/local/www/var/confirm-code/sendpr-code.db',
		lifespan => 2700,
	},
);

&ReadParse(*in);
$FORM_db = $in{"db"}; $FORM_db ||= "junk";

$currenttime = time();
$rfc1123_expiry = strftime "%a, %b %d %H:%M:%S %Y %Z",
	gmtime($currenttime + $expiretime);

if (exists($db{$FORM_db})) {
	$dbpath = $db{$FORM_db}->{'path'};
	$expiretime = $db{$FORM_db}->{'lifespan'};

	# DB stuff here
	$db_obj = tie(%db_hash, 'DB_File', $dbpath, O_CREAT|O_RDWR, 0644)
                    or die "dbcreate $dbpath $!";
	$fd = $db_obj->fd;
	open(DB_FH, "+<&=$fd") or die "fdopen $!";

	unless (flock (DB_FH, LOCK_EX | LOCK_NB)) {
	    unless (flock (DB_FH, LOCK_EX)) { die "flock: $!" }
	}

	&gencode;

	while ($db_hash{$randomcode}) {
		# it already exists so:
		# we check age (over x seconds old?)
		# if it is, override with new date
		# if not, generate a new code
		if ( ($currenttime - $expiretime) <= $db_hash{$randomcode}) {
			&gencode;
		} else {
			delete $db_hash{"$randomcode"};
		}
	}

	$db_hash{$randomcode} = $currenttime;

	$db_obj->sync();                   # to flush
	flock(DB_FH, LOCK_UN);
	undef $db_obj;                     # removing the last reference to the DB
	                                   # closes it. Closing DB_FH is implicit.
	untie %db_hash;

	$/ = "";

	open(BUILDPNG, "$pnmcat -lr $pnmlist | $pnmtopng 2>/dev/null |");
	$pngbindata = <BUILDPNG>;
	close(BUILDPNG);
} else {
	$pngbindata = undef;
};

print "Pragma: no-cache\n";
print "Expires: $rfc1123_expiry\n";
print "Content-type: image/png\n\n";
print "$pngbindata";

############################################
sub gencode {
	srand( time() ^ ($$ + ($$ << 15)) );

	for ($i = 0; $i < 8; $i++) {
		$randompick = $availchars[int(rand(@availchars))];
		$randomcode .= "$randompick";
		$pnmlist .= "$pnmdatadir$randompick\.pnm ";
	}
}


#!/usr/bin/perl -T
#
# $FreeBSD: www/en/cgi/sendpr-code.cgi,v 1.4 2004/12/13 22:43:05 ceri Exp $
#
# Copyright (c) 2003 Eric Anderson

use DB_File;
use Fcntl qw(:DEFAULT :flock);
use strict;

$ENV{"PATH"} = "/bin:/usr/bin";
$ENV{"TMPDIR"} = "/tmp";

my($fd, $db_obj, %db_hash, $currenttime, $randomcode, $pngbindata, $randompick, $pnmlist, $i);
my($expiretime, $pnmcat, $pnmtopng, $pnmdatadir, $dbpath);

############################################
# generate 8 character code from A-Z0-9 (no I,O,0,1 for clarity)
my @availchars = qw(A B C D E F G H J K L M N P Q R S T U V W X Y Z 
                 2 3 4 5 6 7 8 9);

$pnmcat = "/usr/local/bin/pnmcat";
$pnmtopng = "/usr/local/bin/pnmtopng";
$pnmdatadir = "../gifs/";
$dbpath = "/tmp/sendpr-code.db";
$expiretime = 2700;		# seconds until code expires
############################################

$currenttime = time();

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
print "Pragma: no-cache\n";
print "Content-type: image/png\n\n";
print "$pngbindata";
close(BUILDPNG);

############################################
sub gencode {
	srand( time() ^ ($$ + ($$ << 15)) );

	for ($i = 0; $i < 8; $i++) {
		$randompick = $availchars[int(rand(@availchars))];
		$randomcode .= "$randompick";
		$pnmlist .= "$pnmdatadir$randompick\.pnm ";
	}
}



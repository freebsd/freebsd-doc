#!/usr/bin/perl -T
#
# $FreeBSD$
# Copyright (c) 2003 Eric Anderson
#
# When www/en/cgi/sendpr-code.cgi creates a submission code to validate
# that the submitter is not a script, the code only gets removed if the
# user continues through www/en/cgi/dosendpr.cgi.
# This script can be run periodically from cron to ensure that the DBM
# doesn't grow without bound.

use DB_File;
use Fcntl qw(:DEFAULT :flock);
use strict;

$ENV{"PATH"} = "/bin:/usr/bin";
$ENV{"TMPDIR"} = "/tmp";

my ($fd, $db_obj, %db_hash, $currenttime, $randomcode, $expiretime, $dbpath);

############################################
$dbpath = "/tmp/sendpr-code.db";
$expiretime = 2700;              # seconds until code expires
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

foreach $randomcode (keys %db_hash) {
        if ( ($currenttime - $expiretime) <= $db_hash{$randomcode}) {
                delete $db_hash{"$randomcode"};
        }
}

$db_obj->sync();                   # to flush
flock(DB_FH, LOCK_UN);
undef $db_obj;

untie %db_hash or warn "untie: $!";


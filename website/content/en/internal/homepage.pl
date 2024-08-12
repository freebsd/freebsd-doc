#!/usr/bin/perl

# $FreeBSD$

print "* link:https://people.FreeBSD.org/homepage/[FreeBSD Developer home page list]\n";
exit 0;

$homepagedir = 'public_html';
@index = ('index.html', 'index.cgi');
$noindex = '.noindex';

open(P, 'getent passwd |') || die "getent passwd: $!\n";
undef @pages;
while(<P>) {
	($login,$password,$uid,$gid,$gcos,$home,$shell) = split(/:/);

	# cleanup gecos
	$gcos =~ s/,.*//;

	# disable daemons
	next if $uid < 500;
	next if $login eq 'nobody';
	next if $shell =~ ~ m%/(pppd|sliplogin|nologin|nonexistent)$%;

	# uucp accounts
	next if $login =~ /^U/;

 	$p = $home . '/' . $homepagedir;
	
	# user don't want be on the index
	next if -f "$p/$noindex";

	foreach (@index) {
		if (-f "$p/$_" && -r "$p/$_") {
			if ($_ !~ /\.cgi$/ || -x "$p/$_") {
				push(@pages, $gcos . ':' . $login);
				last;
			}
		}
	}
}

close P;
if ($#pages < 0) {
	#die "No users found!\n";
	push(@pages, "Disabled:disabled");
}

foreach (sort @pages) {
	($gcos, $login) = split(/:/);
	($firstgecos, @gecos) = split(/,/, $gcos);
	print qq{* link:https://people.FreeBSD.org/~$login/[}, $firstgecos, "] ", join(', ', @gecos), "\n";
}

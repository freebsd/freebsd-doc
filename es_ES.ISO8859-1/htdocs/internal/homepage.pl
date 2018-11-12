#!/usr/bin/perl

$passwd = '/etc/passwd';
$homepagedir = 'public_html';
@index = ('index.html', 'index.cgi');
$noindex = '.noindex';

open(P, $passwd) || die "open $passwd: $!\n";
undef @pages;
while(<P>) {
	($login,$passwd,$uid,$gid,$gcos,$home,$shell) = split(/:/);

	# cleanup gecos
	$gcos =~ s/,.*//;

	# disable daemons
	next if $uid <= 100;
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
	die "No users found!\n";
}

foreach (sort @pages) {
	($gcos, $login) = split(/:/);
	($firstgecos, @gecos) = split(/,/, $gcos);
	print qq{<LI><A HREF="http://www.freebsd.org/~$login/">},
	      $firstgecos, "</A> ", join(', ', @gecos), "</LI>\n";
}


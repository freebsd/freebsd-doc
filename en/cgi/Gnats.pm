# $Id: Gnats.pm,v 1.1 2004-02-16 16:57:10 ceri Exp $
package Gnats;

# We probably don't have "our" in this Perl
use vars qw/
	$gnats_root
	$query_pr
	$submission_address
	$submission_program
	$use_mail
	/;

$gnats_root="/usr/local/libexec/gnats";
$query_pr="/usr/local/bin/query-pr.web";
$submission_address="freebsd-gnats-submit\@FreeBSD.org";
$use_mail=1;

if ($use_mail) {
	if (-e "/usr/lib/sendmail") { $submission_program = "/usr/lib/sendmail -t" };
	if (-e "/usr/sbin/sendmail") { $submission_program = "/usr/sbin/sendmail -t" };
} else {
	if (-e "$gnats_root/queue-pr") { $submission_program = "$gnats_root/queue-pr -q" };
}

##### End site specific stuff

BEGIN {
	use Exporter();
	use vars qw/$VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS/;
	$VERSION = 0.01;	# Has to have two decimal places
	@ISA = qw/Exporter/;
	# Names for sets of symbols
	%EXPORT_TAGS = (
			'standard'=>[qw/$gnats_root $query_pr $submission_address
				$submission_program/],
	);
	Exporter::export_tags('standard');
	Exporter::export_ok_tags('standard');
}

1;

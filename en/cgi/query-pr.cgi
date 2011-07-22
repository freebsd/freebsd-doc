#!/usr/bin/perl -Tw
#------------------------------------------------------------------------------
# GNATS query-pr Interface, Generation III
#
# Copyright (C) 2006-2011, Shaun Amott <shaun@FreeBSD.org>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $FreeBSD: www/en/cgi/query-pr.cgi,v 1.78 2011/07/21 14:31:41 shaun Exp $
#
# Useful PRs for testing:
#
# - ports/147261 - RFC 2047 words, attachments, interjected e-mail (inc.
#                  malformed header)
# - ports/138672 - Lots of attachments, multi-level MIME.
# - ports/132344 - Base64-encoded attachment.
#
# TODO:
#
# - Charset and transfer encoding transformation.
# - Refine linkifier.
# - Better end-of-diff detection.
# - Inline patches inside MIME parts (probably just the first part).
# - Modernise HTML (may require altering site-wide CSS)
#------------------------------------------------------------------------------

BEGIN { push @INC, '.'; }

use CGI;

use GnatsPR;
use GnatsPR::SectionIterator;
use GnatsPR::MIMEIterator;

#use MIME::EncWords (decode_mimewords);   # mail/p5-MIME-EncWords
sub decode_mimewords { wantarray ? @_ : join ' ', @_; } # Temp. substitute for the above

require './cgi-style.pl';
require './query-pr-lib.pl';

use strict;


#------------------------------------------------------------------------------
# Constants
#------------------------------------------------------------------------------

use constant EXIT_NOPRS   => 1;
use constant EXIT_DBBUSY  => 2;
use constant EXIT_NOPATCH => 3;


#------------------------------------------------------------------------------
# Globals
#------------------------------------------------------------------------------

our $valid_category = '[a-z0-9][A-Za-z0-9-_]{1,25}';
our $valid_pr       = '\d{1,8}';

our $cvsweb_url    = 'http://www.FreeBSD.org/cgi/cvsweb.cgi/';
our $stylesheet    = "$main::hsty_base/layout/css/query-pr.css";

our $iscgi = defined $ENV{'SCRIPT_NAME'};

# Keep this ahead of CGI

if (!$iscgi && !exists $ENV{'REQUEST_METHOD'}) {
	# Makes debugging easier
	$ENV{'REQUEST_METHOD'} = 'GET';
}

# Stuff from cgi-style.pl

$main::hsty_base ||= '';
$main::t_style   ||= '';

$main::t_style =
qq{<link href="$stylesheet" rel="stylesheet" type="text/css" />
<link rel="search" type="application/opensearchdescription+xml"
	href="http://www.freebsd.org/search/opensearch/query-pr.xml"
	title="FreeBSD Bugs" />
};

# Global CGI accessor

our $q = new CGI;


#------------------------------------------------------------------------------
# Environment vars
#------------------------------------------------------------------------------

$ENV{'PATH'} = '/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin';

$ENV{'SCRIPT_NAME'} ||= $0;


#------------------------------------------------------------------------------
# Begin Code
#------------------------------------------------------------------------------

main();


#------------------------------------------------------------------------------
# Main routine
#------------------------------------------------------------------------------

sub main
{
	my ($PR, $category, $rawdata, $gnatspr);

	binmode STDOUT, ':utf8';

	if ($q->param('pr')) {
		$PR = $q->param('pr');
	} elsif ($q->param('q')) {
		$PR = $q->param('q');
	} elsif ($q->param('prp')) {
		# Legacy param format
		my $prp = $q->param('prp');

		if ($prp =~ /^(\d+)-(\d+)/) {
			my $get = $2;
			$PR = $1;

			$q->param(-name => 'pr', -value => $PR);
			$q->param(-name => 'getpatch', -value => $get);
		} else {
			ErrorExit();
		}
	} else {
		ErrorExit(EXIT_NOPRS);
	}

	if ($PR =~ /^($valid_category)\/($valid_pr)$/) {
		$category = $1;
		$PR = $2;
	}

	length $PR > 0
		or ErrorExit();

	# category may be undef
	$rawdata = DoQueryPR($PR, $category);

	# Dump the raw PR data if requested
	if ($q->param('f') && $q->param('f') eq 'raw') {
		print "Content-type: text/plain; charset=UTF-8\r\n\r\n";
		print $$rawdata;
		Exit();
	}

	# Run PR text through the parser
	$gnatspr = GnatsPR->new($rawdata);

	# User is requesting a patch extraction?
	if ($q->param('getpatch')) {
		my ($patch, $patchnum);

		$patchnum  = $q->param('getpatch');
		$patchnum =~ s/[^0-9]+//g;

		$patch = $gnatspr->GetAttachment($patchnum);

		defined $patch
			or ErrorExit(EXIT_NOPATCH);

		printf 'Content-type: %s; charset=UTF-8'."\r\n",
			($patch->isbinary ? 'application/octet-stream' : 'text/plain');

		printf 'Content-Length: %s'."\r\n"
			. 'Content-Disposition: inline; filename="%s"'."\r\n\r\n",
			$patch->size,
			$patch->filename;

		print $patch->data;

		Exit();
	}

	# Otherwise, output PR

	PrintPR($gnatspr);

	Exit();
}


#------------------------------------------------------------------------------
# Func: DoQueryPR()
# Desc: Invoke the query-pr binary and return the results as a blob of text.
#       Exits gracefully on failure.
#
# Args: $PR     - PR number
#       $cat    - PR category (optional)
#
# Retn: \$data  - Ref. to raw data.
#------------------------------------------------------------------------------

sub DoQueryPR
{
	my ($PR, $cat) = @_;
	my ($data);

	$PR =~ s/[^0-9]+//g;
	$PR = quotemeta $PR;

	# Note: query-pr.web is just an anti DoS wrapper around query-pr which
	# makes sure we do not run too many query-pr instances at once.
	if (defined $cat) {
		$cat =~ s/[^0-9A-Za-z-]+//g;
		$cat = quotemeta $cat;
		$data = qx(query-pr.web --full --category=${cat} ${PR} 2>&1);
	} else {
		$data = qx(query-pr.web --full ${PR} 2>&1);
	}

	if (!$data or $data =~ /^query-pr(:?\.(:?real|web))?: /) {
		ErrorExit(EXIT_NOPRS);
	} elsif ($data =~ /^lockf: /) {
		ErrorExit(EXIT_DBBUSY);
	}

	return \$data;
}


#------------------------------------------------------------------------------
# Func: PrintPR()
# Desc: Output the parsed PR.
#
# Args: $gnatspr - GnatsPR instance.
#
# Retn: n/a
#------------------------------------------------------------------------------

sub PrintPR
{
	my ($gnatspr) = @_;

	# Page title

	print html_header(
		$q->escapeHTML(
			$gnatspr->FieldSingle('Category')
			. '/'
			. $gnatspr->FieldSingle('Number')
			. ': '
			. $gnatspr->FieldSingle('Synopsis')
		)
	);

	# Header stuff of interest

	print $q->start_table({-class => 'headtable'});

	foreach my $field ('From', 'Date', 'Subject') {
		my $val = $q->escapeHTML(
			scalar decode_mimewords($gnatspr->Header($field))
		);
		print $q->Tr(
			$q->td({-class => 'key'}, $field . ':'),
			$q->td({-class => 'val'}, $val)
		)
	}

	print $q->Tr(
		$q->td({-class => 'key'}, 'Send-pr version:'),
		$q->td({-class => 'val'}, $q->escapeHTML($gnatspr->Header('x-send-pr-version')))
	);

	print $q->end_table;

	# Single fields

	print $q->start_table({-class => 'headtable'});

	foreach my $field (
		'Number',
		'Category',
		'Synopsis',
		'Severity',
		'Priority',
		'Responsible',
		'State',
		'Class',
		'Arrival-Date',
		'Closed-Date',
		'Last-Modified',
		'Originator',
		'Release'
	) {
		my $val = $q->escapeHTML($gnatspr->FieldSingle($field));
		print $q->Tr(
			$q->td({-class => 'key'}, $field . ":"),
			$q->td({-class => 'val'}, $val)
		);
	}

	print $q->end_table;

	# Sections

	my $iter = GnatsPR::SectionIterator->new(
		$gnatspr,
		# Fields we want sections from; this also
		# dictates the order they will come.
		'Organization',
		'Environment',
		'Description',
		'How-To-Repeat',
		'Fix',
		'Release-Note',
		'Audit-Trail',
		'Unformatted'
	);

	my $replynum = 0;
	my $patchnum = 0;

	while (my $item = $iter->next()) {
		# Start of new field
		if (ref $item eq 'GnatsPR::Section::FieldStart') {
			my $text = $item->string();
			$text = $q->escapeHTML($text);
			#print $q->h2($text);
			print $q->table({-class => 'mfieldtable'},
				$q->Tr($q->td({-class => 'blkhead'}, $text)));
			next;
		}

		# A chunk of text
		if (ref $item eq 'GnatsPR::Section::Text') {
			my $text = $item->string();
			$text = $q->escapeHTML($text);
			$text = Linkify($text);
			$text = AddBreaks($text);

			# Table used to ensure text CSS consistency (evil, I know)
			print $q->table($q->tbody($q->Tr($q->td({class => 'mfield'}, $text))))
				if $text;
			#print $q->p($text);

			next;
		}

		# Patch block
		if (ref $item eq 'GnatsPR::Section::Patch') {
			my $text = $item->string();
			$text = $q->escapeHTML($text);
			$text = ColourPatch($text)
				if ($item->type eq 'diff');
			$text = AddBreaks($text); # Unless binary

			print AttachmentHeader($item->{filename}, ++$patchnum);
			print $text;
			print AttachmentFooter();

			next;
		}

		# Audit-Trail state/responsible change block
		if (ref $item eq 'GnatsPR::Section::StateChange') {
			# This must be hard-coded - the old value will still
			# linger in PRs, even if the script moves.
			my $selfurl = "http://www.freebsd.org/cgi/query-pr.cgi?pr="
				. $gnatspr->FieldSingle('Number');

			# Remove the URL, as it is merely clutter
			my $why = $item->why;
			$why =~ s/[\n\s]*\Q$selfurl\E[\n\s]*$//i;
			$item->why($why);

			print $q->table({-class => 'auditblock', -cellspacing => '1'},
				$q->Tr(
					$q->th(
						{-colspan => 2, -class => 'info'},
						$q->escapeHTML($item->what) . " Changed"
					)
				),

				$q->Tr(
					$q->td({-class => 'key'}, 'From-To:'),
					$q->td(
						$q->escapeHTML(
							$item->from . '->' . $item->to
						)
					)
				),

				$q->Tr(
					$q->td({-class => 'key'}, 'By:'),
					$q->td($q->escapeHTML($item->by))
				),

				$q->Tr(
					$q->td({-class => 'key'}, 'When:'),
					$q->td($q->escapeHTML($item->when))
				),

				$q->Tr(
					$q->td({-class => 'key'}, 'Why:'),
					AddBreaks($q->td($q->escapeHTML($item->why)))
				)
			);

			next;
		}

		# Reply via E-mail
		if (ref $item eq 'GnatsPR::Section::Email') {
			print $q->start_table({-class => 'replyblock',
				-cellspacing => '1'});

			$replynum++;

			print $q->Tr($q->th(
				{-colspan => 2, -class => 'info'},
				'Reply via E-mail '
				. $q->a({href => '#reply'.$replynum,
					name => 'reply'.$replynum}, '[Link]')
			));

			# Try to determine if sender is submitter

			my $fromtag = FromSubmitter($item, $gnatspr)
				? $q->b('&nbsp;[submitter]') : '';

			# Print header

			foreach my $f ('From', 'To', 'Date') {
				print $q->Tr(
					$q->td({-class => 'key'}, $f . ':'),
					$q->td({-class => 'val'},
						$q->escapeHTML(
							scalar decode_mimewords($item->Header($f))
						)
						.
						(($f eq 'From') ? $fromtag : '')
					)
				);
			}

			print $q->start_Tr;
			print $q->start_td({-colspan => 2});

			# MIME parts

			my $mime_iter = GnatsPR::MIMEIterator->new($item);

			while (my $part = $mime_iter->next()) {
				my $ctype = $part->header('content-type');
				my $elide = 0;

				print $q->hr({-class => 'mimeboundary'})
					unless ($mime_iter->isfirst);

				$part->isattachment
					and ++$patchnum;

				# Skip (inline) HTML parts -- but only if we have
				# a plaintext part. We could possibly be a bit more
				# rigorous in verifying the existence of the latter,
				# but testing for the MIME header or other part will
				# suffice, as it is unlikely a HTML-only e-mail will
				# have more than that single part.
				if ($ctype eq 'text/html' && !$part->isattachment &&
						!$mime_iter->isfirst) {
					$elide = 1;

				# S/MIME signatures - of questionable value here
				} elsif ($ctype eq 'application/pkcs7-signature') {
					$elide = 1;
				}

				if ($elide) {
					if ($part->isattachment) {
						my $url = $q->url(-full => 1, -query => 1);

						my $dlink =
							$q->a({-href => $url . '&getpatch=' . $patchnum},
								'[Download]');

						print $q->div(
							{-class => 'elidemsg'},
							'Attachment of type "' . $q->escapeHTML($ctype)
							. '" ' . $dlink
						);
					} else {
						print $q->div(
							{-class => 'elidemsg'},
							'MIME part of type "' . $q->escapeHTML($ctype)
							. '" elided'
						);
					}

					next;
				}

				$part->isattachment
					and print AttachmentHeader($part->filename, $patchnum);

				if ($part->isbinary) { # Implies isattachment
					print $q->escapeHTML($part->body);
				} else {
					my $text;

					if ($part->header('content-type') eq 'text/plain'
							&& !$part->isattachment) {
						# ColourEmail escapes too
						$text = Linkify(ColourEmail($part->data));
					} else {
						$text = $q->escapeHTML($part->data);
					}

					if ($part->isattachment
							&& $part->filename =~ /\.(?:diff|patch)\b/i) {
						$text = ColourPatch($text);
					}

					print AddBreaks($text);
				}

				$part->isattachment
					and print AttachmentFooter();
			}

			print $q->end_td;
			print $q->end_Tr;
		}

		print $q->end_table;
	}

	print FooterLinks($gnatspr);

	print html_footer();
}


#------------------------------------------------------------------------------
# Func: AddBreaks()
# Desc: Convert newlines to HTML break elements.
#
# Args: $text - Input
#
# Retn: $text - Output
#------------------------------------------------------------------------------

sub AddBreaks
{
	my $text = shift;

	$text =~ s/\n/<br \/>/g;

	return $text;
}


#------------------------------------------------------------------------------
# Func: Linkify()
# Desc: Perform any fancy formatting on the message (e.g. HTML-ify URLs) and
#       return the result.
#
# Args: $html - Input string
#
# Retn: $html - Output string
#------------------------------------------------------------------------------

sub Linkify
{
	my ($html) = @_;

	# XXX: clean up

	$html or return '';

	my $iv = 'A-Za-z0-9\-_\/#@\$=\\\\';

	my $scriptname = $q->escapeHTML($ENV{'SCRIPT_NAME'});

	# PR references
	$html =~
		s/(?<![$iv])($valid_category)\/($valid_pr)(?![$iv])/<a href="${scriptname}?pr=$2&cat=$1">$1\/$2<\/a>/g;

	# URLs
	$html =~
		s/((?:https?|ftps?):\/\/[^\s\/]+\/[][\w=.,\'\(\)\~\?\!\&\/\%\$\{\}:;@#+-]*)/<a href="$1">$1<\/a>/g;

	# CVS files
	$html =~
		s/^RCS file: (\/home\/[A-Za-z0-9]+\/(.*?)),v$/RCS file: <a href="$cvsweb_url$2">$1<\/a>,v/mg;

	return $html;
}


#------------------------------------------------------------------------------
# Func: ColourPatch()
# Desc: Apply 'cdiff' style colours to a patch.
#
# Args: $html - Input string
#
# Retn: $html - Output string
#------------------------------------------------------------------------------

sub ColourPatch
{
	my ($html) = @_;
	my $res = '';

	# XXX: clean up

	my $plus_s    = $q->start_span({-class => 'patch_plusline'});
	my $minus_s   = $q->start_span({-class => 'patch_minusline'});
	my $context_s = $q->start_span({-class => 'patch_contextline'});
	my $revinfo_s = $q->start_span({-class => 'patch_revinfo'});
	my $at_s      = $q->start_span({-class => 'patch_hunkinfo'});
	my $all_e     = $q->end_span;

	# Expand tabs
	while ($html =~ s/\t/" " x (8 - ((length($`)-1) % 8))/e) {};

	foreach my $line (split /\n/, $html) {
		$line =~ s/^(\+.*)$/${plus_s}$1${all_e}/o;
		$line =~ s/^(-.*)$/${minus_s}$1${all_e}/o
			if $line !~ s/^(--- \d+,\d+ ----.*)$/${revinfo_s}$1${all_e}/o;
		$line =~ s/^(\*\*\* \d+,\d+ *\*\*\*.*)$/${revinfo_s}$1${all_e}/o;
		$line =~ s/^(\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*)$/${revinfo_s}$1${all_e}/o;
		$line =~ s/^(!.*)$/${context_s}$1${all_e}/o;
		$line =~ s/^(@@.*$)/${at_s}$1${all_e}/o;
		$line =~ s/^ /&nbsp;/;
		$res .= "$line\n";
	}

	$res =~ s/\n$//;

	return $res;
}


#------------------------------------------------------------------------------
# Func: ColourEmail()
# Desc: Colourise quoting levels in e-mails, and escape.
#
# Args: $email - Input string
#
# Retn: $email - Output string
#------------------------------------------------------------------------------

sub ColourEmail
{
	my ($email) = @_;

	my $result = '';

	foreach my $line (split /\n/, $email) {
		if ($line =~ /^\s*((?:>\s*)+)(.*)$/) {
			my $levels = $1;
			my $text = $2;
			my $depth;

			$depth = $levels;
			$depth =~ s/[^>]+//g;
			$depth = length $depth;

			$levels =~ s/>/&gt;/g;

			# Vim style rather than mutt

			$result .= $q->span({
				-class => 'quote' . ($depth % 2 ? 0 : 1)
			}, $levels . $q->escapeHTML($text));
		} else {
			$result .= $q->escapeHTML($line);
		}
		$result .= "\n";
	}

	return $result;
}


#------------------------------------------------------------------------------
# Func: Exit()
# Desc: Exit script.
#
# Args: n/a
#
# Retn: n/a
#------------------------------------------------------------------------------

sub Exit
{
	# Introduce a short delay, as a DoS protection measure
	select undef, undef, undef, 0.35
		unless !$iscgi;

	exit;
}


#------------------------------------------------------------------------------
# Func: ErrorExit()
# Desc: Print an error message and exit.
#
# Args: $code - EXIT_* code
#
# Retn: n/a
#------------------------------------------------------------------------------

sub ErrorExit
{
	my ($code) = @_;

	my $url = $q->url(-full => 1, -query => 1);

	if ($code == EXIT_NOPRS) {
		print html_header("No PRs Matched Query");
		displayform();
		print html_footer();
	} elsif ($code == EXIT_DBBUSY) {
		print html_header("PR Database Busy");
		print $q->p(
			'Please '
			. $q->a({-href => $url}, 'try again')
			. ' later'
		);
		print html_footer();
	} elsif ($code == EXIT_NOPATCH) {
		print "Content-type: text/plain; charset=UTF-8\r\n\r\n";
		print "No such patch!\n";
	}

	Exit();
}


#------------------------------------------------------------------------------
# Func: FromSubmitter()
# Desc: Try determine if the sender of a reply is the sender of the PR.
#
# Args: $item    - GnatsPR::Section::Email instance.
#       $gnatspr - GnatsPR instance
#
# Retn: $result  - Is sender the submitter?
#------------------------------------------------------------------------------

sub FromSubmitter
{
	my ($item, $gnatspr) = @_;

	my $from = lc $item->Header('From');
	my $submitter = lc $gnatspr->Header('From');

	$from =~ s/^.*<// and $from =~ s/>.*$//;
	$from =~ s/\s+//g;
	$submitter =~ s/^.*<// and $submitter =~ s/>.*$//;
	$submitter =~ s/\s+//g;

	return $from eq $submitter;
}


#------------------------------------------------------------------------------
# Func: AttachmentHeader()
# Desc: Construct an attachment block header.
#
# Args: $filename - Name of attachment.
#       $patchnum - Patch index.
#
# Retn: $text     - Header text.
#------------------------------------------------------------------------------

sub AttachmentHeader
{
	my ($filename, $patchnum) = @_;

	my $text = '';

	my $url = $q->url(-full => 1, -query => 1);

	$text .= $q->start_table({-class => 'patchblock', -cellspacing => '1'});
	$text .=
		$q->Tr(
			$q->td({-class => 'info'}, $q->b(
				'Download ' . $q->a({-href => $url . '&getpatch=' . $patchnum},
				$filename)
			))
		);

	$text .= $q->start_tbody;
	$text .= $q->start_Tr;
	$text .= $q->start_td({-class => 'content'});
	$text .= $q->start_pre({-class => 'attachwin'});

	return $text;
}


#------------------------------------------------------------------------------
# Func: AttachmentFooter()
# Desc: Construct an attachment block footer.
#
# Args: n/a
#
# Retn: $text - Footer text.
#------------------------------------------------------------------------------

sub AttachmentFooter
{
	my $text = '';

	$text .= $q->end_pre;
	$text .= $q->end_td;
	$text .= $q->end_Tr;
	$text .= $q->end_tbody;
	$text .= $q->end_table;

	return $text;
}


#------------------------------------------------------------------------------
# Func: FooterLinks()
# Desc: Construct the page footer links (for a valid PR page)
#
# Args: $gnatspr - GnatsPR instance.
#
# Retn: $text    - Footer text.
#------------------------------------------------------------------------------

sub FooterLinks
{
	my ($gnatspr) = @_;

	my $url = $q->url(-full => 1, -query => 1);

	my $pr       = $q->escapeHTML($gnatspr->FieldSingle('Number'));
	my $cat      = $q->escapeHTML($gnatspr->FieldSingle('Category'));
	my $synopsis = $q->escapeHTML($gnatspr->FieldSingle('Synopsis'));

	my $mail = $gnatspr->Header('From');

	# Try to extract just the e-mail address from the 'From' header
	if ($mail) {
		$mail =~ s/^\s*(.*)\s*$/$1/;
		$mail =~ s/.*<(.*)>.*/$1/;
		$mail =~ s/\s*\(.*\)\s*//;
	}

	my $replyto = $gnatspr->Header('Reply-To');

	# ... same with the 'Reply-To' header
	if ($replyto) {
		$replyto =~ s/^\s*(.*)\s*$/$1/;
		$replyto =~ s/.*<(.*)>.*/$1/;
		$replyto =~ s/\s*\(.*\)\s*//;
	}

	# Prefer 'Reply-To' if present
	$mail = $replyto if ($replyto);
	$mail .= '@FreeBSD.org' unless ($mail =~ /@/);

	# Prepare for mailto: link
	$synopsis =~ s/[^a-zA-Z+.@-]/"%" . sprintf("%02X", unpack("C", $&))/eg;
	$mail     =~ s/[^a-zA-Z+.@-]/"%" . sprintf("%02X", unpack("C", $&))/eg;

	my $maillink = 'mailto:bug-followup@FreeBSD.org,'
		. "$mail?subject=Re:%20$cat/$pr:%20$synopsis";

	return $q->div({-class => 'footerlinks'},
		$q->a({-href => $maillink}, 'Submit Followup')
		. ' | ' . $q->a({-href => $url . '&f=raw'}, 'Raw PR')
		. ' | ' . $q->a({-href => 'query-pr-summary.cgi?query'}, 'Find another PR')
	);
}

#!/usr/bin/perl -Tw
#
# A "More Useful" GNATS query-pr Interface
#
# Copyright (C) 2006, Shaun Amott <shaun@FreeBSD.org>
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
# $FreeBSD: www/en/cgi/query-pr.cgi,v 1.59 2006/11/27 17:12:50 shaun Exp $
#

use strict;
#use warnings;

use MIME::Base64;                      # ports/converters/p5-MIME-Base64
use MIME::QuotedPrint;                 #
use Convert::UU qw(uudecode uuencode); # ports/converters/p5-Convert-UU

require './cgi-style.pl';

use constant HTTP_HEADER        => "Content-type: text/html; charset=UTF-8\r\n\r\n";
use constant HTTP_HEADER_PATCH  => "Content-type: text/plain; charset=UTF-8\r\n\r\n";

use constant SECT_HEADER        => 1;
use constant SECT_SFIELDS       => 2;
use constant SECT_MFIELDS       => 3;

use constant ENCODING_BASE64    => 1;
use constant ENCODING_QP        => 2;

use constant PATCH_ANY          => 0x0001;
use constant PATCH_DIFF         => 0x0002;
use constant PATCH_UUENC        => 0x0004;
use constant PATCH_UUENC_BIN    => 0x0008;
use constant PATCH_SHAR         => 0x0010;
use constant PATCH_BASE64       => 0x0020;

my @fields_single = (
	"Number",       "Category",      "Synopsis",      "Confidential",
	"Severity",     "Priority",      "Responsible",   "State",
	"Quarter",      "Keywords",      "Date-Required", "Class",
	"Submitter-Id", "Arrival-Date",  "Closed-Date",   "Last-Modified",
	"Originator",   "Release",
);

my @fields_multiple = (
	"Organization", "Environment",   "Description",   "How-To-Repeat",
	"Fix",          "Release-Note",  "Audit-Trail",   "Unformatted",
);

my $fields_skip    = "Confidential|Quarter|Keywords|Date-Required|Submitter-Id";

my $valid_category = '[a-z0-9][A-Za-z0-9-_]{1,25}';
my $valid_pr       = '\d{1,8}';

my $binary_filetypes = '(?:\.gz|\.bz2|\.zip|\.tar)$';

my %fmt;

my $f = "";
my $PR = -1;
my $getpatch = -1;
my $inpatch = 0;
my $patchendhint = 0;
my $category;
my @query;
my (%header, %sfields, %mfields);

my $iscgi = defined $ENV{'SCRIPT_NAME'};

$ENV{'PATH'} = "/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/bin";

$ENV{'QUERY_STRING'} ||= "";
$ENV{'SCRIPT_NAME'}  ||= $0;

# Junk from cgi-style.pl
$main::hsty_base     ||= "";
$main::t_style       ||= "";

my $scriptname  = htmlclean($ENV{'SCRIPT_NAME'});
my $querystring = htmlclean($ENV{'QUERY_STRING'});

# Do not change $self_url_base, unless you understand what it is for!
# In particular: it is used as a delimiter between comments in the
# Audit-Trail.
my $self_url_base = "http://www.FreeBSD.org/cgi/query-pr.cgi?pr=";
my $cvsweb_url    = "http://www.FreeBSD.org/cgi/cvsweb.cgi/";
my $stylesheet    = "$main::hsty_base/layout/css/query-pr.css";


#-----------------------------------------------------------------------
# Format strings
#-----------------------------------------------------------------------

$fmt{'header_thead'} = <<EOF;
<table class="headtable">
EOF

$fmt{'header_tfoot'} = <<EOF;
</table><br />
EOF

$fmt{'header_trow'} = <<EOF;
<tr><td class="key">%%(1):</td><td class="val">%%(2)</td></tr>
EOF

$fmt{'sfields_thead'} = <<EOF;
<table class="headtable">
EOF

$fmt{'sfields_trow'} = <<EOF;
<tr><td class="key">%%(1):</td><td class="val">%%(2)</td></tr>
EOF

$fmt{'sfields_tfoot'} = <<EOF;
</table><br />
EOF

$fmt{'mfields_header'} = <<EOF;
<table class="headtable"><tr><td class="blkhead">%%(1):</td></tr></table>
<div class="mfield">
EOF
$fmt{'mfields_header'} =~ s/\n+$//;

$fmt{'mfields_footer'} = <<EOF;
</div>
EOF

$fmt{'patchblock_thead'} = <<EOF;
<table class="patchblock" cellspacing="0" cellpadding="3">
  <tr class="info"><td>
    <b>Download <a href="${scriptname}?pr=%%(pr)&amp;getpatch=%%(1)">%%(2)</a></b>
  </td></tr>
<tr><td class="content"><pre>
EOF
$fmt{'patchblock_thead'} =~ s/\n+$//;

$fmt{'patchblock_tfoot'} = <<EOF;
</pre></td></tr>
</table><br />
EOF
$fmt{'patchblock_tfoot'} =~ s/\n+$//;
$fmt{'patchblock_tfoot'} =~ s/^\n+//;

$fmt{'auditblock_thead'} = <<EOF;
<table class="auditblock" cellspacing="0" cellpadding="3">
  <tr class="info"><td colspan="2"><b>%%(1) Changed</b></td></tr>
EOF

$fmt{'auditblock_tfoot'} = <<EOF;
  </table>
<br />
EOF

$fmt{'auditblock_trow'} = <<EOF;
<tr><td class="key" valign="top">%%(1):</td><td valign="top">%%(2)</td></tr>
EOF

$fmt{'responseblock_thead'} = <<EOF;
<table class="replyblock" cellspacing="0" cellpadding="3">
  <tr><td class="info" colspan="2"><b>Reply via E-mail</b></td></tr>
EOF

$fmt{'responseblock_tfoot'} = <<EOF;
  </table><br />
EOF

$fmt{'responseblock_textfoot'} = <<EOF;
</td></tr>
EOF

$fmt{'responseblock_texthead'} = <<EOF;
<tr><td colspan="2">
EOF

$fmt{'responseblock_trow'} = <<EOF;
<tr><td class="key"><b>%%(1):</b></td><td class="val">%%(2)</td></tr>
EOF

$fmt{'unexpectedtext_thead'} = <<EOF;

EOF

$fmt{'unexpectedtext_tfoot'} = <<EOF;
<br />
EOF

$fmt{'html_footerlinks'} = <<EOF;
  <div>
    <a href="%%(maillink)">Submit Followup</a>
    | <a href="${scriptname}?pr=%%(pr)&amp;f=raw">Raw PR</a>
    | <a href="query-pr-summary.cgi?query">Find another PR</a>
  </div>
EOF

$fmt{'query_form'} = <<EOF;
<form action="${scriptname}" method="get">
  <table cellspacing="0" cellpadding="3" class="headtable">
    <tr><td width="130"><b>PR number:</b></td><td><input type="text" name="pr" maxlength="30" value="%%(1)" /></td></tr>
    <tr><td width="130"><b>Category:</b></td><td><input type="text" name="cat" maxlength="30" value="%%(2)" /> (optional)</td></tr>
    <tr><td></td><td><input type="submit" value="Submit" /></td></tr>
  </table>
</form>
EOF

$fmt{'trylatermsg'} = <<EOF;
<p>
  Please <a href="${scriptname}?${querystring}">try again</a> later.
</p>
EOF

$fmt{'mime_boundary'} = <<EOF;
<hr class="mimeboundary" />
EOF

$fmt{'quote_level_0'} = '<span class="quote0">&gt; ';
$fmt{'quote_level_1'} = '<span class="quote1">&gt; ';
$fmt{'quote_end'}     = '</span>';

$fmt{'empty'}         = '&nbsp;';
$fmt{'break'}         = "<br />\n";

# From cgi-style.pl
$main::t_style = "<link href=\"${stylesheet}\" rel=\"stylesheet\" type=\"text/css\" />";


#-----------------------------------------------------------------------
# Begin Code
#-----------------------------------------------------------------------

if ($ENV{'QUERY_STRING'}) {
	foreach (split(/&/, $ENV{'QUERY_STRING'})) {
		my ($key, $val) = map { s/%([0-9a-f]{2})/chr hex $1/egi; $_ }
				  split /=/;
		$f        = lc $val if ($key eq "f");
		$PR       = lc $val if ($key eq "pr" or $key eq "q");
		$PR       = lc $key if ($key =~ /^(?:$valid_category\/)?$valid_pr$/i);
		$category = lc $val if ($key eq "cat");
		$getpatch = lc $val if ($key eq "getpatch");
	}
}

unless (!$iscgi) {
	print HTTP_HEADER_PATCH if ($getpatch > 0 or $f eq "raw");
}

($category, $PR) = ($1, $2)
	if ($PR =~ /^($valid_category)\/($valid_pr)$/);

$category = undef
	if ($category && $category !~ /^$valid_category$/);

if ($PR !~ /^$valid_pr$/ || $PR < 0) {
	print html_header("Query PR Database");
	sprint('query_form');
	print html_footer();
	exit;
}

# Just in case
$PR = int $PR;
$PR = quotemeta $PR;

if ($category) {
	$category = quotemeta $category;
	@query = split /\n/, qx(query-pr.web --full --category=${category} ${PR} 2>&1);
} else {
	@query = split /\n/, qx(query-pr.web --full ${PR} 2>&1);
}

if (!@query or ($query[0] and $query[0] =~ /^query-pr(:?\.(:?real|web))?: /)) {
	print html_header("No PRs Matched Query");
	sprint('query_form', $PR || "", $category || "");
	print html_footer();
	exit;
} elsif ($query[0] =~ /^lockf: /) {
	print html_header("PR Database Busy");
	sprint('trylatermsg');
	print html_footer();
	exit;
}

if ($f eq "raw") {
	print "$_\n" foreach (@query);
	exit;
}


#-----------------------------------------------------------------------
# Process Results from query-pr
#-----------------------------------------------------------------------

my $section = SECT_HEADER;
my $mfield = $fields_multiple[0];

foreach my $line (@query)
{
	my ($k, $v);

	if ($section == SECT_HEADER) {
		$section++ if ($line =~ /^\s*$/);

		next if ($line !~ /^([A-Z][A-Za-z0-9-_.]+): (.*)$/);

		($k, $v) = ($1, $2);

		$k = lc $k;
		$header{$k} = $v;

		next;
	}

	if ($section == SECT_SFIELDS) {
		my $i = -1;
		my $f = 0;

		next if ($line !~ /^>([A-Z][A-Za-z-]+):\s*(.*)$/);

		($k, $v) = ($1, $2);

		foreach (@fields_single) {
			if ($k eq $_) {
				$f = 1;
				last;
			}

			$i++;
		}

		if (!$f or $i == $#fields_single) {
			$section++;
			next;
		}

		$sfields{$k} = $v;

		next;
	}

	if ($section == SECT_MFIELDS) {
		my $f = 0;

		if ($line =~ /^>([A-Z][A-Za-z-]+):\s*(.*)$/) {
			foreach (@fields_multiple) {
				$f = 1 if $1 eq $_;
				next;
			}

			if ($f) {
				$mfield = $1;
			} else {
				push @{$mfields{$mfield}}, $2;
			}

			next;
		}

		push @{$mfields{$mfield}}, $line;
		next;
	}
}

$getpatch = 0 if ($getpatch < 0);

if ($getpatch > 0) {
	extractpatch();
	exit;
}


# Construct footer now we have enough information

buildfooter();


print html_header(htmlclean("$sfields{'Category'}/$sfields{'Number'}: "
                            . $sfields{'Synopsis'}));

sprint('header_thead');

sprint('header_trow', 'From',    htmlclean($header{'from'}));
sprint('header_trow', 'Date',    htmlclean($header{'date'}));
sprint('header_trow', 'Subject', htmlclean($header{'subject'}));
sprint('header_trow', 'Send-pr version',
       htmlclean($header{'x-send-pr-version'}));

sprint('header_tfoot');


# Single-Line fields

sprint('sfields_thead');

foreach (@fields_single)
{
	my ($k, $v);

	$k = htmlclean($_);
	$v = htmlclean($sfields{$_}) || "";

	$v =~ s/^(\S*).*$/<a href="mailto:$1\@FreeBSD.org">$1\@FreeBSD.org<\/a>/
		if ($_ eq "Responsible");

	$v = "never"
		if ($_ eq "Last-Modified" and $v =~ /^\s*$/);

	next if ($_ =~ /$fields_skip/i);

	sprint('sfields_trow', $k, $v);
}

sprint('sfields_tfoot');


# Multiple-Line fields

foreach my $field (@fields_multiple)
{
	my $cfound = 0;

	sprint('mfields_header', $field);

	if ($field eq "Audit-Trail") {
		my %block;
		my $cliphack;
		my $blockwhy;
		my ($inblock, $inresponse, $mbreak) = (0, 0, 0);
		my $url = "${self_url_base}${PR}";

		my $outp = "";
		my %mime_headers;
		my $mime_boundary;
		my $mime_endheader;
		my $encoding = 0;

		# Hack for older PRs with no usable delimiter
		push @{$mfields{'Audit-Trail'}}, $url;

		$url = quotemeta $url;

		foreach (@{$mfields{$field}})
		{
			# If we're sure we have a genuine Reply via E-mail block,
			# allow for a border case, where there is a space rather
			# than an empty line between the header and body.
			$_ = "" if ($cliphack && /^ {1,2}$/);
			$cliphack = 0;

			if ($inblock == 1 && (/^${url}\s*$/i || /^([A-Za-z_]+-Changed-From-To: .*)$/ || /^(From: )/)) {
				my $onnextline = ($1 ? 1 : 0);
				if ($blockwhy) {
					$blockwhy =~ s/<br \/>$//;
					$blockwhy = htmlparse($blockwhy);
				}

				sprint('auditblock_trow', "Why", $blockwhy || "");

				undef %block;
				undef $blockwhy;
				$inblock = 0;
				$mbreak = 0;

				if ($inresponse) {
					if ($inpatch) {
						$inpatch = 0;
						sprint('patchblock_tfoot');
						sprint('break');
					}
					sprint('responseblock_textfoot') if ($inresponse > 1);
					sprint('responseblock_tfoot');
					$inresponse = 0;
				}

				sprint('auditblock_tfoot');
				next unless ($onnextline);
			}

			if (/^([A-Za-z_]+)-Changed-([A-Za-z_-]+?): (.*)$/) {
				my $w = $1;
				my $k = $2;

				if ($inresponse) {
					if ($inpatch) {
						$inpatch = 0;
						sprint('patchblock_tfoot');
						sprint('break');
					}
					sprint('responseblock_textfoot') if ($inresponse > 1);
					sprint('responseblock_tfoot');
					$inresponse = 0;
				}

				if ($inblock == 0) {
					$block{'changed'} = $w;
					sprint('auditblock_thead', htmlclean($w));
					$inblock = 1;
				}

				$block{$k} = $3;

				if ($k ne "Why") {
					sprint('auditblock_trow', htmlclean($k), htmlclean($block{$k}));
					next;
				}

				next;
			} elsif (/^(From|To|Cc|Subject|Date): (.*)$/) {
				my ($k, $v);

				$k = htmlclean($1);
				$v = htmlclean($2);

				if ($inresponse > 1) {
					if ($inpatch) {
						$inpatch = 0;
						sprint('patchblock_tfoot');
						sprint('break');
					}
					$mime_boundary = undef;
					$mime_endheader = 0;
					$encoding = 0;
					sprint('responseblock_textfoot');
					sprint('responseblock_tfoot');
				}

				if (!$inresponse || $inresponse > 1) {
					sprint('responseblock_thead');
				}

				if ($k eq "From" or $k eq "Date") {
					sprint('responseblock_trow', $k, $v);
				}

				$inresponse = 1;
				$cliphack = 1;
				next;
			} elsif (/^\s/ and $inresponse == 1 and !$mbreak) {
				$cliphack = 1;
				next;
			} elsif (/^ (.*)$/) {
				next if ($inresponse and !$mbreak);

				if ($inresponse == 1) {
					sprint('responseblock_texthead');
					$inresponse++;
				}

				# XXX - use trailing cfound

				if ($inresponse) {
					my $txt = $1;

					if ($txt !~ /^-+$/ && $txt !~ /(?:cut|snip)/i && $txt =~ /^--(\S+)$/) {
						$mime_boundary = $1 if (!defined $mime_boundary && !$inpatch);

						if ($1 =~ /^${mime_boundary}(--)?$/) {
							$mime_boundary = undef if (defined $1);
							if ($encoding == ENCODING_BASE64 and $outp ne "") {
								my $patchname;
								my $dp = $mime_headers{'disposition'};
								if ($dp and $dp =~ /.*\bfilename=["']?([A-Za-z0-9\-\.:_]{6,36})["']?.*/) {
									$patchname = $1;
								} else {
									$patchname = "attachment.dat";
								}
								if ($patchname =~ /$binary_filetypes/) {
									$outp = "(Binary attachment not viewable.)\n";
								} else {
									$outp = decode_base64($outp);
								}

								$outp = "--- $patchname begins here ---\n"
								      . $outp
								      . "\n--- $patchname ends here ---\n";
								parsepatches($_) foreach (split /\n/, $outp);
								$outp = "";
							}

							sprint('mime_boundary');
							$mime_endheader = 0;
							$encoding = 0;
							next;
						}
					}

					if (defined $mime_boundary && !$mime_endheader && !$inpatch) {
						if ($txt =~ /^Content-([A-Za-z-]{2,}):\s*(.*)\s*$/i) {
							$mime_headers{lc $1} = $2;
							next;
						} elsif ($txt =~ /^\s*(?:file)?name=["']?.*?["']?\s*$/i) {
							$mime_headers{'disposition'} ||= "";
							if ($mime_headers{'disposition'} !~ /(?:file)?name=/) {
								$mime_headers{'disposition'} .= "; $txt";
							}
							next;
						} else {
							$mime_endheader = 1;
							if ($mime_headers{'transfer-encoding'}) {
								my $enc = $mime_headers{'transfer-encoding'};
								if ($enc =~ /^\s*["']?base64["']?\s*$/i) {
									$encoding = ENCODING_BASE64;
								} elsif ($enc =~ /^\s*["']?quoted-printable["']?\s*$/i) {
									$encoding = ENCODING_QP;
								} else {
									$encoding = 0;
								}
							} else {
								$encoding = 0;
							}
						}
					}

					if ($encoding == ENCODING_BASE64) {
						$outp .= $txt;
						next;
					} elsif ($encoding == ENCODING_QP) {
						# XXX: lines ending in = should be joined
						$txt =~ s/=$//;
						$txt = decode_qp($txt);
					}

					if ($txt =~ /^\s*((?:>\s*)+)/) {
						my $level = $1;

						$txt =~ s/^((?:>\s*)*={47})(=+\s*)$/$1 $2/;

						if ($level =~ s/.*?>.*?/./g) {
							my $i = 0;
							my @levels = split(/\s*>\s*/, $txt,
							                   length $level);
							my $last = pop @levels;
							foreach (@levels) {
								sprint('quote_level_'.(++$i % 2));
								$_ = htmlclean($_);
								$_ = htmlparse($_);
								print;
							}
							print htmlclean($last);
							sprint('quote_end') while ($i--);
							sprint('break');
						}
					} else {
						$patchendhint = 1 if ($txt eq '-- ');

						if ($inpatch or $txt) {
							parsepatches($txt) || ($inpatch || sprint('break'));
						} else {
							sprint('break');
						}
					}
				}
			} elsif (/^$/ and $inresponse and !$mbreak) {
				# XXX: >line 1 ignored (but not needed)
				$mbreak = 1;
				next;
			} elsif (/^$/) {
				$mbreak = 0;
				next;
			} elsif (!$inblock and $_ !~ /^${url}\s*$/i) {
				if ($inresponse > 1) {
					if ($inpatch) {
						$inpatch = 0;
						sprint('patchblock_tfoot');
						sprint('break');
					}
					sprint('responseblock_textfoot');
					sprint('responseblock_tfoot');
				}

				sprint('unexpectedtext_thead');
				print htmlclean($_);
				sprint('unexpectedtext_tfoot');

				$inresponse = 0;
				next;
			}

			$cfound = ($_ ? 1 : 0) if (!$cfound);
			next if (!$cfound);

			if (!$_) {
				$cfound++;
				next;
			} else {
				print "\n" while (--$cfound);
				$cfound = 1;
			}

			$_ =~ s/^((?:>\s*)*={47})(=+\s*)$/$1 $2/;

			$_ = htmlclean($_);
			$blockwhy .= "$_<br />\n" if defined($block{'Why'});
		}

		if ($inresponse) {
			if ($inpatch) {
				$inpatch = 0;
				sprint('patchblock_tfoot');
				sprint('break');
			}
			sprint('responseblock_textfoot') if ($inresponse > 1);
			sprint('responseblock_tfoot');
			$inresponse = 0;
		}
	} elsif ($field eq "Fix") {
		foreach (@{$mfields{$field}})
		{
			s/\s+$//;

			$cfound = ($_ ? 1 : 0) if (!$cfound);
			next if (!$cfound);

			if (!$_) {
				$cfound++;
				next;
			} else {
				sprint('break')  while (--$cfound > 1);
				$cfound = 1;
			}

			parsepatches($_) || ($inpatch || sprint('break'));
		}

		if ($inpatch) {
			$inpatch = 0;
			sprint('patchblock_tfoot');
			sprint('break');
		}
	} else {
		foreach (@{$mfields{$field}})
		{
			s/\s+$//;

			$cfound = ($_ ? 1 : 0) if (!$cfound);
			next if (!$cfound);

			if (!$_) {
				$cfound++;
				next;
			} else {
				sprint('break') while (--$cfound);
				$cfound = 1;
			}

			$_ = htmlclean($_);
			$_ = htmlparse($_);

			print;
			sprint('break');
		}
		sprint('empty') if ($cfound <= 1);
	}

	sprint('mfields_footer');
}

sprint('html_footerlinks');
print html_footer();

# DoS protection -- apparently.
select undef, undef, undef, 0.35
	unless (!$iscgi);

exit;


#-----------------------------------------------------------------------
# Func: extractpatch()
# Desc: Isolate the requested patch, and print unformatted to STDOUT.
#-----------------------------------------------------------------------

sub extractpatch
{
	foreach (@{$mfields{'Fix'}}) {
		return if (parsepatches($_) == -1);
	}

	foreach (@{$mfields{'Audit-Trail'}}) {
		if (s/^ //) {
			return if (parsepatches($_) == -1);
		} else {
			$inpatch = 0;
		}
	}
}


#-----------------------------------------------------------------------
# Func: sprint()
# Desc: Merge provided list of strings into the desired message and
#       print the result to STDOUT.
#-----------------------------------------------------------------------

sub sprint
{
	my $k = shift;
	my $msg = $fmt{$k};

	if (!$msg) {
		warn "Message format \"$k\" not found";
		return;
	}

	my $i = 1;

	foreach (@_) {
		$msg =~ s/%%()\(${i}\)/$_/g;
		$i++;
	}

	$msg =~ s/%%\([0-9]+\)//g;

	print $msg;
}


#-----------------------------------------------------------------------
# Func: htmlclean()
# Desc: Remove HTML entities from message and return the result.
#-----------------------------------------------------------------------

sub htmlclean
{
	my $v = shift;
	return "" if (!$v);

	$v =~ s/&/&amp;/g;
	$v =~ s/</&lt;/g;
	$v =~ s/>/&gt;/g;
	return $v;
}


#-----------------------------------------------------------------------
# Func: htmlparse()
# Desc: Perform any fancy formatting on the message (e.g. HTML-ify
#       URLs) and return the result.
#-----------------------------------------------------------------------

sub htmlparse
{
	my $v = shift;
	return "" if (!$v);

	my $iv = 'A-Za-z0-9\-_\/#@\$\\\\';
	$v =~ s/(?<![$iv])($valid_category)\/($valid_pr)(?![$iv])/<a href="${scriptname}?pr=$2&cat=$1">$1\/$2<\/a>/g;

	$v =~ s/((?:https?|ftps?):\/\/[^\s\/]+\/[][\w=.,\'\(\)\~\?\!\&\/\%\$\{\}:;@#+-]*)/<a href="$1">$1<\/a>/g;
	$v =~ s/^RCS file: (\/home\/[A-Za-z0-9]+\/(.*?)),v$/RCS file: <a href="$cvsweb_url$2">$1<\/a>,v/;
	return $v;
}


#-----------------------------------------------------------------------
# Func: buildfooter()
# Desc: Build the page footer links section.
#-----------------------------------------------------------------------

sub buildfooter
{
	my ($newstr, $synopsis, $mail, $replyto, $pr, $cat);
	$pr       = htmlclean($sfields{'Number'});
	$cat      = htmlclean($sfields{'Category'});
	$synopsis = htmlclean($sfields{'Synopsis'});

	$mail = $header{'from'};
	if ($mail) {
		$mail =~ s/^\s*(.*)\s*$/$1/;
		$mail =~ s/.*<(.*)>.*/$1/;
		$mail =~ s/\s*\(.*\)\s*//;
	}

	$replyto = $header{'reply-to'};
	if ($replyto) {
		$replyto =~ s/^\s*(.*)\s*$/$1/;
		$replyto =~ s/.*<(.*)>.*/$1/;
		$replyto =~ s/\s*\(.*\)\s*//;
	}

	$mail = $replyto if ($replyto);
	$mail .= '@FreeBSD.org' unless ($mail =~ /@/);

	$synopsis =~ s/[^a-zA-Z+.@-]/"%" . sprintf("%02X", unpack("C", $&))/eg;
	$mail     =~ s/[^a-zA-Z+.@-]/"%" . sprintf("%02X", unpack("C", $&))/eg;

	$newstr = "mailto:bug-followup\@FreeBSD.org,${mail}?subject=Re:%20${cat}/${pr}:%20${synopsis}";

	$fmt{'html_footerlinks'} =~ s/%%\(maillink\)/${newstr}/g;

	# Do some other replacements while here

	$fmt{$_} =~ s/%%\(pr\)/${pr}/g
		foreach (keys %fmt);
}


#-----------------------------------------------------------------------
# Func: parsepatches()
# Desc: Parse lines which might contain patches, adding HTML formatting
#       if requested.
#-----------------------------------------------------------------------

{ # Local static variables
my ($outp, $patchnum, $cfound, $lastcol, $lastrev, $context, $mime_boundary);

sub parsepatches
{
	$_ = shift;

	$outp     ||= "";
	$patchnum ||= 0;
	$cfound   ||= 0;
	$context  ||= 0;

	my $plus_s    = '<span class="patch_plusline">';
	my $minus_s   = '<span class="patch_minusline">';
	my $context_s = '<span class="patch_contextline">';
	my $revinfo_s = '<span class="patch_revinfo">';
	my $at_s      = '<span class="patch_hunkinfo">';
	my $all_e     = '</span>';

	my $maxcontext = 3;				# XXX: This ought to be dynamic

	if (!$getpatch) {
		$cfound = ($_ ? 1 : 0) if (!$cfound);
		return 0 if (!$cfound);

		if (!$_) {
			$cfound++;
			return 0;
		} else {
			sprint('break') while (--$cfound > 1);
			$cfound = 1;
		}
	}

	if (/^--(\S+)$/ && $getpatch && !$inpatch) {
		if ($getpatch == $patchnum+1) {
			$mime_boundary = $1;
			return 0;
		}
	}

	if (/^Content-([A-Za-z-]{2,}):\s*(.*)\s*$/i && $getpatch) {
		if (!$inpatch) {
			my $k = lc $1;
			my $v = lc $2;
			if ($getpatch == $patchnum+1 and defined $mime_boundary) {
				if ($k eq "transfer-encoding" && $v =~ /\bbase64\b/) {
					$patchnum++;
					$inpatch |= PATCH_BASE64;
				}
				return 0;
			}
		}
		return 0;
	}

	if (defined $mime_boundary && /^--${mime_boundary}(?:--)?$/ && $getpatch && ($inpatch & PATCH_BASE64)) {
		$inpatch = 0;
		$mime_boundary = undef;
		if ($outp ne "") {
			print decode_base64($outp);
			$outp = "";
		}
		return -1;
	}

	if (($inpatch & PATCH_BASE64) && $getpatch) {
		$outp .= $_;
		return 1;
	}

	if (/^---{1,8}\s?([A-Za-z0-9-_.,:%]+) (begins|starts) here/i && !$inpatch) {
		$patchnum++;
		$inpatch |= PATCH_ANY;
		return 1 if ($getpatch and $patchnum != $getpatch);
		$lastcol = undef;
		$lastrev = undef;

		sprint('patchblock_thead', $patchnum, htmlclean($1))
			unless ($getpatch);

		return 1;
	}

	if (/^((?:(?:---|\*\*\*) (?:\S+)\s*(?:Mon|Tue|Wed|Thu|Fri|Sat|Sun) .*)|(diff -.*? .*? .*)|(Index: \S+)|(\*{3} \d+,\d+ \*{4}))$/ && !$inpatch) {
		$patchnum++;
		$inpatch |= PATCH_DIFF;
		return 1 if ($getpatch and $patchnum != $getpatch);
		$lastcol = undef;
		$lastrev = undef;

		sprint('patchblock_thead', $patchnum, "patch-$patchnum.diff")
			unless ($getpatch);
	}

	if (/^# This is a shell archive\.  Save it in a file, remove anything before/ && !$inpatch) {
		$patchnum++;
		$inpatch |= PATCH_SHAR;
		return 1 if ($getpatch and $patchnum != $getpatch);
		$lastcol = undef;
		$lastrev = undef;

		sprint('patchblock_thead', $patchnum, "patch-$patchnum.shar")
			unless ($getpatch);
	}

	if (/^---{1,8}\s?[A-Za-z0-9-_.,:%]+ ends here/i && ($inpatch & PATCH_ANY)) {
		#$inpatch ^= PATCH_ANY;
		$inpatch = 0;
		$context = 0;
		sprint('patchblock_tfoot')
			unless ($getpatch);

		return (($patchnum == $getpatch) ? -1 : $inpatch)
			if ($getpatch);

		return $inpatch;
	}

	if (/^exit$/ && ($inpatch & PATCH_SHAR)) {
		$inpatch ^= PATCH_SHAR;

		print;
		sprint('patchblock_tfoot') unless ($getpatch);
		return 1;
	}

	if (/^begin \d\d\d (.*)/ && !($inpatch & PATCH_UUENC)) {
		if (!$inpatch) {
			$patchnum++;
			return 1 if ($getpatch and $patchnum != $getpatch);
		}
		sprint('patchblock_thead', $patchnum, "patch-$patchnum.uu")
			unless ($getpatch or $inpatch);

		$inpatch |= PATCH_UUENC;
		$inpatch |= PATCH_UUENC_BIN if ($1 =~ /$binary_filetypes/);
	}

	if ($inpatch) {
		if ($inpatch & PATCH_UUENC) {
			if (!$getpatch or $patchnum == $getpatch) {
				$outp .= "$_\n";
				if (/^end$/) {
					$outp = uudecode($outp)
						unless (!$getpatch and $inpatch & PATCH_UUENC_BIN);
					$outp = htmlclean($outp) unless ($getpatch);
					print $outp;
					$inpatch ^= PATCH_UUENC; $outp = "";
					$inpatch ^= PATCH_UUENC_BIN;

					# No outer container?
					sprint('patchblock_tfoot') if (!$inpatch and !$getpatch);
					return -1;
				}
			}
		} else {
			if (!$getpatch) {
				if (!($inpatch & PATCH_ANY)) {
					if (/^ / or $_ eq "") {
						$context++;
					} else {
						if ($context == $maxcontext and $patchendhint) {
							$context++;
						} else {
							$context = 0;
						}
					}

					if ($context > $maxcontext and $patchendhint) {
						$context = 0;
						# Disabled for now, since it doesn't
						# work quite right.
#						$inpatch = 0;
#						sprint('patchblock_tfoot');
#						print;
#						return 0;
					}
				}

				$_=~ s/$//;

				$_ = htmlclean($_);
				$_ = htmlparse($_);

				while (s/\t/" " x (8 - ((length($`)-1) % 8))/e) {};

				# Obfustication coutesy of cdiff

				s/^(\+.*)$/${plus_s}$1${all_e}/o;
				s/^(-.*)$/${minus_s}$1${all_e}/o
					if !s/^(--- \d+,\d+ ----.*)$/${revinfo_s}$1${all_e}/o;
				s/^(\*\*\* \d+,\d+ *\*\*\*.*)$/${revinfo_s}$1${all_e}/o;
				s/^(\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*)$/${revinfo_s}$1${all_e}/o;
				s/^(!.*)$/${context_s}$1${all_e}/o;
				s/^(@@.*$)/${at_s}$1${all_e}/o;
#				if (/^1.(\d+)(\s+\(\w+\s+\d{2}-\w{3}-\d{2}\):\s)(.*)/) {
#					$lastcol = $lastcol || 0;
#					$lastcol++ if defined($lastrev) && $lastrev != $1;
#					$lastrev = $1;
#					$lastcol %= 6;
#					$_ = "\033[3" . ($lastcol + 1) . "m1.$1$2\033[0m$3\n";
#				}
			}

			if (!$getpatch or $patchnum == $getpatch) {
				print;
				print "\n";
			}
		}
	} else {
		if (!$getpatch) {
			$_ = htmlclean($_);
			$_ = htmlparse($_);
			print;
		}
	}

	return $inpatch;

}

}


# ex: ts=4 sw=4

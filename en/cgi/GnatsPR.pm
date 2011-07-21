#!/usr/bin/perl -Tw
#------------------------------------------------------------------------------
# Copyright (C) 2011, Shaun Amott <shaun@FreeBSD.org>
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
# $FreeBSD: www/en/cgi/GnatsPR.pm,v 1.1 2011/07/20 22:23:23 shaun Exp $
#------------------------------------------------------------------------------

package GnatsPR;

#use MIME::Base64;                      # ports/converters/p5-MIME-Base64
#use MIME::QuotedPrint;                 #
#use Convert::UU qw(uudecode uuencode); # ports/converters/p5-Convert-UU

use GnatsPR::Section::Text;
use GnatsPR::Section::Patch;
use GnatsPR::Section::Email;
use GnatsPR::Section::StateChange;
use GnatsPR::Section::FieldStart;

use GnatsPR::SectionIterator;

use strict;

require 5.006;


#------------------------------------------------------------------------------
# Constants
#------------------------------------------------------------------------------

use constant ENCODING_BASE64 => 1;
use constant ENCODING_QP     => 2;

use constant PATCH_ANY       => 0x0001;
use constant PATCH_DIFF      => 0x0002;
use constant PATCH_UUENC     => 0x0004;
use constant PATCH_UUENC_BIN => 0x0008;
use constant PATCH_SHAR      => 0x0010;
use constant PATCH_BASE64    => 0x0020;


#------------------------------------------------------------------------------
# Func: new()
# Desc: Constructor - Parses data if provided.
#
# Args: [data] - Raw data (or ref. to) from query-pr (optional)
#
# Retn: $self
#------------------------------------------------------------------------------

sub new
{
	my $class = shift;
	my ($data) = @_;

	my $self = {
		blobs_single => {}, # Raw text, single-line fields
		blobs_multi  => {}, # Raw text, multi-line fields
		header       => {}, # E-mail header bits
		sections     => {}, # Hash of arrayrefs of sections
		fromwebform  => 0,  # PR came from the web form?
		numfields    => 0   # Number of fields we have
	};

	bless $self, $class;

	if (defined $data) {
		ref $data
			? $self->Parse($data)
			: $self->Parse(\$data);
	}

	return $self;
}


#------------------------------------------------------------------------------
# Func: Header()
# Desc: Return a value from the header hash.
#
# Args: $key - Header name, case insensitive.
#
# Retn: $val - Value.
#------------------------------------------------------------------------------

sub Header
{
	my $self = shift;
	my ($key) = @_;

	return $self->{header}->{lc $key};
}


#------------------------------------------------------------------------------
# Func: FieldSingle()
# Desc: Return a single line field value.
#
# Args: $key - Field name.
#
# Retn: $val - Value.
#------------------------------------------------------------------------------

sub FieldSingle
{
	my $self = shift;
	my ($key) = @_;

	return $self->{blobs_single}->{$key};
}


#------------------------------------------------------------------------------
# Func: Parse()
# Desc: Parse a blob of text from query-pr into a structured unit for easy
#       manipulation.
#
# Args: \$data - Raw data from query-pr (non-ref scalar is acceptable too).
#
# Retn: n/a
#------------------------------------------------------------------------------

sub Parse
{
	my $self = shift;
	my ($data) = @_;

	my $ismulti = 0;
	my $pastheader = 0;

	# GNATS ensures that > isn't allowed as the first
	# character on a line, except for field headers.
	# Any lines beginning with > will be shunted into
	# 'Unformatted'
	my @fieldblobs = split /\n>/m, $$data;

	# In the rare case the Unformatted field did
	# have some debris, be sure to assemble it back
	# into a complete section.
	while ($fieldblobs[$#fieldblobs] !~ /^Unformatted:/) {
		my $last = pop @fieldblobs;
		exists $fieldblobs[$#fieldblobs] or last;
		$fieldblobs[$#fieldblobs] .= $last;
	}

	foreach my $blob (@fieldblobs) {
		my $key;

		# Parse e-mail header; we only care about a few
		# fields, not the e-mail routing stuff.
		if (!$pastheader) {
			foreach my $line (split /\n/, $blob) {
				if ($line =~ /^(\S+):\s*(.*)$/) {
					my $val = $2;
					$key = lc $1;

					# Ignore multiple defs (e.g. Received: headers)
					exists $self->{header}->{$key}
						and next;

					$self->{header}->{$key} = $val;
				} elsif ($line =~ /^\s+(.*)$/) {
					my $val = $1;

					defined $key
						or next;

					# No field to append to
					exists $self->{header}->{$key}
						or next;

					$self->{header}->{$key} .= "\n$val";
				}
			}

			$pastheader = 1;
			next;
		}

		if ($blob =~ s/^([^:]+):(\n|\s*)//) {
			$key = $1;
			#$ismulti = ($2 and $2 eq "\n");

			# It's multi-liners from here on in
			$key eq 'Description'
				and $ismulti = 1;
		} else {
			# Hmm...
			next;
		}

		# Remove leading/trailing whitespace
		$blob =~ s/^[\n\s]+//;
		$blob =~ s/[\n\s]+$//;

		if ($ismulti) {
			$self->{blobs_multi}->{$key} = $blob;
		} else {
			$self->{blobs_single}->{$key} = $blob;
		}
	}

	$self->{numfields} = scalar @fieldblobs;

	$self->{fromwebform} =
		$self->{header}->{'x-send-pr-version'} =~ /^www-/;

	$self->ParseBlobs();
}


#------------------------------------------------------------------------------
# Func: ParseBlobs()
# Desc: Parse all the raw field "blobs" into section objects.
#
# Args: n/a
#
# Retn: n/a
#------------------------------------------------------------------------------

sub ParseBlobs
{
	my $self = shift;

	foreach my $field (keys %{$self->{blobs_multi}}) {
		$self->{sections}->{$field} = [];

		push @{$self->{sections}->{$field}},
			new GnatsPR::Section::FieldStart($field);

		if ($field eq 'Fix') {
			$self->ParsePatches($field, \($self->{blobs_multi}->{$field}));
			next;
		}

		if ($field eq 'Audit-Trail') {
			# We'll break up the Audit-Trail field by change events.
			# This is the most reliable way to split, although it's far
			# from perfect. We'll then look for e-mail responses inside
			# each chunk for further splitting later.
			#
			# Notes/Caveats:
			# - If someone happened to paste an audit trail event
			#   inside another's "Why" field, it'd break this. I haven't
			#   seen this yet and don't expect to.
			# - The From-To field has to come first. No reason it wouldn't
			#   under normal circumstances.
			# - Pasted e-mails in the Why field will be promoted to
			#   responses, although they often break the GNATS conventions
			#   we (ab)use to find e-mails (e.g.: leading space on message
			#   body lines), which makes this more difficult.
			my @auditevents =
				split /(?=^(?:[A-Za-z_]+)-Changed-From-To: (?:.*?)\s*$)/m,
				$self->{blobs_multi}->{$field};

			foreach my $evt (@auditevents) {
				my $sect = new GnatsPR::Section::StateChange;
				my $gotwhat = 0;
				my $gotsect = 0;
				while ($evt =~ s/^([A-Za-z_]+)-Changed-([A-Za-z_-]+?): (.*?)\s*\n//) {
					my ($what, $key, $val) = ($1, $2, $3);

					if (!$gotwhat) {
						$sect->what($what);
						$gotwhat = 1;
					}

					$gotsect = 1;

					if ($key eq 'From-To') {
						my $fromto = $val;
						if ($fromto =~ /^(.*)->(.*)$/) {
							$sect->from($1);
							$sect->to($2);
						}
					} elsif ($key eq 'When') {
						$sect->when($val);
					} elsif ($key eq 'By') {
						$sect->by($val);
					} elsif ($key eq 'Why') {
						# This is the last one; it's a multi-line
						# field (remainder of the text.)
						last;
					}
				}

				push @{$self->{sections}->{$field}}, $sect
					if ($gotsect);

				# Now look for blocks that appear to be e-mail replies
				# Note: these header fields are the only ones we allow
				#       as the first header; we could feasibly back-
				#       track to find the start of the block (in case
				#       we're not there already), but the more headers
				#       we accept the more likely this will break on
				#       some unexpected content.
				my $next_email = qr/^(From|To|Cc|Subject|Date): (.*)$/m;
				my $gotwhy = 0;

				while ($evt =~ /$next_email/) {
					my $match_start = $-[0];
					my ($header, $body, $indented);
					my $why;

					$match_start > 0
						and $why = substr($evt, 0, $match_start, '');

					if ($gotsect) {
						# We now know where "Why" terminates
						$sect->why($why) if $sect;
					} elsif ($why) {
						# If the first block was a date block,
						# we need to use a text section for the
						# intermediate text instead.
						push @{$self->{sections}->{$field}},
							new GnatsPR::Section::Text($why)
							unless ($why =~ /^[\n\s]+$/);
					}

					$gotwhy = 1;
					$sect = undef;

					# Chop leading blank lines
					$evt =~ s/^\n+//;

					if ($evt =~ /^$/m) {
						# First blank line signals the end of the
						# e-mail header
						$header = substr($evt, 0, $+[0]+1, '');

						# Deciding where the body ends is more
						# difficult...

						# First, let's see if the message is
						# indented (per GNATS standards)
						$indented = ($evt =~ /^ /);

						# If, so, find the next blank line, which
						# signals the body end.
						if ($indented) {
							if ($evt =~ /^$/m) {
								$body = substr($evt, 0, $-[0], '');
							} else {
								$body = $evt;
							}
							$body =~ s/^ //mg; # Remove indent char
						} else {
							# Look for another e-mail block
							if ($evt =~ /$next_email/) {
								$body = substr($evt, 0, $-[0], '');
							} else {
								# Otherwise, use the whole section
								$body = $evt;
							}
						}

						push @{$self->{sections}->{$field}},
							new GnatsPR::Section::Email($header, $body);
					} else {
						# No end-of-header marker: no choice but to
						# dump the (possible) e-mail into the Why field

						if ($gotsect && $sect) {
							$sect->why($evt);
						} elsif ($evt) {
							push @{$self->{sections}->{$field}},
								new GnatsPR::Section::Text($evt);
						}
					}
				}

				# Check for dangling "Why" block
				if (!$gotwhy) {
					if ($gotsect && $sect) {
						$sect->why($evt);
					} elsif ($evt) {
						push @{$self->{sections}->{$field}},
							new GnatsPR::Section::Text($evt);
					}
				}
			}

			next;
		}

		# Everything else is just text
		push @{$self->{sections}->{$field}},
			new GnatsPR::Section::Text($self->{blobs_multi}->{$field});
	}
}


#------------------------------------------------------------------------------
# Func: ParsePatches()
# Desc: Parse the patches out of the given blob of text, emitting Patch and
#       Text sections as appropriate.
#
# Args: $field - Field to push new sections to.
#       \$text - Raw text
#
# Retn: n/a
#------------------------------------------------------------------------------

sub ParsePatches
{
	my $self = shift;
	my ($field, $text) = @_;

	while (my $pi = $self->FindPatchStart($text)) {
		# Everything up to this fragment can be
		# promoted to a text section
		push @{$self->{sections}->{$field}},
			new GnatsPR::Section::Text(substr(
				$$text,
				0,
				$pi->{start},
				''
			))
			unless $pi->{start} == 0;

		$pi->{start} = 0;

		$self->FindPatchEnd($text, $pi);

		# Try to determine if a web/send-pr attachment
		# has another type of patch inside.
		if ($pi->{type} eq 'stdattach' or $pi->{type} eq 'webattach') {
			if (my $pi2 = $self->FindPatchStart($text)) {
				# Upgrade to more specific type
				$pi->{type} = $pi2->{type}
					if ($pi2->{start} == 0);
			}
		}

		push @{$self->{sections}->{$field}},
			new GnatsPR::Section::Patch(substr(
				$$text,
				0,
				$pi->{size},
				''
			), $pi->{name}, $pi->{type});

		$$text =~ s/^[\n\s]+//;
	}

	# Rest of the field is text
	push @{$self->{sections}->{$field}},
		new GnatsPR::Section::Text($$text)
		if ($$text);

	$text = '';
}


#------------------------------------------------------------------------------
# Func: FindPatchStart()
# Desc: Find the beginning of the first patch inside the given text blob,
#       if there is one.
#
# Args: \$text - Raw text
#
# Retn: \%pi   - Hash of patch info (or undef):
#                  - start - Start offset of patch
#                  - type  - Type of attachment found
#                  - name  - Filename, if available
#------------------------------------------------------------------------------

sub FindPatchStart
{
	my $self = shift;
	my ($text) = @_;

	# Patch from web CGI script. Characteristics:
	#   - Only ever one of them.
	#   - Appended to the end of Fix:
	#   - Blank line after header line
	#   - Could contain other types of patch (e.g. shar(1) archive)
	if ($$text =~ /^Patch attached with submission follows:$/m && $self->{fromwebform}) {
		my $start = $+[0]; # The newline on the above

		# Next non-blank line (i.e. start of patch)
		if ($$text =~ /\G^./m) {
			$start += $+[0]+1;
			return {start => $start, type => 'webattach'};
		}

		return undef;
	}

	# Patch from send-pr(1). Characteristics:
	#   - Has header and footer line.
	#   - Appended to the end of Fix:
	#   - User has an opportunity to edit/mangle.
	#   - Could contain other types of patch (e.g. shar(1) archive)
	if ($$text =~ /^---{1,8}\s?([A-Za-z0-9-_.,:%]+) (begins|starts) here\s?---+\n/mi) {
		my $r = {start => $-[0], type => 'stdattach', name => $1};

		# Chop header line
		substr($$text, $-[0], $+[0] - $-[0], '');

		return $r;
	}

	# Patch files from diff(1). Characteristics:
	#   - Easy to find start.
	#   - Difficult to find the end.
	$$text =~ /^((?:(?:---|\*\*\*)\ (?:\S+)\s*(?:Mon|Tue|Wed|Thu|Fri|Sat|Sun)\ .*)
			|(?:(?:---|\*\*\*)\ (?:\S+)\s*(?:\d\d\d\d-\d\d-\d\d\ \d\d:\d\d:\d\d\.\d+)\ .*)
			|(diff\ -.*?\ .*?\ .*)|(Index:\ \S+)
			|(\*{3}\ \d+,\d+\ \*{4}))$/mx
		and return {start => $-[0], type => 'diff'};

	# Shell archive from shar(1)
	$$text =~ /^# This is a shell archive\.  Save it in a file, remove anything before/m
		and return {start => $-[0], type => 'shar'};

	# UUencoded file. Characteristics:
	#   - Has header and footer.
	$$text =~ /^begin \d\d\d (.*)/m
		and return {start => $-[0], type => 'uuencoded'};

	return undef;
}


#------------------------------------------------------------------------------
# Func: FindPatchEnd()
# Desc: Find the end of the first patch inside the given text blob, if any.
#
# Args: \$text - Raw text
#       \%pi   - Patch info hash from FindPatchStart(). We'll add more data:
#                  - size - Length of the patch.
#
# Retn: \%pi   - Same as above, except undef will be returned if no actual
#                endpoint was found (size in pi would extend to the end of the
#                text blob in this case.)
#------------------------------------------------------------------------------

sub FindPatchEnd
{
	my $self = shift;
	my ($text, $pi) = @_;

	$pi->{size} = 0;

	if ($pi->{type} eq 'webattach') {
		$$text =~ /$/
			and $pi->{size} = $+[0];
	} elsif ($pi->{type} eq 'stdattach') {
		$$text =~ /^---{1,8}\s?\Q$pi->{name}\E ends here\s?---+/mi
			and $pi->{size} = $-[0]-1;
		# Chop footer line
		substr($$text, $-[0], $+[0] - $-[0], '');
	} elsif ($pi->{type} eq 'diff') {
		# XXX: could do better
		$$text =~ /^$/m
			and $pi->{size} = $-[0]-1;
	} elsif ($pi->{type} eq 'shar') {
		$$text =~ /^exit$/m
			and $pi->{size} = $+[0];
	} elsif ($pi->{type} eq 'uuencoded') {
		$$text =~ /^end$/m
			and $pi->{size} = $+[0];
	}

	if ($pi->{size} == 0) {
		$pi->{size} = length $$text;
		return undef;
	}

	return $pi;
}


#------------------------------------------------------------------------------
# Func: GetAttachment()
# Desc: Recursively search sections for a downloadable attachment.
#
# Args: $num - Attachment index (counts from 1)
#
# Retn: $sec - Attachment section (or undef)
#------------------------------------------------------------------------------

sub GetAttachment
{
	my $self = shift;
	my ($num) = @_;
	my $cur = 1;

	my $iter = GnatsPR::SectionIterator->new($self, 'Fix', 'Audit-Trail');

	while (my $item = $iter->next()) {
		if (ref $item eq 'GnatsPR::Section::Patch') {
			# Patch sections
			return $item if ($cur++ == $num);
		} elsif (ref $item eq 'GnatsPR::Section::Email') {
			# Attachments from MIME messages
			my $mime_iter = GnatsPR::MIMEIterator->new($item);
			while (my $part = $mime_iter->next()) {
				if ($part->isattachment) {
					return $part if ($cur++ == $num);
				}
			}
		}
	}

	return undef;
}


1;

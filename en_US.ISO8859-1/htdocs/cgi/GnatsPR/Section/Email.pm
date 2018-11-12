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
# $FreeBSD$
#------------------------------------------------------------------------------

package GnatsPR::Section::Email;

use GnatsPR::Section::MIME;

use strict;

require 5.006;


#------------------------------------------------------------------------------
# Func: new()
# Desc: Constructor.
#
# Args: $header - Raw e-mail header.
#       $body   - Raw message body.
#
# Retn: $self
#------------------------------------------------------------------------------

sub new
{
	my $class = shift;
	my ($header, $body) = @_;

	my $self = {
		headerblob => '',
		bodyblob   => '',

		headers    => {},

		mimeparts  => []
	};

	bless $self, $class;

	$self->{headerblob} = $header;
	$self->{bodyblob} = $body;

	$self->ParseHeader() if ($header);
	$self->ParseBody() if ($body);

	return $self;
}


#------------------------------------------------------------------------------
# Func: ParseHeader()
# Desc: Parse header blob into fields.
#
# Args: n/a
#
# Retn: n/a
#------------------------------------------------------------------------------

sub ParseHeader
{
	my $self = shift;

	my $key;

	foreach my $line (split /\n/, $self->{headerblob}) {
		if ($line =~ /^(\S+):\s*(.*)$/) {
			my $val = $2;
			$key = lc $1;

			# Ignore multiple defs (e.g. Received: headers)
			exists $self->{headers}->{$key}
				and next;

			$self->{headers}->{$key} = $val;
		} elsif ($line =~ /^\s*(.*)$/) {
			my $val = $1;

			defined $key
				or next;

			# No field to append to
			exists $self->{headers}->{$key}
				or next;

			$self->{headers}->{$key} .= ' '.$val;
		}
	}
}


#------------------------------------------------------------------------------
# Func: ParseBody()
# Desc: Parse body blob.
#
# Args: n/a
#
# Retn: n/a
#------------------------------------------------------------------------------

sub ParseBody
{
	# XXX: recurse to second-level parts

	my $self = shift;

	$self->{mimeparts} = [];

	# First of all - attempt to split into MIME parts
	# Note that since GNATS nukes a bunch of the headers
	# that we need, this is purely of a heuristic nature.

	# Technically less permissive than RFC1341

	my $nextbound = qr/^--([A-Za-z0-9'()+_,-.\/:=?]{6,70})$/m;
	my $first = 1;

	while ($self->{bodyblob} =~ s/$nextbound//m) {
		my $last;

		if ($first) {
			my $boundary = $1;
			$nextbound = qr/^--\Q$boundary\E(--)?$/m;
			$last = 0;
			$first = 0;
		} else {
			$last = ($2 and $2 eq '--');
		}

		# Promote to MIME part

		push @{$self->{mimeparts}},
			new GnatsPR::Section::MIME(
				substr($self->{bodyblob}, 0, $-[0], '')
			)
			unless ($-[0] == 0);
	}

	if (!@{$self->{mimeparts}}) {
		# No parts - just plain text
		push @{$self->{mimeparts}},
			new GnatsPR::Section::MIME($self->{bodyblob});
	}
}


#------------------------------------------------------------------------------
# Func: Header()
# Desc: Return a header field.
#
# Args: $key - Header name, case insensitive.
#
# Retn: $val - Value.
#------------------------------------------------------------------------------

sub Header
{
	my $self = shift;
	my ($key) = @_;

	return $self->{headers}->{lc $key};
}


1;

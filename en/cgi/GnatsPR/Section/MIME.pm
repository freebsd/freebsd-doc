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
# $FreeBSD: www/en/cgi/GnatsPR/Section/MIME.pm,v 1.1 2011/07/20 22:23:23 shaun Exp $
#------------------------------------------------------------------------------

package GnatsPR::Section::MIME;

use MIME::Base64;                      # ports/converters/p5-MIME-Base64
use MIME::QuotedPrint;                 #
use Convert::UU qw(uudecode uuencode); # ports/converters/p5-Convert-UU

use Encode;

use strict;

require 5.006;


#------------------------------------------------------------------------------
# Func: new()
# Desc: Constructor.
#
# Args: $blob - Raw MIME part, inc. any headers.
#
# Retn: $self
#------------------------------------------------------------------------------

sub new
{
	my $class = shift;
	my ($blob) = @_;

	my $self = {
		body         => '',
		decoded_body => '',
		headers      => {},
		binary       => 0,
		encoded      => 0,
		attachment   => 0,
		filename     => '',
		mimeparts    => []   # Sub parts (usually empty)
	};

	bless $self, $class;

	$self->{body} = $blob;

	$self->Parse() if ($blob);

	return $self;
}


#------------------------------------------------------------------------------
# Accessors
#------------------------------------------------------------------------------

sub body
{
	my $self = shift;
	$self->{body} = $_[0] if @_;
	return $self->{body};
}

sub isbinary
{
	my $self = shift;
	return $self->{binary};
}

sub isencoded
{
	my $self = shift;
	return $self->{encoded};
}

sub isattachment
{
	my $self = shift;
	return $self->{attachment};
}

sub filename
{
	my $self = shift;
	return $self->{filename};
}

sub data
{
	my $self = shift;
	return $self->{encoded} ? $self->{decoded_body} : $self->{body};
}

sub size
{
	my $self = shift;
	return length($self->{encoded} ? $self->{decoded_body} : $self->{body});
}


#------------------------------------------------------------------------------
# Func: Parse()
# Desc: Parse and decode raw MIME part.
#
# Args: n/a
#
# Retn: n/a
#------------------------------------------------------------------------------

sub Parse
{
	my $self = shift;

	my $charset;

	$self->{body} =~ s/^[\n\s]+//;
	$self->{body} =~ s/[\n\s]+$/\n/;

	$self->ParseHeader();

	# Determine if we're a multi-part container
	if (lc $self->header('content-type') =~ /multipart/
			and $self->header('content-type:boundary')) {
		my $bound = $self->header('content-type:boundary');
		@{$self->{mimeparts}} =
			map {
				new GnatsPR::Section::MIME($_);
			}
			grep !/^[\n\s]*$/,
			split /^--\Q$bound\E(?:--)?$/m, $self->{body};
		$self->{body} = undef;
		return;
	}

	if ($self->header('content-type:charset')) {
		my $cs = $self->header('content-type:charset');

		if ($cs =~ /utf.*8/i) {
			$cs = 'utf-8';
		} else {
			$cs = Encode::resolve_alias($cs);
		}

		if ($cs and $cs ne 'ascii') {
			$charset = $cs;
		}
	}

	# Look for Quoted-Printable (explicit or using a silly heuristic)
	if (lc $self->header('content-transfer-encoding') eq 'quoted-printable'
			or $self->{body} =~ /=[0-9A-Fa-f]{2}=[0-9A-Fa-f]{2}/) {
		$self->{body} = decode_qp($self->{body});
		$self->{body} = decode($charset, $self->{body})
			if ($charset);

	# Base64 -- probably better not to decode
	} elsif (lc $self->header('content-transfer-encoding') eq 'base64') {
		$self->{decoded_body} = decode_base64($self->{body});
		$self->{decoded_body} = decode($charset, $self->{decoded_body})
			if ($charset);
		$self->{encoded} = 1;
	}

	# Catches too much stuff that we can display
	#if ($self->header('content-type')
	#		&& $self->header('content-type') !~ 'text/') {
	#	$self->{binary} = 1;
	#}

	if (lc $self->header('content-disposition') eq 'attachment') {
		my $filename =
			$self->header('content-disposition:filename')
			|| $self->header('content-type:name')
			|| $self->header('x-attachment-id')
			|| 'attachment';

		$filename =~ '(?:\.gz|\.bz2|\.zip|\.tar)$'
			and $self->{binary} = 1;

		$self->{attachment} = 1;
		$self->{filename} = $filename;
	}

	if ($self->{body} =~ /^begin \d\d\d (.*)/ && !$self->{encoded}) {
		$self->{decoded_body} = uudecode($self->{body});
		$self->{encoded} = 1;
	}
}


#------------------------------------------------------------------------------
# Func: ParseHeader()
# Desc: Parse out any MIME header fields.
#
# Args: n/a
#
# Retn: n/a
#------------------------------------------------------------------------------

sub ParseHeader
{
	my $self = shift;
	my $header = '';
	my $key;

	# Start with some defaults
	$self->{headers}->{'content-type'} = 'text/plain';

	# No header?
	$self->{body} =~ /^Content-/i
		or return;

	# Ensure we have an end-of-header marker. Returning here
	# will result in some bodyless headers being dumped as
	# text (example in conf/138672) -- but I think this is
	# the safe option, in case such a header is in fact the
	# body of a malformed message.
	$self->{body} =~ /^$/m and $+[0] != length($self->{body}) or return;

	$header = substr($self->{body}, 0, $+[0]+1, '');

	$self->{body} =~ s/^[\n\s]+//;

	foreach my $line (split /\n/, $header) {
		if ($line =~ /^(\S+): (.*)$/) {
			$key = lc $1;
			$self->{headers}->{$key} = $2;
		} elsif ($line =~ /^\s+(.*)$/) {
			$key or next;
			$self->{headers}->{$key} .= ' ' . $1;
		}
	}

	# Split up aggregate headers into individual values

	foreach my $key (keys %{$self->{headers}}) {
		$self->{headers}->{$key} =~ /;/ or next;

		my @chars = split //, $self->{headers}->{$key};
		my $inquote = 0;
		my $gotkey = 0;
		my $k = '';
		my $v = '';

		foreach my $char (@chars) {
			if ($char eq '"') {
				$inquote = !$inquote;
				next;
			} elsif ($char eq '=' && !$inquote) {
				$gotkey = 1;
				next;
			} elsif ($char eq ';' && !$inquote) {
				if ($k and $v) {
					$k = lc $k;
					$self->{headers}->{"$key:$k"} = $v;
				}
				$k = $v = '';
				$gotkey = 0;
				next;
			} elsif (($char eq ' ' or $char eq '\t') && !$inquote) {
				next;
			}

			if ($gotkey) {
				$v .= $char;
			} else {
				$k .= $char;
			}
		}

		if ($k and $v) {
			$k = lc $k;
			$self->{headers}->{"$key:$k"} = $v;
		}

		$self->{headers}->{$key} =~ s/;.*$//;
	}
}


#------------------------------------------------------------------------------
# Func: header()
# Desc: Return header.
#
# Args: $key
#
# Retn: $val
#------------------------------------------------------------------------------

sub header
{
	my $self = shift;
	my ($key) = @_;

	$key = lc $key;

	return $self->{headers}->{$key}
		if (exists $self->{headers}->{$key});

	return '';
}


1;

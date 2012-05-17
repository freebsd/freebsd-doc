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

package GnatsPR::Section::StateChange;

use strict;

require 5.006;


#------------------------------------------------------------------------------
# Func: new()
# Desc: Constructor.
#
# Args: n/a
#
# Retn: $self
#------------------------------------------------------------------------------

sub new
{
	my $class = shift;

	my $self = {
		what => '', # State or Responsible
		from => '', # Change from
		to   => '', # Change to
		why  => '', # Reason for change
		when => '', # Date of change
		by   => ''  # Who changed it
	};

	bless $self, $class;

	return $self;
}


#------------------------------------------------------------------------------
# Accessors
#------------------------------------------------------------------------------

sub what
{
	my $self = shift;
	$self->{what} = $_[0] if @_;
	return $self->{what};
}

sub from
{
	my $self = shift;
	$self->{from} = $_[0] if @_;
	return $self->{from};
}

sub to
{
	my $self = shift;
	$self->{to} = $_[0] if @_;
	return $self->{to};
}

sub why
{
	my $self = shift;

	if (scalar @_) {
		$self->{why} = $_[0];
		$self->{why} =~ s/^\s+//;
		$self->{why} =~ s/[\n\s]+$//;
	}
	return $self->{why};
}

sub when
{
	my $self = shift;
	$self->{when} = $_[0] if @_;
	return $self->{when};
}

sub by
{
	my $self = shift;
	$self->{by} = $_[0] if @_;
	return $self->{by};
}


1;

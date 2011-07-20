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

package GnatsPR::SectionIterator;

use strict;

require 5.006;


#------------------------------------------------------------------------------
# Func: new()
# Desc: Constructor.
#
# Args: $gnatspr - GnatsPR instance.
#       @fields  - Which fields we want sections from. The order determines
#                  the order of the returned sections. Undefined behaviour if
#                  no no fields specified.
#
# Retn: $self
#------------------------------------------------------------------------------

sub new
{
	my $class = shift;
	my $gnatspr = shift;

	my $self = {
		gnatspr     => $gnatspr,
		currfield   => -1,
		currsection => -1,
		wantfields  => []
	};

	bless $self, $class;

	while (my $f = shift) {
		push @{$self->{wantfields}}, $f;
	}

	return $self;
}


#------------------------------------------------------------------------------
# Func: next()
# Desc: Return next iterator element.
#
# Args: n/a
#
# Retn: $next
#------------------------------------------------------------------------------

sub next
{
	my $self = shift;
	my ($fieldkey, $maxsection);

	# Next section
	$self->{currsection}++;

	# First field?
	$self->{currfield} == -1
		and $self->{currfield} = 0;

	$fieldkey = $self->{wantfields}->[$self->{currfield}];
	$maxsection = $#{$self->{gnatspr}->{sections}->{$fieldkey}};

	# We've passed the last section in this field
	while ($self->{currsection} > $maxsection) {
		# Next field, first section
		$self->{currfield}++;
		$self->{currsection} = 0;

		# Run out of fields?
		$self->{currfield} > $#{$self->{wantfields}}
			and return undef;

		# Update, and go back to check next field
		$fieldkey = $self->{wantfields}->[$self->{currfield}];
		$maxsection = $#{$self->{gnatspr}->{sections}->{$fieldkey}};
	}

	return $self->{gnatspr}->{sections}->{$fieldkey}->[$self->{currsection}];
}


1;

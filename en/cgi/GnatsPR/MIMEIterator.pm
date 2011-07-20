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

package GnatsPR::MIMEIterator;

use strict;

require 5.006;


#------------------------------------------------------------------------------
# Func: new()
# Desc: Constructor.
#
# Args: $email - GnatsPR::Section::Email instance.
#
# Retn: $self
#------------------------------------------------------------------------------

sub new
{
	my $class = shift;
	my $email = shift;

	my $self = {
		idxlist => [ -1 ],
		email   => undef
	};

	bless $self, $class;

	$self->{email} = $email;

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

	my $curr = $self->_current();

	while (1) {
		my $next = ++$self->{idxlist}->[$#{$self->{idxlist}}];

		# Past last element?
		if ($next > $#{$curr->{mimeparts}}) {
			# Back out
			pop @{$self->{idxlist}};

			# Reached the root
			$#{$self->{idxlist}} > -1
				or return undef;

			$curr = $self->_current();
			next;
		}

		last;
	}

	my $rpart = $curr->{mimeparts}->[$self->{idxlist}->[$#{$self->{idxlist}}]];

	# Container part? - find a leaf node
	while ($#{$rpart->{mimeparts}} > -1) {
		$rpart = $rpart->{mimeparts}->[0];
		push @{$self->{idxlist}}, 0;
	}

	return $rpart;
}


#------------------------------------------------------------------------------
# Func: isfirst()
# Desc: Determine if the iterator is at the first element.
#
# Args: n/a
#
# Retn: $isfirst - true/false
#------------------------------------------------------------------------------

sub isfirst
{
	my $self = shift;

	return (
		$#{$self->{idxlist}} == 0
		and $self->{idxlist}->[$#{$self->{idxlist}}] == 0
	);
}


#------------------------------------------------------------------------------
# Func: _current()
# Desc: Traverse to, and return, the current container element.
#
# Args: n/a
#
# Retn: $curr
#------------------------------------------------------------------------------

sub _current
{
	my $self = shift;
	my $curr = $self->{email};

	# Find current MIME part container
	for (my $depth = 0; $depth < $#{$self->{idxlist}}; $depth++) {
		$curr = $curr->{mimeparts}->[$self->{idxlist}->[$depth]];
	}

	return $curr;
}


1;

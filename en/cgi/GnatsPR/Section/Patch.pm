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

package GnatsPR::Section::Patch;

use strict;

require 5.006;


#------------------------------------------------------------------------------
# Func: new()
# Desc: Constructor.
#
# Args: $text     - Blob of text.
#       $filename - Filename of patch, if we have one.
#       $type     - Patch type string (if known).
#
# Retn: $self
#------------------------------------------------------------------------------

sub new
{
	my $class = shift;
	my ($text, $filename, $type) = @_;

	my $self = {
		text     => '',
		filename => 'patch.txt',
		type     => 'unknown'
	};

	bless $self, $class;

	$self->{text} = $text;

	$self->{filename} = $filename if $filename;
	$self->{type} = $type if $type;

	return $self;
}


#------------------------------------------------------------------------------
# Func: string()
# Desc: Return string contained within.
#
# Args: n/a
#
# Retn: $string
#------------------------------------------------------------------------------

sub string
{
	my $self = shift;

	return $self->{text};
}


#------------------------------------------------------------------------------
# Func: size()
# Desc: Return the length of the contained data.
#
# Args: n/a
#
# Retn: $string
#------------------------------------------------------------------------------

sub size
{
	my $self = shift;

	return length($self->{text});
}


#------------------------------------------------------------------------------
# Func: data()
# Desc: Return the raw decoded (if possible/necessary) data.
#
# Args: n/a
#
# Retn: $string
#------------------------------------------------------------------------------

sub data
{
	my $self = shift;

	return $self->{text};
}


#------------------------------------------------------------------------------
# Func: filename()
# Desc: Return the patch's filename.
#
# Args: n/a
#
# Retn: $filename
#------------------------------------------------------------------------------

sub filename
{
	my $self = shift;

	return $self->{filename};
}


#------------------------------------------------------------------------------
# Func: type()
# Desc: Return the patch's type.
#
# Args: n/a
#
# Retn: $type
#------------------------------------------------------------------------------

sub type
{
	my $self = shift;

	return $self->{type};
}


#------------------------------------------------------------------------------
# Func: isbinary()
# Desc: Is patch binary?
#
# Args: n/a
#
# Retn: $type
#------------------------------------------------------------------------------

sub isbinary
{
	my $self = shift;

	return 0;
}


1;

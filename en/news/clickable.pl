#!/usr/bin/perl -np
# Copyright (c) Juli 1998 Wolfram Schneider <wosch@FreeBSD.org>. Berlin.
#
# clickable - Make URL clickable
#
# $FreeBSD$

s/</&lt;/g;
s%((http|ftp)://[^\s"\)\>,;]+)%<A HREF="$1">$1</A>%gi;

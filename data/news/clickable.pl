#!/usr/bin/perl -np
# Copyright (c) Juli 1998 Wolfram Schneider <wosch@FreeBSD.org>. Berlin.
#
# clickable - Make URL clickable
#
# $Id: clickable.pl,v 1.1 1998-07-15 12:50:56 wosch Exp $

s/</&lt;/g;
s%((http|ftp)://[^\s"\)\>,;]+)%<A HREF="$1">$1</A>%gi;

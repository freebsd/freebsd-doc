#!/usr/bin/perl -np
# Copyright (c) Juli 1998 Wolfram Schneider <wosch@FreeBSD.org>. Berlin.
#
# clickable - Make URL clickable
#
# $Id: clickable.pl,v 1.1.1.1 1999-02-08 19:26:11 wosch Exp $

s/</&lt;/g;
s%((http|ftp)://[^\s"\)\>,;]+)%<A HREF="$1">$1</A>%gi;

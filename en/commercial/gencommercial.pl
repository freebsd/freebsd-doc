#!/usr/local/bin/perl

#######################################################################
# gencommercial.pl - 
#
# A utility to help create FreeBSD's commercial gallery SGML files.
# Processes "raw" data kept as raw files, one ".raw" file for each
# commercial category (currently consulting, hardware, misc, and
# software). A description file (by default, ./commercial.desc)
# contains the definitions for each of the categories and its
# sub-categories. 
#
# Depending upon the flags passed on the command line (-a or -c), 
# this program creates an include file with a list of entries either 
# sorted alphabetically (-a or default) or by (sub-)category (-c.) 
# There is also a verbose option good for debugging (-v). The out-
# put is suitable for inclusion into the gallery SMGL files.
#
# XXX The -v (verbose) option currently does not exist.
#
# This utility outputs to a file called either (category).inc
# or (category)_bycat.inc respective to the -a or -c option.
#
# Author: Ade Barkah (mbarkah@FreeBSD.ORG)
#
# (c) 1999 by The FreeBSD Project, Inc. All Rights Reserved.
# This program is made available to the general public under
# the "BSD-style copyright" terms of agreement.
#
# $FreeBSD$

#######################################################################
## Configuration Section
#######################################################################

# The $description_file contains the definitions for each Category
# and Sub-category.

$description_file = "./commercial.desc";

# If you want to change the output file naming convention,
# modify the two lines below.

$alpha_suffix  = ".inc";
$subcat_suffix = "_bycat.inc";

# IMPORTANT!
# The program will only attempt to index by the following list.
# In particular, if you have entries beginning with a character
# other than ones listed here, you need modify this list.

@index_list = qw(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z);

#######################################################################
# You should not need to modify anything below this line.
#######################################################################

require 5.001;

# Parse the command line 

sub usage_exit {
   print STDERR "Usage: gencommercial.pl [-ac] category\n";
   exit (1);
}

use Getopt::Long;
 
$good_result = GetOptions ("alphabetical" => \$opt_alpha, 
                           "categorical"  => \$opt_cat);
&usage_exit() if (not $good_result);
&usage_exit() if (@ARGV != 1);
$opt_alpha = 1 if (! $opt_alpha && ! $opt_cat );   # -a is default;
$category = $ARGV[0];

#######################################################################
# Now, we parse the description file.
#
# We iterate through each line in the .desc file until we find the
# CATEGORY description matching the category specified on the command 
# line. If found, then we save its short and long descriptions and
# continue iterating through the file, reading the CATEGORY's
# SUBCAT descriptions (if any) and DEFAULT_SUBCAT (if any.) We
# continue either until we find another CATEGORY header ($finish
# is set) or until the end of the file.
#
# Formats:
#
# CATEGORY="category" SHORT="short_description" LONG="long_description"
# SUBCAT="sub-category" DESCRIPTION="description"
# DEFAULT_SUBCAT="sub-category"
#
# A '#' at the *beginning* of a line marks a comment. 

if (open (DESC, "< $description_file") == 0)
{
   print "ERROR: Unable to open $description_file file.\n";
   print "ERROR: $!. Exiting.\n";
   exit 1;
}

$finish = 0;
$in_cat = 0;
while ((! $finish) && ($_ = <DESC>))
{
   next if ((/^#/) || (/^$/));      # Skip comments and empty lines

   if ( m{\s*CATEGORY\s*=\s*"\s*(.+)\s*"   # $1 = CATEGORY
      \s*SHORT\s*=\s*"\s*(.+)\s*"          # $2 = SHORT (description)
      \s*LONG\s*=\s*"\s*(.+)\s*" }xio )    # $3 = LONG (description)
   {
      if ($in_cat)
      {
         $finish = 1;
      }
      else
      {
         $short = $2;
         $long = $3;

         if ($1 =~ /^($category)$/io)    # category == the one we want?
         {
            $short_cat = $short;         # Yes, save the descriptions
            $long_cat = $long;
            $in_cat = 1;
         }
      }
   }
   else
   {
      next if (! $in_cat);

      if (/DEFAULT_SUBCAT\s*=\s*"\s*(.+)\s*"/)
      {
         $default_subcat = $1;
      }
      elsif (   m{\s*SUBCAT\s*=\s*"\s*(.+)\s*"
                \s*DESCRIPTION\s*=\s*"\s*(.+)\s*"}xio )
      {
         $subcat = $1;
         $subcat =~ tr/a-z/A-Z/;       # Make uppercase
         $subcats{$1} = $2;            # Store descriptions in hash
      }
   }
}

close (DESC);

# We've read in the file, so let's do some sanity checking. For example, 
# make sure the category is actually valid.

if ($in_cat == 0)
{
   print "ERROR: Category $category is not in description file.\n";
   print "ERROR: Exiting.\n";
   exit 1;
}

# If %subcats == 0, then this CATEGORY does not have any sub-categories,
# which is fine. However, if $default_subcat is defined, but the subcat
# doesn't actually exist, we scream and quit.

if (%subcats == 0)
{
   if ($opt_cat)
   {
      print "ERROR: -c option specified, but category has no subcategories.\n";
      print "ERROR: Exiting.\n";
      exit 1;
   }
   $default_subcat = "DEFAULT";
}
else
{
   if ($subcats{$default_subcat} eq "") 
   {
      print "ERROR: Default subcategory $default_subcat has no description.\n";
      print "ERROR: Exiting.\n";
      exit 1;
   }
}

#######################################################################
# Things look in order so far, so we'll read in the .raw file. Each 
# entry begins with a header that looks like below:
#
# <--! NAME="entry_name" CAT="entry_category" SUBCAT="sub-category"-->
#
# Anything before the first header is treated as comment, everything
# else is treated as part of an entry. The $first_time flag below
# marks if we've seen a header or not.
#
# In this version, the CATEGORY is actually determined by the name
# of the .raw file, so it is not used.

if (open (RAW, "< ${category}.raw") == 0)
{
   print "ERROR: Unable to open ${category}.raw file.\n";
   print "ERROR: $!. Exiting.\n";
   exit 1;
}

$first_time = 1;
$entry_text = "";
while (<RAW>)
{
   next if (/^$/);

   if (   m{<!--\s*NAME\s*=\s*"\s*(.+)\s*"   # $1 = NAME
         .*CAT
         .*SUBCAT\s*=\s*"\s*(.*)\s*"         # $2 = SUBCAT
         \s*-->}xio )
   {
      if ($first_time == 0)
      {
         $entries {"$entry_name"} = "$entry_subcat|$entry_text";
         $entry_text = "";
      }
      $entry_name = $1;
      $entry_subcat = $2;
      $entry_subcat =~ tr/a-z/A-Z/;
      if ($subcats{$entry_subcat} eq "")
      {
         $entry_subcat = $default_subcat;
      }
      $first_time = 0;
   }
   else
   {
      $entry_text = "${entry_text}$_" if (not $first_time);
   }
}
if ($first_time == 0)
{
   $entries {"$entry_name"} = "$entry_subcat|$entry_text";
}

close (RAW);

#######################################################################
# Generate alphabetical output if necessary. We first build a
# $list_string containing a unique list of the first letters of
# each entry. Then we compare this string to @index_list and
# create the alphabetical index. Then we simply output the
# entries in key sorted order.

if ($opt_alpha)
{
   if (open (OUTFILE, "> ${category}${alpha_suffix}") == 0)
   {
      print "ERROR: Unable to open ${category}${alpha_suffix}.\n";
      print "ERROR: $!. Exiting.\n";
      exit 1;
   }

   print OUTFILE "<!-- WARNING! THIS FILE IS MACHINE GENERATED -->\n";
   print OUTFILE "<!-- DO NOT EDIT BY HAND!                    -->\n\n";

   # Build unique first-letter list

   @index = ();
   $first_letter = "";
   $list_string = "";
   foreach $entry (sort keys %entries)
   {
      if ($first_letter ne substr($entry, 0, 1))
      {
         $first_letter = uc(substr($entry, 0, 1));      # Ignore case
         $list_string = "$list_string$first_letter";
      }
   }

   # Output alphabetical index

   print OUTFILE "<HR WIDTH=\"75%\">\n\n<CENTER>\n";
   foreach $letter (@index_list)
   {
      if ($list_string =~ /$letter/)
      {
         print OUTFILE "<A HREF=\"#LETTER_$letter\">$letter</A>\n";
      }
      else
      {
         print OUTFILE "$letter\n";
      }
   }
   print OUTFILE "</CENTER>\n\n<HR WIDTH=\"75%\">\n\n";

   # Output entries in key sort order, fold case

   print OUTFILE "<UL>\n";
   $first_letter = "";
   foreach $entry (sort { uc($a) cmp uc($b); } keys %entries)
   {
      print OUTFILE "<LI>";
      if ($first_letter ne substr($entry, 0, 1))
      {
         $first_letter = substr($entry, 0, 1);
         print OUTFILE "\n<A NAME=\"LETTER_$first_letter\"></A>\n\n";
      }
      $link = $entry;
      $link =~ tr/ /_/;
      $text = $entries{$entry};
      $text =~ /\|(.*)$/os;
      print OUTFILE "<A NAME=\"$link\"></A>\n";
      print OUTFILE "$1<P></P></LI>\n\n";
   }
   print OUTFILE "</UL>\n";

   # Ok, we're done.

   close (OUTFILE);
}

#######################################################################
# Generate output by category if necessary. We actually output an
# index to the alphabetical HTML file, which we assume to be called
# ${category}.html. The procedure is inefficient but simple.  We use a 
# double-loop to iterate through each subcategory, and through each 
# entry, so we're looking at O(n^2).  Considering the size of the
# raw files, however, this method is still very fast.

if ($opt_cat)
{
   if (open (OUTFILE, "> ${category}${subcat_suffix}") == 0)
   {
      print "ERROR: Unable to open ${category}${subcat_suffix}.\n";
      print "ERROR: $!. Exiting.\n";
      exit 1;
   }

   print OUTFILE "<!-- WARNING! THIS FILE IS MACHINE GENERATED -->\n";
   print OUTFILE "<!-- DO NOT EDIT BY HAND!                    -->\n\n";

   # The following sort is by description (VALUE), not KEY
   foreach $subcat (sort {uc($subcats{$a}) cmp uc($subcats{$b});} keys %subcats)
   {
      print OUTFILE "<A NAME=\"CATEGORY_$subcat\"></A>\n";
      print OUTFILE "<H3>$subcats{$subcat}</H3>\n\n<UL>\n";

      # Here sorting by KEY is what we want.
      foreach $entry (sort { uc($a) cmp uc($b); } keys %entries)
      {
         $text = $entries {$entry};
         $text =~ /^\s*(.+)\s*\|(.*)/o;
         if ($1 eq $subcat)
         {
            $link = $entry;
            $link =~ tr/ /_/;
            print OUTFILE "<LI><A HREF=\"${category}.html#$link\">$entry</A>\n";
         }
      }

      print OUTFILE "</UL>\n\n";
   }

   close (OUTFILE);
}

#######################################################################
# Done!

exit 0;

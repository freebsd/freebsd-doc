#!/usr/bin/perl -wT
#
# cvsweb - a CGI interface to CVS trees.
#
# Written in their spare time by
#             Bill Fenner      <fenner@FreeBSD.org>   (original work)
# extended by Henner Zeller    <zeller@think.de>,
#             Henrik Nordstrom <hno@hem.passagen.se>
#             Ken Coar         <coar@Apache.Org>
#             Dick Balaska     <dick@buckosoft.com>
#             Akinori MUSHA    <knu@FreeBSD.org>
#             Jens-Uwe Mager   <jum@helios.de>
#
# Based on:
# * Bill Fenners cvsweb.cgi revision 1.28 available from:
#   http://www.FreeBSD.org/cgi/cvsweb.cgi/www/en/cgi/cvsweb.cgi
#
# Copyright (c) 1996-1998 Bill Fenner
#           (c) 1998-1999 Henner Zeller
#	    (c) 1999      Henrik Nordstrom
#	    (c) 2000-2001 Akinori MUSHA
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
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $Id: cvsweb.cgi,v 1.71 2001-05-07 17:20:40 knu Exp $
# $Idaemons: /home/cvs/cvsweb/cvsweb.cgi,v 1.71 2001/05/07 17:13:42 knu Exp $
# $FreeBSD: www/en/cgi/cvsweb.cgi,v 1.70 2001/03/27 17:26:31 knu Exp $
#
###

require 5.000;

use strict;

use vars qw (
    $cvsweb_revision
    $mydir $uname $config $allow_version_select $verbose
    @CVSrepositories @CVSROOT %CVSROOT %CVSROOTdescr
    %MIRRORS %DEFAULTVALUE %ICONS %MTYPES
    @DIFFTYPES %DIFFTYPES @LOGSORTKEYS %LOGSORTKEYS
    %alltags @tabcolors %fileinfo %tags @branchnames %nameprinted
    %symrev %revsym @allrevisions %date %author @revdisplayorder
    @revisions %state %difflines %log %branchpoint @revorder
    $prcgi @prcategories $re_prcategories $prkeyword $re_prkeyword $mancgi
    $checkoutMagic $doCheckout $scriptname $scriptwhere
    $where $pathinfo $Browser $nofilelinks $maycompress @stickyvars
    %funcline_regexp $is_mod_perl
    $is_links $is_lynx $is_w3m $is_msie $is_mozilla3 $is_textbased
    %input $query $barequery $sortby $bydate $byrev $byauthor
    $bylog $byfile $defaultDiffType $logsort $cvstree $cvsroot
    $mimetype $charset $defaultTextPlain $defaultViewable
    $command_path %CMD $allow_compress
    $backicon $diricon $fileicon
    $fullname $newname $cvstreedefault
    $body_tag $body_tag_for_src $logo $defaulttitle $address
    $long_intro $short_instruction $shortLogLen
    $show_author $dirtable $tablepadding $columnHeaderColorDefault
    $columnHeaderColorSorted $hr_breakable $showfunc $hr_ignwhite
    $hr_ignkeysubst $diffcolorHeading $diffcolorEmpty $diffcolorRemove
    $diffcolorChange $diffcolorAdd $diffcolorDarkChange $difffontface
    $difffontsize $inputTextSize $mime_types $allow_annotate
    $allow_markup $use_java_script $open_extern_window
    $extern_window_width $extern_window_height $edit_option_form
    $show_subdir_lastmod $show_log_in_markup $preformat_in_markup $v
    $navigationHeaderColor $tableBorderColor $markupLogColor
    $tabstop $state $annTable $sel $curbranch @HideModules
    $module $use_descriptions %descriptions @mytz $dwhere $moddate
    $use_moddate $has_zlib $gzip_open
    $allow_tar @tar_options @gzip_options @cvs_options
    $LOG_FILESEPARATOR $LOG_REVSEPARATOR
);

sub printDiffSelect($);
sub printDiffLinks($$);
sub printLogSortSelect($);
sub findLastModifiedSubdirs(@);
sub htmlify_sub(&$);
sub htmlify($;$);
sub spacedHtmlText($;$);
sub link($$);
sub revcmp($$);
sub fatal($$);
sub redirect($);
sub safeglob($);
sub search_path($);
sub getMimeTypeFromSuffix($);
sub head($;$);
sub scan_directives(@);
sub doAnnotate($$);
sub doCheckout($$);
sub cvswebMarkup($$$);
sub viewable($);
sub doDiff($$$$$$);
sub getDirLogs($$@);
sub readLog($;$);
sub printLog($;$);
sub doLog($);
sub flush_diff_rows($$$$);
sub human_readable_diff($);
sub navigateHeader($$$$$);
sub plural_write($$);
sub readableTime($$);
sub clickablePath($$);
sub chooseCVSRoot();
sub chooseMirror();
sub fileSortCmp();
sub download_url($$;$);
sub download_link($$$;$);
sub toggleQuery($$);
sub urlencode($);
sub htmlquote($);
sub htmlunquote($);
sub hrefquote($);
sub http_header(;$);
sub html_header($);
sub html_footer();
sub link_tags($);
sub forbidden_module($);

##### Start of Configuration Area ########
delete $ENV{PATH};

$cvsweb_revision = '1.106' . '.' . (split(/ /,
 q$Idaemons: /home/cvs/cvsweb/cvsweb.cgi,v 1.71 2001/05/07 17:13:42 knu Exp $
))[2];

use File::Basename;

($mydir) = (dirname($0) =~ /(.*)/); # untaint

# == EDIT this ==
# Locations to search for user configuration, in order:
for (
     "$mydir/cvsweb.conf",
     '/usr/local/etc/cvsweb/cvsweb.conf'
    ) {
    if (defined($_) && -r $_) {
	$config = $_;
	last;
    }
}

# == Configuration defaults ==
# Defaults for configuration variables that shouldn't need
# to be configured..
$allow_version_select = 1;

##### End of Configuration Area   ########

######## Configuration variables #########
# These are defined to allow checking with perl -cw
@CVSrepositories = @CVSROOT = %CVSROOT =
%MIRRORS = %DEFAULTVALUE = %ICONS = %MTYPES =
%tags = %alltags = @tabcolors = ();
$cvstreedefault = $body_tag = $body_tag_for_src =
$logo = $defaulttitle = $address =
$long_intro = $short_instruction = $shortLogLen =
$show_author = $dirtable = $tablepadding = $columnHeaderColorDefault =
$columnHeaderColorSorted = $hr_breakable = $showfunc = $hr_ignwhite =
$hr_ignkeysubst = $diffcolorHeading = $diffcolorEmpty = $diffcolorRemove =
$diffcolorChange = $diffcolorAdd = $diffcolorDarkChange = $difffontface =
$difffontsize = $inputTextSize = $mime_types = $allow_annotate =
$allow_markup = $use_java_script = $open_extern_window =
$extern_window_width = $extern_window_height = $edit_option_form =
$show_subdir_lastmod = $show_log_in_markup = $v =
$navigationHeaderColor = $tableBorderColor = $markupLogColor =
$tabstop = $use_moddate = $moddate = $gzip_open = undef;

$LOG_FILESEPARATOR = q/^={77}$/;
$LOG_REVSEPARATOR = q/^-{28}$/;

@DIFFTYPES = qw(h H u c s);
@DIFFTYPES{@DIFFTYPES} = (
			  {
			   'descr'   => 'colored',
			   'opts'    => [ '-u' ],
			   'colored' => 1,
			  },
			  {
			   'descr'   => 'long colored',
			   'opts'    => [ '--unified=15' ],
			   'colored' => 1,
			  },
			  {
			   'descr'   => 'unified',
			   'opts'    => [ '-u' ],
			   'colored' => 0,
			  },
			  {
			   'descr'   => 'context',
			   'opts'    => [ '-c' ],
			   'colored' => 0,
			  },
			  {
			   'descr'   => 'side by side',
			   'opts'    => [ '--side-by-side', '--width=164' ],
			   'colored' => 0,
			  },
			 );

@LOGSORTKEYS = qw(cvs date rev);
@LOGSORTKEYS{@LOGSORTKEYS} = (
			      {
			       'descr' => 'Not sorted',
			      },
			      {
			       'descr' => 'Commit date',
			      },
			      {
			       'descr' => 'Revision',
			      },
			     );

##### End of configuration variables #####

$cgi_style::hsty_base = 'http://www.FreeBSD.org';
$_ = q$FreeBSD: www/en/cgi/cvsweb.cgi,v 1.70 2001/03/27 17:26:31 knu Exp $;
@_ = split;
$cgi_style::hsty_date = "@_[3,4]";

# warningproof
0 if $cgi_style::hsty_base ne $cgi_style::hsty_date;

package cgi_style;
require "$main::mydir/cgi-style.pl";
package main;

##### End of configuration variables #####

use Time::Local;
use IPC::Open2;

# Check if the zlib C library interface is installed, and if yes
# we can avoid using the extra gzip process.
eval {
	require Compress::Zlib;
};
$has_zlib = !$@;

$verbose = $v;
$checkoutMagic = "~checkout~";
$pathinfo = defined($ENV{PATH_INFO}) ? $ENV{PATH_INFO} : '';
$where = $pathinfo;
$doCheckout = ($where =~ m|^/$checkoutMagic/|);
$where =~ s|^/$checkoutMagic/|/|;
$where =~ s|^/||;
$scriptname = defined($ENV{SCRIPT_NAME}) ? $ENV{SCRIPT_NAME} : '';
$scriptname =~ s|^/*|/|;

# Let's workaround thttpd's stupidity..
if ($scriptname =~ m|/$|) {
    $pathinfo .= '/';
    my $re = quotemeta $pathinfo;
    $scriptname =~ s/$re$//;
}

$scriptwhere = $scriptname;
$scriptwhere .= '/' . urlencode($where);
$where = '/' if ($where eq '');

$is_mod_perl = defined($ENV{MOD_PERL});

# in lynx, it it very annoying to have two links
# per file, so disable the link at the icon
# in this case:
$Browser = $ENV{HTTP_USER_AGENT} || '';
$is_links = ($Browser =~ m`^Links `);
$is_lynx = ($Browser =~ m`^Lynx/`i);
$is_w3m = ($Browser =~ m`^w3m/`i);
$is_msie = ($Browser =~ m`MSIE`);
$is_mozilla3 = ($Browser =~ m`^Mozilla/[3-9]`);

$is_textbased = ($is_links || $is_lynx || $is_w3m);

$nofilelinks = $is_textbased;

# newer browsers accept gzip content encoding
# and state this in a header
# (netscape did always but didn't state it)
# It has been reported that these
#  braindamaged MS-Internet Exploders claim that they
# accept gzip .. but don't in fact and
# display garbage then :-/
# Turn off gzip if running under mod_perl and no zlib is available,
# piping does not work as expected inside the server.
$maycompress = (((defined($ENV{HTTP_ACCEPT_ENCODING})
		 && $ENV{HTTP_ACCEPT_ENCODING} =~ m`gzip`)
		 || $is_mozilla3)
		&& !$is_msie
		&& !($is_mod_perl && !$has_zlib));

# put here the variables we need in order
# to hold our state - they will be added (with
# their current value) to any link/query string
# you construct
@stickyvars = qw(cvsroot hideattic sortby logsort f only_with_tag);

if (-f $config) {
   require $config
     || &fatal("500 Internal Error",
	       sprintf('Error in loading configuration file: %s<BR><BR>%s<BR>',
		       $config, &htmlify($@)));
} else {
   &fatal("500 Internal Error",
	  'Configuration not found.  Set the variable <code>$config</code> '
          . 'in cvsweb.cgi to your <b>cvsweb.conf</b> configuration file first.');
}

undef %input;
$query = $ENV{QUERY_STRING};

if (defined($query) && $query ne '') {
    foreach (split(/&/, $query)) {
	y/+/ /;
	s/%(..)/sprintf("%c", hex($1))/ge;	# unquote %-quoted
	if (/(\S+)=(.*)/) {
	    $input{$1} = $2 if ($2 ne "");
	}
	else {
	    $input{$_}++;
	}
    }
}

# For backwards compability, set only_with_tag to only_on_branch if set.
$input{only_with_tag} = $input{only_on_branch}
    if (defined($input{only_on_branch}));

$DEFAULTVALUE{'cvsroot'} = $cvstreedefault;

foreach (keys %DEFAULTVALUE)
{
    # replace not given parameters with the default parameters
    if (!defined($input{$_}) || $input{$_} eq "") {
	# Empty Checkboxes in forms return -- nothing. So we define a helper
	# variable in these forms (copt) which indicates that we just set
	# parameters with a checkbox
	if (!defined($input{"copt"})) {
	    # 'copt' isn't defined --> empty input is not the result
	    # of empty input checkbox --> set default
	    $input{$_} = $DEFAULTVALUE{$_} if (defined($DEFAULTVALUE{$_}));
	}
	else {
	    # 'copt' is defined -> the result of empty input checkbox
	    # -> set to zero (disable) if default is a boolean (0|1).
	    $input{$_} = 0
		if (defined($DEFAULTVALUE{$_})
		    && ($DEFAULTVALUE{$_} eq "0" || $DEFAULTVALUE{$_} eq "1"));
	}
    }
}

$barequery = "";
my @barequery;
foreach (@stickyvars) {
    # construct a query string with the sticky non default parameters set
    if (defined($input{$_}) && $input{$_} ne '' &&
	!(defined($DEFAULTVALUE{$_}) && $input{$_} eq $DEFAULTVALUE{$_})) {
	push @barequery, join('=', urlencode($_), urlencode($input{$_}));
    }
}
# is there any query ?
if (@barequery) {
    $barequery = join('&', @barequery);
    $query = "?$barequery";
    $barequery = "&$barequery";
}
else {
    $query = "";
}
undef @barequery;

if (defined($input{path})) {
    redirect("$scriptname/$input{path}$query");
}

# get actual parameters
$sortby = $input{"sortby"};
$bydate = 0;
$byrev = 0;
$byauthor = 0;
$bylog = 0;
$byfile = 0;
if ($sortby eq "date") {
    $bydate = 1;
}
elsif ($sortby eq "rev") {
    $byrev = 1;
}
elsif ($sortby eq "author") {
    $byauthor = 1;
}
elsif ($sortby eq "log") {
    $bylog = 1;
}
else {
    $byfile = 1;
}

$defaultDiffType = $input{'f'};

$logsort = $input{'logsort'};

my @tmp = @CVSrepositories;
my @pair;

while (@pair = splice(@tmp, 0, 2)) {
    my($key, $val) = @pair;
    my($descr, $cvsroot) = @$val;

    next if !-d $cvsroot;

    $CVSROOTdescr{$key} = $descr;
    $CVSROOT{$key} = $cvsroot;
    push @CVSROOT, $key;
}
undef @tmp;
undef @pair;

## Default CVS-Tree
if (!defined($CVSROOT{$cvstreedefault})) {
   &fatal("500 Internal Error",
	  "<code>\$cvstreedefault</code> points to a repository "
	  . "not defined in <code>%CVSROOT</code> "
	  . "(edit your configuration file $config)");
}

# alternate CVS-Tree, configured in cvsweb.conf
if ($input{'cvsroot'} && $CVSROOT{$input{'cvsroot'}}) {
    $cvstree = $input{'cvsroot'};
} else {
    $cvstree = $cvstreedefault;
}

$cvsroot = $CVSROOT{$cvstree};

# create icons out of description
my $k;
foreach $k (keys %ICONS) {
    no strict 'refs';
    my ($itxt,$ipath,$iwidth,$iheight) = @{$ICONS{$k}};
    if ($ipath) {
	${"${k}icon"} = sprintf('<IMG SRC="%s" ALT="%s" BORDER="0" WIDTH="%d" HEIGHT="%d">',
				hrefquote($ipath), htmlquote($itxt), $iwidth, $iheight)
    }
    else {
	${"${k}icon"} = $itxt;
    }
}
undef $k;

my $config_cvstree = "$config-$cvstree";

# Do some special configuration for cvstrees
if (-f $config_cvstree) {
   require $config_cvstree
     || &fatal("500 Internal Error",
	       sprintf('Error in loading configuration file: %s<BR><BR>%s<BR>',
		       $config_cvstree, &htmlify($@)));
}
undef $config_cvstree;

$re_prcategories = '(?:' . join('|', @prcategories) . ')' if @prcategories;
$re_prkeyword = quotemeta($prkeyword) if defined($prkeyword);
$prcgi .= '%s' if defined($prcgi) && $prcgi !~ /%s/;

$fullname = "$cvsroot/$where";
$mimetype = &getMimeTypeFromSuffix ($fullname);
$defaultTextPlain = ($mimetype eq "text/plain");
$defaultViewable = $allow_markup && viewable($mimetype);

my $rewrite = 0;

if ($pathinfo =~ m|//|) {
    $pathinfo =~ y|/|/|s;
    $rewrite = 1;
}

if (-d $fullname && $pathinfo !~ m|/$|) {
    $pathinfo .= '/';
    $rewrite = 1;
}

if (!-d $fullname && $pathinfo =~ m|/$|) {
    chop $pathinfo;
    $rewrite = 1;
}

if ($rewrite) {
    redirect($scriptname . urlencode($pathinfo) . $query);
}

undef $rewrite;

if (!-d $cvsroot) {
    &fatal("500 Internal Error",'$CVSROOT not found!<P>The server on which the CVS tree lives is probably down.  Please try again in a few minutes.');
}

#
# See if the module is in our forbidden list.
#
$where =~ m:([^/]*):;
$module = $1;
if ($module && &forbidden_module($module)) {
    &fatal("403 Forbidden", "Access to $where forbidden.");
}

#
# Handle tarball downloads before any headers are output.
#
if ($input{tarball}) {
    &fatal("403 Forbidden", "Downloading tarballs is prohibited.")
      unless $allow_tar;
    my($module) = ($where =~ m,^/?(.*),);	# untaint
    $module =~ s,/[^/]*$,,;
    my($basedir) = ($module =~ m,([^/]+)$,);

    if ($basedir eq '' || $module eq '') {
	&fatal("500 Internal Error", "You cannot download the top level directory.");
    }

    my $tmpdir = "/tmp/.cvsweb.$$." . int(time);

    mkdir($tmpdir, 0700)
      or &fatal("500 Internal Error", "Unable to make temporary directory: $!");

    my $fatal = '';

    while (1) {
	my $tag = (exists $input{only_with_tag} && length $input{only_with_tag})
	  ? $input{only_with_tag} : "HEAD";

	system $CMD{cvs}, @cvs_options, '-Qd', $cvsroot, 'export', '-r', $tag, '-d', "$tmpdir/$basedir", $module
	  and $fatal = "500 Internal Error","cvs co failure: $!: $module"
	    && last;

	$| = 1; # Essential to get the buffering right.

	print "Content-type: application/x-gzip\r\n\r\n";

	system "$CMD{tar} @tar_options -cf - -C $tmpdir $basedir | $CMD{gzip} @gzip_options -c"
	  and $fatal = "500 Internal Error","tar zc failure: $!: $basedir"
	    && last;

	last;
    }

    system $CMD{rm}, '-rf', $tmpdir if -d $tmpdir;

    &fatal($fatal) if $fatal;

    exit;
}

##############################
# View a directory
###############################
if (-d $fullname) {
	my $dh = do {local(*DH);};
	opendir($dh, $fullname) || &fatal("404 Not Found","$where: $!");
	my @dir = readdir($dh);
	closedir($dh);
	my @subLevelFiles = findLastModifiedSubdirs(@dir)
	    if ($show_subdir_lastmod);
	getDirLogs($cvsroot,$where,@subLevelFiles);

	if ($where eq '/') {
	    html_header($defaulttitle);
	    $long_intro =~ s/!!CVSROOTdescr!!/$CVSROOTdescr{$cvstree}/g;
	    print $long_intro;
	}
	else {
	    html_header($where);
	    print $short_instruction;
	}

	my $descriptions;
	if (($use_descriptions) && open (DESC, "<$cvsroot/CVSROOT/descriptions")) {
	    while (<DESC>) {
		chomp;
		my ($dir,$description) = /(\S+)\s+(.*)/;
		$descriptions{$dir} = $description;
	    }
	}

	print "<P><a name=\"dirlist\"></a>\n";
	# give direct access to dirs
	if ($where eq '/') {
	    chooseMirror();
	    chooseCVSRoot();
	}
	else {
	    print "<p>Current directory: <b>", &clickablePath($where,0), "</b>\n";

	    print "<P>Current tag: <B>", $input{only_with_tag}, "</b>\n" if
		$input{only_with_tag};

	}


	print "<HR NOSHADE>\n";
	# Using <MENU> in this manner violates the HTML2.0 spec but
	# provides the results that I want in most browsers.  Another
	# case of layout spooging up HTML.

	my $infocols = 0;
	if ($dirtable) {
	    if (defined($tableBorderColor)) {
		# Can't this be done by defining the border for the inner table?
		print "<table border=0 cellpadding=0 width=\"100%\"><tr><td bgcolor=\"$tableBorderColor\">";
	    }
	    print "<table  width=\"100%\" border=0 cellspacing=1 cellpadding=$tablepadding>\n";
	    $infocols++;
	    printf '<tr><th align=left bgcolor="%s">',
	      $byfile ? $columnHeaderColorSorted : $columnHeaderColorDefault;
	    if ($byfile) {
		print 'File';
	    } else {
		print &link('File', sprintf('./%s#dirlist',
					    &toggleQuery("sortby", "file")));
	    }
	    print "</th>";
	    # do not display the other column-headers, if we do not have any files
	    # with revision information:
	    if (scalar(%fileinfo)) {
		$infocols++;
		printf '<th align=left bgcolor="%s">',
		  $byrev ? $columnHeaderColorSorted : $columnHeaderColorDefault;
		if ($byrev) {
		    print 'Rev.';
		} else {
		    print &link('Rev.', sprintf('./%s#dirlist',
						&toggleQuery("sortby", "rev")));
		}
		print "</th>";
		$infocols++;
		printf '<th align=left bgcolor="%s">',
		  $bydate ? $columnHeaderColorSorted : $columnHeaderColorDefault;
		if ($bydate) {
		    print 'Age';
		} else {
		    print &link('Age', sprintf('./%s#dirlist',
					       &toggleQuery("sortby", "date")));
		}
		print "</th>";
		if ($show_author) {
		    $infocols++;
		    printf '<th align=left bgcolor="%s">',
		      $byauthor ? $columnHeaderColorSorted : $columnHeaderColorDefault;
		    if ($byauthor) {
			print 'Author';
		    } else {
			print &link('Author', sprintf('./%s#dirlist',
						      &toggleQuery("sortby", "author")));
		    }
		    print "</th>";
		}
		$infocols++;
		printf '<th align=left bgcolor="%s">',
		  $bylog ? $columnHeaderColorSorted : $columnHeaderColorDefault;
		if ($bylog) {
		    print 'Last log entry';
		} else {
		    print &link('Last log entry', sprintf('./%s#dirlist',
							  &toggleQuery("sortby", "log")));
		}
		print "</th>";
	    }
	    elsif ($use_descriptions) {
		printf '<th align=left bgcolor="%s">', $columnHeaderColorDefault;
		print "Description";
		$infocols++;
	    }
	    print "</tr>\n";
	}
	else {
	    print "<menu>\n";
	}
	my $dirrow = 0;

	my $i;
	lookingforattic:
	for ($i = 0; $i <= $#dir; $i++) {
		if ($dir[$i] eq "Attic") {
		    last lookingforattic;
		}
	}
	if (!$input{'hideattic'} && ($i <= $#dir) &&
	    opendir($dh, $fullname . "/Attic")) {
	    splice(@dir, $i, 1,
			grep((s|^|Attic/|,!m|/\.|), readdir($dh)));
	    closedir($dh);
	}

	my $hideAtticToggleLink = $input{'hideattic'} ? '' :
	  &link('[Hide]', sprintf('./%s#dirlist',
				  &toggleQuery ("hideattic")));

	# Sort without the Attic/ pathname.
	# place directories first

	my $attic;
	my $url;
	my $fileurl;
	my $filesexists;
	my $filesfound;

	foreach (sort { &fileSortCmp } @dir) {
	    if ($_ eq '.') {
		next;
	    }
	    # ignore CVS lock and stale NFS files
	    next if (/^#cvs\.|^,|^\.nfs/);

	    # Check whether to show the CVSROOT path
	    next if ($input{'hidecvsroot'} && ($_ eq 'CVSROOT'));

	    # Check whether the module is in the restricted list
	    next if ($_ && &forbidden_module($_));

	    # Ignore non-readable files
	    next if ($input{'hidenonreadable'} && !(-r "$fullname/$_"));

	    if (s|^Attic/||) {
		$attic  = " (in the Attic)&nbsp;" . $hideAtticToggleLink;
	    }
	    else {
		$attic = "";
	    }

	    if ($_ eq '..' || -d "$fullname/$_") {
		next if ($_ eq '..' && $where eq '/');
		my ($rev,$date,$log,$author,$filename);
		($rev,$date,$log,$author,$filename) = @{$fileinfo{$_}}
		    if (defined($fileinfo{$_}));
		printf '<tr bgcolor="%s"><td>', $tabcolors[$dirrow % 2] if $dirtable;
		if ($_ eq '..') {
		    $url = "../$query";
		    if ($nofilelinks) {
			print $backicon;
		    }
		    else {
			print &link($backicon, $url);
		    }
		    print " ", &link("Previous Directory", $url);
		}
		else {
		    $url = './' . urlencode($_) . "/$query";
		    print "<A NAME=\"$_\"></A>";
		    if ($nofilelinks) {
			print $diricon;
		    }
		    else {
			print &link($diricon, $url);
		    }
		    print " ", &link("$_/", $url), $attic;
		    if ($_ eq "Attic") {
			print "&nbsp; ";
			print &link("[Don't hide]", sprintf('./%s#dirlist',
							    &toggleQuery ("hideattic")));
		    }
		}
		# Show last change in dir
		if ($filename) {
		    print "</td><td>&nbsp;</td><td>&nbsp;" if ($dirtable);
		    if ($date) {
			print " <i>", readableTime(time() - $date,0), "</i>";
		    }
		    if ($show_author) {
			print "</td><td>&nbsp;" if ($dirtable);
			print $author;
		    }
		    print "</td><td>&nbsp;" if ($dirtable);
		    $filename =~ s%^[^/]+/%%;
		    print "$filename/$rev";
		    print "<BR>" if ($dirtable);
		    if ($log) {
			print "&nbsp;<font size=-1>",
			  &htmlify(substr($log,0,$shortLogLen));
			if (length $log > 80) {
			    print "...";
			}
			print "</font>";
		    }
		}
		else {
		    my ($dwhere) = ($where ne "/" ? $where : "") . $_;
		    if ($use_descriptions && defined $descriptions{$dwhere}) {
			print "<TD COLSPAN=", ($infocols-1), ">&nbsp;" if $dirtable;
			print $descriptions{$dwhere};
		    } elsif ($dirtable && $infocols > 1) {
			# close the row with the appropriate number of
			# columns, so that the vertical seperators are visible
			my($cols) = $infocols;
			while ($cols > 1) {
			    print "</td><td>&nbsp;";
			    $cols--;
			}
		    }
		}
		if ($dirtable) {
		    print "</td></tr>\n";
		}
		else {
		    print "<br>\n";
		}
		$dirrow++;
	    }
	    elsif (s/,v$//) {
		$fileurl = ($attic ? "Attic/" : "") . urlencode($_);
		$url = './' . $fileurl . $query;
		my $rev = '';
		my $date = '';
		my $log = '';
		my $author = '';
		$filesexists++;
		next if (!defined($fileinfo{$_}));
		($rev,$date,$log,$author) = @{$fileinfo{$_}};
		$filesfound++;
		printf '<tr bgcolor="%s"><td>', $tabcolors[$dirrow % 2] if $dirtable;
		print "<A NAME=\"$_\"></A>";
		if ($nofilelinks) {
		    print $fileicon;
		}
		else {
		    print &link($fileicon,$url);
		}
		print " ", &link($_, $url), $attic;
		print "</td><td>&nbsp;" if ($dirtable);
		download_link($fileurl,
			      $rev, $rev,
			      $defaultViewable ? "text/x-cvsweb-markup" : undef);
		print "</td><td>&nbsp;" if ($dirtable);
		if ($date) {
		    print " <i>", readableTime(time() - $date,0), "</i>";
		}
		if ($show_author) {
		    print "</td><td>&nbsp;" if ($dirtable);
		    print $author;
		}
		print "</td><td>&nbsp;" if ($dirtable);
		if ($log) {
		    print " <font size=-1>", &htmlify(substr($log,0,$shortLogLen));
		    if (length $log > 80) {
			print "...";
		    }
		    print "</font>";
		}
		print "</td>" if ($dirtable);
		print (($dirtable) ? "</tr>" : "<br>");
		$dirrow++;
	    }
	    print "\n";
	}
	if ($dirtable && defined($tableBorderColor)) {
	    print "</td></tr></table>";
	}
	print( $dirtable == 1 ? "</table>\n" : "</menu>\n" );

	if ($filesexists && !$filesfound) {
	    print "<P><B>NOTE:</B> There are $filesexists files, but none matches the current tag ($input{only_with_tag})\n";
	}
	if ($input{only_with_tag} && (!%tags || !$tags{$input{only_with_tag}})) {
	    %tags = %alltags
	}
	if (scalar %tags
	    || $input{only_with_tag}
	    || $edit_option_form
	    || defined($input{"options"})) {
	    print "<hr size=1 NOSHADE>";
	}

	if (scalar %tags || $input{only_with_tag}) {
	    print "<FORM METHOD=\"GET\" ACTION=\"./\">\n";
	    foreach my $var (@stickyvars) {
		print "<INPUT TYPE=HIDDEN NAME=\"$var\" VALUE=\"$input{$var}\">\n"
		    if (defined($input{$var})
			&& (!defined($DEFAULTVALUE{$var})
			    || $input{$var} ne $DEFAULTVALUE{$var})
			&& $input{$var} ne ""
			&& $var ne "only_with_tag");
	    }
	    print "Show only files with tag:\n";
	    print "<SELECT NAME=only_with_tag";
	    print " onchange=\"submit()\"" if ($use_java_script);
	    print ">";
	    print "<OPTION VALUE=\"\">All tags / default branch\n";
	    foreach my $tag (reverse sort { lc $a cmp lc $b } keys %tags) {
		print "<OPTION",defined($input{only_with_tag}) &&
		       $input{only_with_tag} eq $tag ? " SELECTED" : "",
		       ">$tag\n";
	    }
	    print "</SELECT>\n";
	    print " Module path or alias:\n";
	    printf "<INPUT TYPE=TEXT NAME=\"path\" VALUE=\"%s\" SIZE=15>\n", htmlquote($where);
	    print "<INPUT TYPE=SUBMIT VALUE=\"Go\">\n";
	    print "</FORM>\n";
	}

	if ($allow_tar) {
	    my($basefile) = ($where =~ m,(?:.*/)?([^/]+),);

	    if (defined($basefile) && $basefile ne '') {
		print "<HR NOSHADE>\n",
		  "<DIV align=center>",
		    &link("Download this directory in tarball",
			  # Mangle the filename so browsers show a reasonable
			  # filename to download.
			  "./$basefile.tar.gz$query".
			  ($query ? "&" : "?")."tarball=1"),
			    "</DIV>";
	    }
	}

	my $formwhere = $scriptwhere;
	$formwhere =~ s|Attic/?$|| if ($input{'hideattic'});

	if ($edit_option_form || defined($input{"options"})) {
	    print "<FORM METHOD=\"GET\" ACTION=\"${formwhere}\">\n";
	    print "<INPUT TYPE=HIDDEN NAME=\"copt\" VALUE=\"1\">\n";
	    if ($cvstree ne $cvstreedefault) {
		print "<INPUT TYPE=HIDDEN NAME=\"cvsroot\" VALUE=\"$cvstree\">\n";
	    }
	    print "<center><table cellpadding=0 cellspacing=0>";
	    print "<tr bgcolor=\"$columnHeaderColorDefault\"><th colspan=2>Preferences</th></tr>";
	    print "<tr><td>Sort files by <SELECT name=\"sortby\">";
	    print "<OPTION VALUE=\"\">File";
	    print "<OPTION",$bydate ? " SELECTED" : ""," VALUE=date>Age";
	    print "<OPTION",$byauthor ? " SELECTED" : ""," VALUE=author>Author"
		if ($show_author);
	    print "<OPTION",$byrev ? " SELECTED" : ""," VALUE=rev>Revision";
	    print "<OPTION",$bylog ? " SELECTED" : ""," VALUE=log>Log message";
	    print "</SELECT></td>";
	    print "<td>Sort log by: ";
	    printLogSortSelect(0);
	    print "</td></tr>";
	    print "<tr><td>Diff format: ";
	    printDiffSelect(0);
	    print "</td>";
	    print "<td>Show Attic files: ";
	    print "<INPUT NAME=hideattic TYPE=CHECKBOX", $input{'hideattic'} ? " CHECKED" : "",
	    "></td></tr>\n";
	    print "<tr><td align=center colspan=2><input type=submit value=\"Change Options\">";
	    print "</td></tr></table></center></FORM>\n";
	}
	print &html_footer;
	print "</BODY></HTML>\n";
    }

###############################
# View Files
###############################
    elsif (-f $fullname . ',v') {
	if (defined($input{'rev'}) || $doCheckout) {
	    &doCheckout($fullname, $input{'rev'});
	    gzipclose();
	    exit;
	}
	if (defined($input{'annotate'}) && $allow_annotate) {
	    &doAnnotate($input{'annotate'});
	    gzipclose();
	    exit;
	}
	if (defined($input{'r1'}) && defined($input{'r2'})) {
	    &doDiff($fullname, $input{'r1'}, $input{'tr1'},
		    $input{'r2'}, $input{'tr2'}, $input{'f'});
	    gzipclose();
	    exit;
	}
	print("going to dolog($fullname)\n") if ($verbose);
	&doLog($fullname);
##############################
# View Diff
##############################
    }
    elsif ($fullname =~ s/\.diff$// && -f $fullname . ",v" &&
	   $input{'r1'} && $input{'r2'}) {

	# $where-diff-removal if 'cvs rdiff' is used
	# .. but 'cvs rdiff'doesn't support some options
	# rcsdiff does (-w and -p), so it is disabled
	# $where =~ s/\.diff$//;

	# Allow diffs using the ".diff" extension
	# so that browsers that default to the URL
	# for a save filename don't save diff's as
	# e.g. foo.c
	&doDiff($fullname, $input{'r1'}, $input{'tr1'},
		$input{'r2'}, $input{'tr2'}, $input{'f'});
	gzipclose();
	exit;
    }
    elsif (($newname = $fullname) =~ s|/([^/]+)$|/Attic/$1| &&
	   -f $newname . ",v") {
	# The file has been removed and is in the Attic.
	# Send a redirect pointing to the file in the Attic.
	(my $newplace = $scriptwhere) =~ s|/([^/]+)$|/Attic/$1|;
	redirect("$newplace$query");
	exit;
    }
    elsif (0 && (my @files = &safeglob($fullname . ",v"))) {
	http_header("text/plain");
	print "You matched the following files:\n";
	print join("\n", @files);
	# Find the tags from each file
	# Display a form offering diffs between said tags
    }
    else {
	my $fh = do {local(*FH);};
	my ($xtra, $module);
	# Assume it's a module name with a potential path following it.
	$xtra = (($module = $where) =~ s|/.*||) ? $& : '';
	# Is there an indexed version of modules?
	if (open($fh, "< $cvsroot/CVSROOT/modules")) {
	    while (<$fh>) {
		if (/^(\S+)\s+(\S+)/o && $module eq $1
		    && -d "$cvsroot/$2" && $module ne $2) {
		    redirect("$scriptname/$2$xtra$query");
		}
	    }
	}
	&fatal("404 Not Found","$where: no such file or directory");
    }

gzipclose();
## End MAIN

sub printDiffSelect($) {
    my ($use_java_script) = @_;
    my $f = $input{'f'};

    print '<SELECT NAME="f"';
    print ' onchange="submit()"' if $use_java_script;
    print '>';

    local $_;
    for (@DIFFTYPES) {
	printf('<OPTION VALUE="%s"%s>%s',
	       $_,
	       $f eq $_ ? ' SELECTED' : '',
	       "\u$DIFFTYPES{$_}{'descr'}"
	      );
    }

    print "</SELECT>";
}

sub printLogSortSelect($) {
    my ($use_java_script) = @_;

    print '<SELECT NAME="logsort"';
    print ' onchange="submit()"' if $use_java_script;
    print '>';

    local $_;
    for (@LOGSORTKEYS) {
	printf('<OPTION VALUE="%s"%s>%s',
	       $_,
	       $logsort eq $_ ? ' SELECTED' : '',
	       "\u$LOGSORTKEYS{$_}{'descr'}"
	      );
    }

    print "</SELECT>";
}

sub findLastModifiedSubdirs(@) {
    my (@dirs) = @_;
    my ($dirname, @files);

    foreach $dirname (@dirs) {
	next if ($dirname eq ".");
	next if ($dirname eq "..");
	my ($dir) = "$fullname/$dirname";
	next if (!-d $dir);

	my ($lastmod) = undef;
	my ($lastmodtime) = undef;
	my $dh = do {local(*DH);};

	opendir($dh,$dir) || next;
	my (@filenames) = readdir($dh);
	closedir($dh);

	foreach my $filename (@filenames) {
	    $filename = "$dirname/$filename";
	    my ($file) = "$fullname/$filename";
	    next if ($filename !~ /,v$/ || !-f $file);
	    $filename =~ s/,v$//;
	    my $modtime = -M $file;
	    if (!defined($lastmod) || $modtime < $lastmodtime) {
		$lastmod = $filename;
		$lastmodtime = $modtime;
	    }
	}
	push(@files, $lastmod) if (defined($lastmod));
    }
    return @files;
}

sub htmlify_sub(&$) {
    (my $proc, local $_) = @_;
    local @_ = split(m`(<a [^>]+>[^<]*</a>)`i);
    my $linked;
    my $result = '';

    while (($_, $linked) = splice(@_, 0, 2)) {
	&$proc();
	$result .= $_ if defined($_);
	$result .= $linked if defined($linked);
    }

    $result;
}

sub htmlify($;$) {
    (local $_, my $extra) = @_;

    $_ = htmlquote($_);

    # get URL's as link
    s{
      (http|ftp|https)://\S+
     }{
	 &link($&, htmlunquote($&))
     }egx;

    # get e-mails as link
    $_ = htmlify_sub {
	s<
	  [\w+=\-.!]+@[\w\-]+(\.[\w\-]+)+
	    ><
	      &link($&, "mailto:$&")
		>egix;
    } $_;

    if ($extra) {
	# get PR #'s as link: "PR#nnnn" "PR: nnnn, ..." "PR nnnn, ..." "bin/nnnn"
	if (defined($prcgi) && defined($re_prcategories) && defined($re_prkeyword)) {
	    my $prev;

	    do {
		$prev = $_;

		$_ = htmlify_sub {
		    s{
		      (\b$re_prkeyword[:\#]?\s*
		       (?:
			\#?
			\d+[,\s]\s*
		       )*
		       \#?)
		      (\d+)\b
		     }{
			 $1 . &link($2, sprintf($prcgi, $2))
		     }egix;
		} $_;
	    } while ($_ ne $prev);

	    $_ = htmlify_sub {
		s{
		  (\b$re_prcategories/(\d+)\b)
		 }{
		     &link($1, sprintf($prcgi, $2))
		 }egox;
	    } $_;
	}

	# get manpage specs as link: "foo.1" "foo(1)"
	if (defined($mancgi)) {
	    $_ = htmlify_sub {
		s{
		  (\b([a-zA-Z][\w.]+)
		   (?:
		    \( ([0-9n]) \)\B
		    |
		    \.([0-9n])\b
		   )
		  )
		 }{
		     &link($1, sprintf($mancgi, defined($3) ? $3 : $4, $2))
		 }egx;
	    } $_;
	}
    }

    $_;
}

sub spacedHtmlText($;$) {
	local $_ = $_[0];
	my $ts = $_[1] || $tabstop;

	# Cut trailing spaces and tabs
	s/[ \t]+$//;

        if (defined($ts)) {
	    # Expand tabs
	    1 while s/\t+/' ' x (length($&) * $ts - length($`) % $ts)/e
	}

	# replace <tab> and <space> (\001 is to protect us from htmlify)
	# gzip can make excellent use of this repeating pattern :-)
	if ($hr_breakable) {
	    # make every other space 'breakable'
	    s/  / \001nbsp;/g;                              # 2 * <space>
	    # leave single space as it is
	} else {
	    s/ /\001nbsp;/g;
	}

	$_ = htmlify($_);

	# unescape
	y/\001/&/;

	return $_;
}

sub link($$) {
	my($name, $url) = @_;

	$url =~ s/:/sprintf("%%%02x", ord($&))/eg if $url =~ /^[^a-z]/;	# relative

	sprintf '<A HREF="%s">%s</A>', hrefquote($url), $name;
}

sub revcmp($$) {
	my($rev1, $rev2) = @_;

	# make no comparison for a tag or a branch
	return 0 if $rev1 =~ /[^\d.]/ || $rev2 =~ /[^\d.]/;

	my(@r1) = split(/\./, $rev1);
	my(@r2) = split(/\./, $rev2);
	my($a,$b);

	while (($a = shift(@r1)) && ($b = shift(@r2))) {
	    if ($a != $b) {
		return $a <=> $b;
	    }
	}
	if (@r1) { return 1; }
	if (@r2) { return -1; }
	return 0;
}

sub fatal($$) {
	my($errcode, $errmsg) = @_;
	if ($is_mod_perl) {
		Apache->request->status((split(/ /, $errcode))[0]);
	}
	else {
		print "Status: $errcode\r\n";
	}
	html_header("Error");
	print "Error: $errmsg\n";
	print &html_footer;
	exit(1);
}

sub redirect($) {
	my($url) = @_;
	if ($is_mod_perl) {
		Apache->request->status(301);
		Apache->request->header_out(Location => $url);
	}
	else {
		print "Status: 301 Moved\r\n";
		print "Location: $url\r\n";
	}
	html_header("Moved");
	print "This document is located ", &link('here', $url), "\n";
	print &html_footer;
	exit(1);
}

sub safeglob($) {
	my ($filename) = @_;
	my ($dirname);
	my (@results);
	my $dh = do {local(*DH);};

	($dirname = $filename) =~ s|/[^/]+$||;
	$filename =~ s|.*/||;

	if (opendir($dh, $dirname)) {
		my $glob = $filename;
		my $t;
	#	transform filename from glob to regex.  Deal with:
	#	[, {, ?, * as glob chars
	#	make sure to escape all other regex chars
		$glob =~ s/([\.\(\)\|\+])/\\$1/g;
		$glob =~ s/\*/.*/g;
		$glob =~ s/\?/./g;
		$glob =~ s/{([^}]+)}/($t = $1) =~ s-,-|-g; "($t)"/eg;
		foreach (readdir($dh)) {
			if (/^${glob}$/) {
				push(@results, "$dirname/" .$_);
			}
		}
 		closedir($dh);
	}

	@results;
}

sub search_path($) {
    my($command) = @_;
    my $d;

    for $d (split(/:/, $command_path)) {
	return "$d/$command" if -x "$d/$command";
    }

    $command;
}

sub getMimeTypeFromSuffix($) {
    my ($fullname) = @_;
    my ($mimetype, $suffix);
    my $fh = do {local(*FH);};

    ($suffix = $fullname) =~ s/^.*\.([^.]*)$/$1/;
    $mimetype = $MTYPES{$suffix};
    $mimetype = $MTYPES{'*'} if (!$mimetype);

    if (!$mimetype && -f $mime_types) {
	# okey, this is something special - search the
	# mime.types database
	open ($fh, "<$mime_types");
	while (<$fh>) {
	    if ($_ =~ /^\s*(\S+\/\S+).*\b$suffix\b/) {
		$mimetype = $1;
		last;
	    }
	}
	close ($fh);
    }

# okey, didn't find anything useful ..
    if (!($mimetype =~ /\S\/\S/)) {
	$mimetype = "text/plain";
    }
    return $mimetype;
}

###############################
# read first lines like head(1)
###############################
sub head($;$) {
    my $fh = $_[0];
    my $linecount = $_[1] || 10;

    my @buf;

    if ($linecount > 0) {
	my $i;
	for ($i = 0; !eof($fh) && $i < $linecount; $i++) {
	    push @buf, scalar <$fh>;
	}
    } else {
	@buf = <$fh>;
    }

    @buf;
}

###############################
# scan vim and Emacs directives
###############################
sub scan_directives(@) {
    my $ts = undef;

    for (@_) {
	$ts = $1 if /\b(?:ts|tabstop|tab-width)[:=]\s*([1-9]\d*)\b/;
    }

    ('tabstop' => $ts);
}

###############################
# show Annotation
###############################
sub doAnnotate($$) {
    my ($rev) = @_;
    my ($pid);
    my ($pathname, $filename);
    my $reader = do {local(*FH);};
    my $writer = do {local(*FH);};

    # make sure the revisions are wellformed, for security
    # reasons ..
    if ($rev =~ /[^\w.]/) {
	&fatal("404 Not Found",
		"Malformed query \"$ENV{QUERY_STRING}\"");
    }

    ($pathname = $where) =~ s/(Attic\/)?[^\/]*$//;
    ($filename = $where) =~ s/^.*\///;

    # this seems to be necessary
    $| = 1; $| = 0; # Flush

    # this annotate version is based on the
    # cvs annotate-demo Perl script by Cyclic Software
    # It was written by Cyclic Software, http://www.cyclic.com/, and is in
    # the public domain.
    # we could abandon the use of rlog, rcsdiff and co using
    # the cvsserver in a similiar way one day (..after rewrite)
    $pid = open2($reader, $writer, $CMD{cvs}, @cvs_options, "server")
      || fatal ("500 Internal Error", "Fatal Error - unable to open cvs for annotation");

    # OK, first send the request to the server.  A simplified example is:
    #     Root /home/kingdon/zwork/cvsroot
    #     Argument foo/xx
    #     Directory foo
    #     /home/kingdon/zwork/cvsroot/foo
    #     Directory .
    #     /home/kingdon/zwork/cvsroot
    #     annotate
    # although as you can see there are a few more details.

    print $writer "Root $cvsroot\n";
    print $writer "Valid-responses ok error Valid-requests Checked-in Updated Merged Removed M E\n";
    # Don't worry about sending valid-requests, the server just needs to
    # support "annotate" and if it doesn't, there isn't anything to be done.
    print $writer "UseUnchanged\n";
    print $writer "Argument -r\n";
    print $writer "Argument $rev\n";
    print $writer "Argument $where\n";

    # The protocol requires us to fully fake a working directory (at
    # least to the point of including the directories down to the one
    # containing the file in question).
    # So if $where is "dir/sdir/file", then @dirs will be ("dir","sdir","file")
    my @dirs = split('/', $where);
    my $path = "";
    foreach (@dirs) {
	if ($path eq "") {
	    # In our example, $_ is "dir".
	    $path = $_;
	}
	else {
	    print $writer "Directory $path\n";
	    print $writer "$cvsroot/$path\n";
	    # In our example, $_ is "sdir" and $path becomes "dir/sdir"
	    # And the next time, "file" and "dir/sdir/file" (which then gets
	    # ignored, because we don't need to send Directory for the file).
            $path .= "/$_";
	}
    }
    # And the last "Directory" before "annotate" is the top level.
    print $writer "Directory .\n";
    print $writer "$cvsroot\n";

    print $writer "annotate\n";
    # OK, we've sent our command to the server.  Thing to do is to
    # close the writer side and get all the responses.  If "cvs server"
    # were nicer about buffering, then we could just leave it open, I think.
    close ($writer) || die "cannot close: $!";

    http_header();

    navigateHeader($scriptwhere,$pathname,$filename,$rev, "annotate");
    print "<h3 align=center>Annotation of $pathname$filename, Revision $rev</h3>\n";

    # Ready to get the responses from the server.
    # For example:
    #     E Annotations for foo/xx
    #     E ***************
    #     M 1.3          (kingdon  06-Sep-97): hello
    #     ok
    my ($lineNr) = 0;
    my ($oldLrev, $oldLusr) = ("", "");
    my ($revprint, $usrprint);
    if ($annTable) {
	print "<table border=0 cellspacing=0 cellpadding=0>\n";
    }
    else {
	print "<pre>";
    }

    # prefetch several lines
    my @buf = head($reader);

    my %d = scan_directives(@buf);

    while (@buf || !eof($reader)) {
	$_ = @buf ? shift @buf : <$reader>;

	my @words = split;
	# Adding one is for the (single) space which follows $words[0].
	my $rest = substr ($_, length ($words[0]) + 1);
	if ($words[0] eq "E") {
	    next;
	}
	elsif ($words[0] eq "M") {
	    $lineNr++;
	    (my $lrev = substr($_, 2, 13)) =~ y/ //d;
	    (my $lusr = substr($_, 16,  9)) =~ y/ //d;
	    my $line = substr($_, 36);
	    my $isCurrentRev = ($rev eq $lrev);
	    # we should parse the date here ..
	    if ($lrev eq $oldLrev) {
		$revprint = sprintf('%-8s', '');
	    }
	    else {
		$revprint = sprintf('%-8s', $lrev);
		$revprint =~ s`\S+`&link($&, "$scriptwhere$query#rev$&")`e;	# `
		$oldLusr = '';
	    }
	    if ($lusr eq $oldLusr) {
		$usrprint = '';
	    }
	    else {
		$usrprint = $lusr;
	    }
	    $oldLrev = $lrev;
	    $oldLusr = $lusr;

	    # Set bold for text-based browsers only - graphical
	    # browsers show bold fonts a bit wider than regular fonts,
	    # so it looks irregular.
	    print "<b>" if ($isCurrentRev && $is_textbased);

	    printf "%s%s %-8s %4d:",
		    $revprint,
		    $isCurrentRev ? '!' : ' ',
		    $usrprint,
		    $lineNr;
	    print spacedHtmlText($line, $d{'tabstop'});

	    print "</b>" if ($isCurrentRev && $is_textbased);
	}
	elsif ($words[0] eq "ok") {
	    # We could complain about any text received after this, like the
	    # CVS command line client.  But for simplicity, we don't.
	}
	elsif ($words[0] eq "error") {
	    fatal("500 Internal Error", "Error occured during annotate: <b>$_</b>");
	}
    }
    if ($annTable) {
	print "</table>";
    }
    else {
	print "</pre>";
    }
    close ($reader) || warn "cannot close: $!";
    wait;
}

###############################
# make Checkout
###############################
sub doCheckout($$) {
    my ($fullname, $rev) = @_;
    my ($mimetype,$revopt);
    my $fh = do {local(*FH);};

    if ($rev eq 'HEAD' || $rev eq '.') {
	$rev = undef;
    }

    # make sure the revisions a wellformed, for security
    # reasons ..
    if (defined($rev) && $rev =~ /[^\w.]/) {
	&fatal("404 Not Found",
		"Malformed query \"$ENV{QUERY_STRING}\"");
    }

    # get mimetype
    if (defined($input{"content-type"}) && ($input{"content-type"} =~ /\S\/\S/)) {
	$mimetype = $input{"content-type"}
    }
    else {
	$mimetype = &getMimeTypeFromSuffix($fullname);
    }

    if (defined($rev)) {
	$revopt = "-r$rev";
	if ($use_moddate) {
	    readLog($fullname,$rev);
	    $moddate=$date{$rev};
	}
    }
    else {
	$revopt = "-rHEAD";
	if ($use_moddate) {
	    readLog($fullname);
	    $moddate=$date{$symrev{HEAD}};
	}
    }

    ### just for the record:
    ### 'cvs co' seems to have a bug regarding single checkout of
    ### directories/files having spaces in it;
    ### this is an issue that should be resolved on cvs's side
    #
    # Safely for a child process to read from.
    if (! open($fh, "-|")) { # child
	open(STDERR, ">&STDOUT"); # Redirect stderr to stdout
	exec($CMD{cvs}, @cvs_options, '-d', $cvsroot, 'co', '-p', $revopt, $where);
    }

    if (eof($fh)) {
	&fatal("404 Not Found",
	       "$where is not (any longer) pertinent");
    }
#===================================================================
#Checking out squid/src/ftp.c
#RCS:  /usr/src/CVS/squid/src/ftp.c,v
#VERS: 1.1.1.28.6.2
#***************

    # Parse CVS header
    my ($revision, $filename, $cvsheader);
    while(<$fh>) {
	last if (/^\*\*\*\*/);
	$revision = $1 if (/^VERS: (.*)$/);
	if (/^Checking out (.*)$/) {
		$filename = $1;
		$filename =~ s/^\.\/*//;
	}
	$cvsheader .= $_;
    }
    if ($filename ne $where) {
	&fatal("500 Internal Error",
	       "Unexpected output from cvs co: $cvsheader");
    }
    $| = 1;

    if ($mimetype eq "text/x-cvsweb-markup") {
	&cvswebMarkup($fh,$fullname,$revision);
    }
    else {
	http_header($mimetype);
	print <$fh>;
    }
    close($fh);
}

sub cvswebMarkup($$$) {
    my ($filehandle,$fullname,$revision) = @_;
    my ($pathname, $filename);

    ($pathname = $where) =~ s/(Attic\/)?[^\/]*$//;
    ($filename = $where) =~ s/^.*\///;
    my ($fileurl) = urlencode($filename);

    http_header();

    navigateHeader($scriptwhere, $pathname, $filename, $revision, "view");
    print "<HR noshade>";
    print "<table width=\"100%\"><tr><td bgcolor=\"$markupLogColor\">";
    print "File: ", &clickablePath($where, 1);
    print "&nbsp;(";
    &download_link($fileurl, $revision, "download");
    print ")";
    if (!$defaultTextPlain) {
	print "&nbsp;(";
	&download_link($fileurl, $revision, "as text",
	       "text/plain");
	print ")";
    }
    print "<BR>\n";
    if ($show_log_in_markup) {
	readLog($fullname); #,$revision);
	printLog($revision,0);
    }
    else {
	print "Version: <B>$revision</B><BR>\n";
	print "Tag: <B>", $input{only_with_tag}, "</b><br>\n" if
	    $input{only_with_tag};
    }
    print "</td></tr></table>";
    my $url = download_url($fileurl, $revision, $mimetype);
    print "<HR noshade>";
    if ($mimetype =~ /^image/) {
	printf '<IMG SRC="%s"><BR>', hrefquote("$url$barequery");
    }
    elsif ($mimetype =~ m%^application/pdf%) {
	printf '<EMBED SRC="%s" WIDTH="100%"><BR>', hrefquote("$url$barequery");
    }
    elsif ($preformat_in_markup) {
	print "<PRE>";

	# prefetch several lines
	my @buf = head($filehandle);

	my %d = scan_directives(@buf);

	while (@buf || !eof($filehandle)) {
	    $_ = @buf ? shift @buf : <$filehandle>;

	    print spacedHtmlText($_, $d{'tabstop'});
	}
	print "</PRE>";
    }
    else {
	print "<PRE>";
	while (<$filehandle>) {
	    print htmlquote($_);
	}
	print "</PRE>";
    }
}

sub viewable($) {
    my ($mimetype) = @_;

    $mimetype =~ m%^((text|image)/|application/pdf)% ;
}

###############################
# Show Colored Diff
###############################
sub doDiff($$$$$$) {
	my($fullname, $r1, $tr1, $r2, $tr2, $f) = @_;
        my $fh = do {local(*FH);};
	my ($rev1, $rev2, $sym1, $sym2, $f1, $f2);

	if ($r1 =~ /([^:]+)(:(.+))?/) {
	    $rev1 = $1;
	    $sym1 = $3;
	}
	if ($r1 eq 'text') {
	    $rev1 = $tr1;
	    $sym1 = "";
	}
	if ($r2 =~ /([^:]+)(:(.+))?/) {
	    $rev2 = $1;
	    $sym2 = $3;
	}
	if ($r2 eq 'text') {
	    $rev2 = $tr2;
	    $sym2 = "";
	}

	# make sure the revisions a wellformed, for security
	# reasons ..
	if ($rev1 =~ /[^\w.]/ || $rev2 =~ /[^\w.]/) {
	    &fatal("404 Not Found",
		    "Malformed query \"$ENV{QUERY_STRING}\"");
	}
#
# rev1 and rev2 are now both numeric revisions.
# Thus we do a DWIM here and swap them if rev1 is after rev2.
# XXX should we warn about the fact that we do this?
	if (&revcmp($rev1,$rev2) > 0) {
	    my ($tmp1, $tmp2) = ($rev1, $sym1);
	    ($rev1, $sym1) = ($rev2, $sym2);
	    ($rev2, $sym2) = ($tmp1, $tmp2);
	}
	my $difftype = $DIFFTYPES{$f};

	if (!$difftype) {
	    fatal ("400 Bad arguments", "Diff format $f not understood");
	}

	my @difftype       = @{$difftype->{'opts'}};
	my $human_readable = $difftype->{'colored'};

	# apply special options
	if ($showfunc) {
	    push @difftype, '-p' if $f ne 's';

	    my($re1, $re2);

	    while (($re1, $re2) = each %funcline_regexp) {
		if ($fullname =~ /$re1/) {
		    push @difftype, '-F', $re2;
		    last;
		}
	    }
	}
	if ($human_readable) {
	    if ($hr_ignwhite) {
	    	push @difftype, '-w';
	    }
	    if ($hr_ignkeysubst) {
	    	push @difftype, '-kk';
	    }
	}
	if (! open($fh, "-|")) { # child
	    open(STDERR, ">&STDOUT"); # Redirect stderr to stdout
	    exec($CMD{rcsdiff}, @difftype, "-r$rev1", "-r$rev2", $fullname);
	}
	if ($human_readable) {
	    http_header();
	    &human_readable_diff($fh, $rev2);
	    gzipclose();
	    exit;
	}
	else {
	    http_header("text/plain");
	}
#
#===================================================================
#RCS file: /home/ncvs/src/sys/netinet/tcp_output.c,v
#retrieving revision 1.16
#retrieving revision 1.17
#diff -c -r1.16 -r1.17
#*** /home/ncvs/src/sys/netinet/tcp_output.c     1995/11/03 22:08:08     1.16
#--- /home/ncvs/src/sys/netinet/tcp_output.c     1995/12/05 17:46:35     1.17
#
# Ideas:
# - nuke the stderr output if it's what we expect it to be
# - Add "no differences found" if the diff command supplied no output.
#
#*** src/sys/netinet/tcp_output.c     1995/11/03 22:08:08     1.16
#--- src/sys/netinet/tcp_output.c     1995/12/05 17:46:35     1.17 RELENG_2_1_0
# (bogus example, but...)
#
	if (grep { $_ eq '-u'} @difftype) {
	    $f1 = '---';
	    $f2 = '\+\+\+';
	}
	else {
	    $f1 = '\*\*\*';
	    $f2 = '---';
	}
	while (<$fh>) {
	    if (m|^$f1 $cvsroot|o) {
		s|$cvsroot/||o;
		if ($sym1) {
		    chop;
		    $_ .= " $sym1\n";
		}
	    }
	    elsif (m|^$f2 $cvsroot|o) {
		s|$cvsroot/||o;
		if ($sym2) {
		    chop;
		    $_ .= " $sym2\n";
		}
	    }
	    print $_;
	}
	close($fh);
}

###############################
# Show Logs ..
###############################
sub getDirLogs($$@) {
    my ($cvsroot,$dirname,@otherFiles) = @_;
    my ($state,$otherFiles,$tag, $file, $date, $branchpoint, $branch, $log);
    my ($rev, $revision, $revwanted, $filename, $head, $author);

    $tag = $input{only_with_tag};

    my ($DirName) = "$cvsroot/$where";
    my (@files, @filetags);
    my $fh = do {local(*FH);};

    push(@files, &safeglob("$DirName/*,v"));
    push(@files, &safeglob("$DirName/Attic/*,v")) if (!$input{'hideattic'});
    foreach $file (@otherFiles) {
	push(@files, "$DirName/$file");
    }

    # just execute rlog if there are any files
    if ($#files < 0) {
	return;
    }

    if (defined($tag)) {
	#can't use -r<tag> as - is allowed in tagnames, but misinterpreated by rlog..
	if (! open($fh, "-|")) {
	    open(STDERR, '>/dev/null'); # rlog may complain; ignore.
	    exec($CMD{rlog}, @files);
	}
    }
    else {
	if (! open($fh, "-|")) {
	    open(STDERR, '>/dev/null'); # rlog may complain; ignore.
	    exec($CMD{rlog}, '-r', @files);
	}
    }
    $state = "start";
    while (<$fh>) {
	if ($state eq "start") {
	    #Next file. Initialize file variables
	    $rev = '';
	    $revwanted = '';
	    $branch = '';
	    $branchpoint = '';
	    $filename = '';
	    $log = '';
	    $revision = '';
	    %symrev = ();
	    @filetags = ();
	    #jump to head state
	    $state = "head";
	}
	print "$state:$_" if ($verbose);
again:
	if ($state eq "head") {
	    #$rcsfile = $1 if (/^RCS file: (.+)$/); #not used (yet)

	    if (/^Working file: (.+)$/) {
		$filename = $1;
	    } elsif (/^head: (.+)$/) {
		$head = $1;
	    } elsif (/^branch: (.+)$/) {
		$branch = $1 
	    } elsif (/^symbolic names:/) {
		$state = "tags";
		($branch = $head) =~ s/\.\d+$// if $branch eq '';
		$branch =~ s/(\d+)$/0.$1/;
		$symrev{MAIN} = $branch;
		$symrev{HEAD} = $branch;
		$alltags{MAIN} = 1;
		$alltags{HEAD} = 1;
		push (@filetags, "MAIN", "HEAD");
	    } elsif (/$LOG_REVSEPARATOR/o) {
		$state = "log";
		$rev = '';
		$date = '';
		$log = '';
		# Try to reconstruct the relative filename if RCS spits out a full path
		$filename =~ s%^\Q$DirName\E/%%;
	    }
	    next;
	}
	if ($state eq "tags") {
	    if (/^\s+(.+):\s+([\d\.]+)\s+$/) {
		push (@filetags, $1);
		$symrev{$1} = $2;
		$alltags{$1} = 1;
		next;
	    } elsif (/^\S/) {
		if (defined($tag)) {
		    if(defined($symrev{$tag}) || $tag eq "HEAD") {
			$revwanted = $symrev{$tag eq "HEAD" ? "MAIN" : $tag};
			($branch = $revwanted) =~ s/\b0\.//;
			($branchpoint = $branch) =~ s/\.?\d+$//;
			$revwanted = '' if ($revwanted ne $branch);
		    } elsif ($tag ne "HEAD") {
			print "Tag not found, skip this file" if ($verbose);
			$state = "skip";
			next;
		    }
		}
		foreach my $tagfound (@filetags) {
		    $tags{$tagfound} = 1;
		}
		$state = "head";
		goto again;
	    }
	}
	if ($state eq "log") {
	    if (/$LOG_REVSEPARATOR/o || /$LOG_FILESEPARATOR/o) {
		# End of a log entry.
		my $revbranch = $rev;
		$revbranch =~ s/\.\d+$//;
		print "$filename $rev Wanted: $revwanted ",
		  "Revbranch: $revbranch Branch: $branch ",
		    "Branchpoint: $branchpoint\n" if ($verbose);
		if ($revwanted eq '' && $branch ne ''
		    && $branch eq $revbranch || !defined($tag)) {
		    print "File revision $rev found for branch $branch\n"
			if ($verbose);
		    $revwanted = $rev;
		}
		if ($revwanted ne '' ? $rev eq $revwanted :
		    $branchpoint ne '' ? $rev eq $branchpoint :
		    0 && ($rev eq $head)) { # Don't think head is needed here..
		    print "File info $rev found for $filename\n" if ($verbose);
		    my @finfo = ($rev,$date,$log,$author,$filename);
		    my ($name);
		    ($name = $filename) =~ s%/.*%%;
		    $fileinfo{$name} = [ @finfo ];
		    $state = "done" if ($rev eq $revwanted);
		}
		$rev = '';
		$date = '';
		$log = '';
	    }
	    elsif ($date eq '' && m|^date:\s+(\d+)/(\d+)/(\d+)\s+(\d+):(\d+):(\d+);|) {
		my $yr = $1;
		# damn 2-digit year routines :-)
		if ($yr > 100) {
		    $yr -= 1900;
		}
		$date = &Time::Local::timegm($6,$5,$4,$3,$2 - 1,$yr);
		($author) = /author: ([^;]+)/;
		$state = "log";
		$log = '';
		next;
	    }
	    elsif ($rev eq '' && /^revision (.*)$/) {
		$rev = $1;
		next;
	    }
	    else {
		$log .= $_;
	    }
	}
	if (/$LOG_FILESEPARATOR/o) {
	    $state = "start";
	    next;
	}
    }
    if ($. == 0) {
	fatal("500 Internal Error",
	      "Failed to spawn GNU rlog on <em>'".join(", ", @files)."'</em><p>Did you set the <b>\$command_path</b> in your configuration file correctly ? (Currently '$command_path'");
    }
    close($fh);
}

sub readLog($;$) {
	my($fullname,$revision) = @_;
	my ($symnames, $head, $rev, $br, $brp, $branch, $branchrev);
	my $fh = do {local(*FH);};

	if (defined($revision)) {
	    $revision = "-r$revision";
	}
	else {
	    $revision = "";
	}

	undef %symrev;
	undef %revsym;
	undef @allrevisions;
	undef %date;
	undef %author;
	undef %state;
	undef %difflines;
	undef %log;

	print("Going to rlog '$fullname'\n") if ($verbose);
	if (! open($fh, "-|")) { # child
	    if ($revision ne '') {
		exec($CMD{rlog}, $revision, $fullname);
	    }
	    else {
		exec($CMD{rlog}, $fullname);
	    }
	}
	while (<$fh>) {
	    print if ($verbose);
	    if ($symnames) {
		if (/^\s+([^:]+):\s+([\d\.]+)/) {
		    $symrev{$1} = $2;
		}
		else {
		    $symnames = 0;
		}
	    }
	    elsif (/^head:\s+([\d\.]+)/) {
		$head = $1;
	    }
	    elsif (/^branch:\s+([\d\.]+)/) {
		$curbranch = $1;
	    }
	    elsif (/^symbolic names/) {
		$symnames = 1;
	    }
	    elsif (/^-----/) {
		last;
	    }
	}
	($curbranch = $head) =~ s/\.\d+$// if (!defined($curbranch));

# each log entry is of the form:
# ----------------------------
# revision 3.7.1.1
# date: 1995/11/29 22:15:52;  author: fenner;  state: Exp;  lines: +5 -3
# log info
# ----------------------------
	logentry:
	while (!/$LOG_FILESEPARATOR/o) {
	    $_ = <$fh>;
	    last logentry if (!defined($_));	# EOF
	    print "R:", $_ if ($verbose);
	    if (/^revision ([\d\.]+)/) {
		$rev = $1;
		unshift(@allrevisions,$rev);
	    }
	    elsif (/$LOG_FILESEPARATOR/o || /$LOG_REVSEPARATOR/o) {
		next logentry;
	    }
	    else {
		# The rlog output is syntactically ambiguous.  We must
		# have guessed wrong about where the end of the last log
		# message was.
		# Since this is likely to happen when people put rlog output
		# in their commit messages, don't even bother keeping
		# these lines since we don't know what revision they go with
		# any more.
		next logentry;
#		&fatal("500 Internal Error","Error parsing RCS output: $_");
	    }
	    $_ = <$fh>;
	    print "D:", $_ if ($verbose);
	    if (m|^date:\s+(\d+)/(\d+)/(\d+)\s+(\d+):(\d+):(\d+);\s+author:\s+(\S+);\s+state:\s+(\S+);\s+(lines:\s+([0-9\s+-]+))?|) {
		my $yr = $1;
                # damn 2-digit year routines :-)
                if ($yr > 100) {
                    $yr -= 1900;
                }
		$date{$rev} = &Time::Local::timegm($6,$5,$4,$3,$2 - 1,$yr);
		$author{$rev} = $7;
		$state{$rev} = $8;
		$difflines{$rev} = $10;
	    }
	    else {
		&fatal("500 Internal Error", "Error parsing RCS output: $_");
	    }
	    line:
	    while (<$fh>) {
		print "L:", $_ if ($verbose);
		next line if (/^branches:\s/);
		last line if (/$LOG_FILESEPARATOR/o || /$LOG_REVSEPARATOR/o);
		$log{$rev} .= $_;
	    }
	    print "E:", $_ if ($verbose);
	}
	close($fh);
	print "Done reading RCS file\n" if ($verbose);

	@revorder = reverse sort {revcmp($a,$b)} @allrevisions;
	print "Done sorting revisions",join(" ",@revorder),"\n" if ($verbose);

#
# HEAD is an artificial tag which is simply the highest tag number on the main
# branch, unless there is a branch tag in the RCS file in which case it's the
# highest revision on that branch.  Find it by looking through @revorder; it
# is the first commit listed on the appropriate branch.
# This is not neccesary the same revision as marked as head in the RCS file.
	my $headrev = $curbranch || "1";
	($symrev{"MAIN"} = $headrev) =~ s/(\d+)$/0.$1/;
	foreach $rev (@revorder) {
	    if ($rev =~ /^(\S*)\.\d+$/ && $headrev eq $1) {
		$symrev{"HEAD"} = $rev;
		last;
	    }
	}
	($symrev{"HEAD"} = $headrev) =~ s/\.\d+$//
            if (!defined($symrev{"HEAD"}));
	print "Done finding HEAD\n" if ($verbose);
#
# Now that we know all of the revision numbers, we can associate
# absolute revision numbers with all of the symbolic names, and
# pass them to the form so that the same association doesn't have
# to be built then.
#
	undef @branchnames;
	undef %branchpoint;
	undef $sel;

	foreach (reverse sort keys %symrev) {
	    $rev = $symrev{$_};
	    if ($rev =~ /^((.*)\.)?\b0\.(\d+)$/) {
		push(@branchnames, $_);
		#
		# A revision number of A.B.0.D really translates into
		# "the highest current revision on branch A.B.D".
		#
		# If there is no branch A.B.D, then it translates into
		# the head A.B .
		#
		# This reasoning also applies to the main branch A.B,
		# with the branch number 0.A, with the exception that
		# it has no head to translate to if there is nothing on
		# the branch, but I guess this can never happen?
		#
		# (the code below gracefully forgets about the branch
		# if it should happen)
		#
		$head = defined($2) ? $2 : "";
		$branch = $3;
		$branchrev = $head . ($head ne "" ? "." : "") . $branch;
		my $regex;
		$regex = quotemeta $branchrev;
		$rev = $head;

		foreach my $r (@revorder) {
		    if ($r =~ /^${regex}\b/) {
			$rev = $branchrev;
			last;
		    }
		}
		next if ($rev eq "");
		if ($rev ne $head && $head ne "") {
		    $branchpoint{$head} .= ", " if ($branchpoint{$head});
		    $branchpoint{$head} .= $_;
		}
	    }
	    $revsym{$rev} .= ", " if ($revsym{$rev});
	    $revsym{$rev} .= $_;
	    $sel .= "<OPTION VALUE=\"${rev}:${_}\">$_\n";
	}
	print "Done associating revisions with branches\n" if ($verbose);

	my ($onlyonbranch, $onlybranchpoint);
	if ($onlyonbranch = $input{'only_with_tag'}) {
	    $onlyonbranch = $symrev{$onlyonbranch};
	    if ($onlyonbranch =~ s/\b0\.//) {
		($onlybranchpoint = $onlyonbranch) =~ s/\.\d+$//;
	    }
            else {
		$onlybranchpoint = $onlyonbranch;
	    }
	    if (!defined($onlyonbranch) || $onlybranchpoint eq "") {
		fatal("404 Tag not found","Tag $input{'only_with_tag'} not defined");
	    }
	}

	undef @revisions;

	foreach (@allrevisions) {
	    ($br = $_) =~ s/\.\d+$//;
	    ($brp = $br) =~ s/\.\d+$//;
	    next if ($onlyonbranch && $br ne $onlyonbranch &&
					$_ ne $onlybranchpoint);
	    unshift(@revisions,$_);
	}

	if ($logsort eq "date") {
	    # Sort the revisions in commit order an secondary sort on revision
	    # (secondary sort needed for imported sources, or the first main
	    # revision gets before the same revision on the 1.1.1 branch)
	    @revdisplayorder = sort {$date{$b} <=> $date{$a} || -revcmp($a, $b)} @revisions;
	}
        elsif ($logsort eq "rev") {
	    # Sort the revisions in revision order, highest first
	    @revdisplayorder = reverse sort {revcmp($a,$b)} @revisions;
	}
        else {
	    # No sorting. Present in the same order as rlog / cvs log
	    @revdisplayorder = @revisions;
	}

}

sub printDiffLinks($$) {
    my($text, $url) = @_;
    my @extra;

    local $_;
    for ($DIFFTYPES{$defaultDiffType}{'colored'} ? qw(u) : qw(h)) {
	my $f = $_ eq $defaultDiffType ? '' : $_;

	push @extra, &link(lc $DIFFTYPES{$_}{'descr'}, "$url&f=$f");
    }

    print &link($text, $url), ' (', join(', ', @extra), ')';
}

sub printLog($;$) {
	my ($link, $br, $brp);
	($_,$link) = @_;
	($br = $_) =~ s/\.\d+$//;
	($brp = $br) =~ s/\.?\d+$//;
	my ($isDead, $prev);

	$link = 1 if (!defined($link));
	$isDead = ($state{$_} eq "dead");

	if ($link && !$isDead) {
	    my ($filename);
	    ($filename = $where) =~ s/^.*\///;
	    my ($fileurl) = urlencode($filename);
	    print "<a NAME=\"rev$_\"></a>";
	    if (defined($revsym{$_})) {
		foreach my $sym (split(", ", $revsym{$_})) {
		    print "<a NAME=\"$sym\"></a>";
		}
	    }
	    if (defined($revsym{$br}) && $revsym{$br} && !defined($nameprinted{$br})) {
		foreach my $sym (split(", ", $revsym{$br})) {
		    print "<a NAME=\"$sym\"></a>";
		}
		$nameprinted{$br} = 1;
	    }
	    print "\n Revision ";
	    &download_link($fileurl, $_, $_,
			   $defaultViewable ? "text/x-cvsweb-markup" : undef);
	    if ($defaultViewable) {
		print " / (";
		&download_link($fileurl, $_, "download", $mimetype);
		print ")";
	    }
	    if (not $defaultTextPlain) {
		print " / (";
		&download_link($fileurl, $_, "as text", "text/plain");
		print ")";
	    }
	    if (!$defaultViewable) {
		print " / (";
		&download_link($fileurl, $_, "view", "text/x-cvsweb-markup");
		print ")";
	    }
	    if ($allow_annotate) {
		print " - ";
		print &link('annotate',
			    sprintf('%s/%s?annotate=%s%s',
				    $scriptname,
				    urlencode($where),
				    $_,
				    $barequery));
	    }
	    # Plus a select link if enabled, and this version isn't selected
	    if ($allow_version_select) {
		if ((!defined($input{"r1"}) || $input{"r1"} ne $_)) {
		    print " - ";
		    print &link('[select for diffs]',
				sprintf('%s?r1=%s%s',
					$scriptwhere,
					$_,
					$barequery));
		}
		else {
		    print " - <b>[selected]</b>";
		}
	    }
	}
	else {
	    print "Revision <B>$_</B>";
	}
	if (/^1\.1\.1\.\d+$/) {
	    print " <i>(vendor branch)</i>";
	}
	if (defined @mytz) {
	    my ($est) = $mytz[(localtime($date{$_}))[8]];
	    print ", <i>", scalar localtime($date{$_}), " $est</i> (";
	} else {
	    print ", <i>", scalar gmtime($date{$_}), " UTC</i> (";
	}
	print readableTime(time() - $date{$_},1), " ago)";
	print " by ";
	print "<i>", $author{$_}, "</i>\n";
	print "<BR>Branch: <b>",$link?link_tags($revsym{$br}):$revsym{$br},"</b>\n"
	    if ($revsym{$br});
	print "<BR>CVS Tags: <b>",$link?link_tags($revsym{$_}):$revsym{$_},"</b>"
	    if ($revsym{$_});
	print "<BR>Branch point for: <b>",$link?link_tags($branchpoint{$_}):$branchpoint{$_},"</b>\n"
	    if ($branchpoint{$_});
	# Find the previous revision
	my @prevrev = split(/\./, $_);
	do {
	    if (--$prevrev[$#prevrev] <= 0) {
		# If it was X.Y.Z.1, just make it X.Y
		pop(@prevrev);
		pop(@prevrev);
	    }
	    $prev = join(".", @prevrev);
	} until (defined($date{$prev}) || $prev eq "");
	if ($prev ne "") {
	    if ($difflines{$_}) {
		print "<BR>Changes since <b>$prev: $difflines{$_} lines</b>";
	    }
	}
	if ($isDead) {
	    print "<BR><B><I>FILE REMOVED</I></B>\n";
	}
	elsif ($link) {
	    my %diffrev = ();
	    $diffrev{$_} = 1;
	    $diffrev{""} = 1;
	    print "<BR>Diff";
	    #
	    # Offer diff to previous revision
	    if ($prev) {
		$diffrev{$prev} = 1;

		my $url = sprintf('%s.diff?r1=%s&r2=%s%s',
				  $scriptwhere,
				  $prev,
				  $_,
				  $barequery);

		print " to previous ";
		printDiffLinks($prev, $url);
	    }
	    #
	    # Plus, if it's on a branch, and it's not a vendor branch,
	    # offer a diff with the branch point.
	    if ($revsym{$brp} && !/^1\.1\.1\.\d+$/ && !defined($diffrev{$brp})) {
		my $url = sprintf('%s.diff?r1=%s&r2=%s%s',
				  $scriptwhere,
				  $brp,
				  $_,
				  $barequery);

		print " to branchpoint ";
		printDiffLinks($brp, $url);
	    }
	    #
	    # Plus, if it's on a branch, and it's not a vendor branch,
	    # offer to diff with the next revision of the higher branch.
	    # (e.g. change gets committed and then brought
	    # over to -stable)
	    if (/^\d+\.\d+\.\d+/ && !/^1\.1\.1\.\d+$/) {
		my ($i,$nextmain);
		for ($i = 0; $i < $#revorder && $revorder[$i] ne $_; $i++){}
		my @tmp2 = split(/\./, $_);
		for ($nextmain = ""; $i > 0; $i--) {
		    my $next = $revorder[$i-1];
		    my @tmp1 = split(/\./, $next);
		    if (@tmp1 < @tmp2) {
			$nextmain = $next;
			last;
		    }
		    # Only the highest version on a branch should have
		    # a diff for the "next main".
		    last if (@tmp1 - 1 <= @tmp2 &&
			     join(".",@tmp1[0..$#tmp1-1]) eq join(".",@tmp2[0..$#tmp1-1]));
		}
		if (!defined($diffrev{$nextmain})) {
		    $diffrev{$nextmain} = 1;

		    my $url = sprintf('%s.diff?r1=%s&r2=%s%s',
				      $scriptwhere,
				      $nextmain,
				      $_,
				      $barequery);

		    print " next main ";
		    printDiffLinks($nextmain, $url);
		}
	    }
	    # Plus if user has selected only r1, then present a link
	    # to make a diff to that revision
	    if (defined($input{"r1"}) && !defined($diffrev{$input{"r1"}})) {
		$diffrev{$input{"r1"}} = 1;

		my $url = sprintf('%s.diff?r1=%s&r2=%s%s',
				  $scriptwhere,
				  $input{'r1'},
				  $_,
				  $barequery);

		print " to selected ";
		printDiffLinks($input{'r1'}, $url);
	    }
	}
	print "<PRE>\n";
	print &htmlify($log{$_}, 1);
	print "</PRE>\n";
}

sub doLog($) {
	my($fullname) = @_;
	my ($diffrev, $upwhere, $filename, $backurl);

	readLog($fullname);

        html_header("CVS log for $where");
	($upwhere = $where) =~ s|(Attic/)?[^/]+$||;
        ($filename = $where) =~ s|^.*/||;
        $backurl = $scriptname . "/" . urlencode($upwhere) . $query;
	print &link($backicon, "$backurl#$filename"),
	  " <b>Up to ", &clickablePath($upwhere, 1), "</b><p>\n";
	print &link('Request diff between arbitrary revisions', '#diff');
        print '<HR NOSHADE>';

	if ($curbranch) {
	    print "Default branch: ", ($revsym{$curbranch} || $curbranch);
	}
	else {
	    print "No default branch";
	}
	print "<BR>\n";
	if ($input{only_with_tag}) {
	    print "Current tag: $input{only_with_tag}<BR>\n";
	}

	undef %nameprinted;

	for (my $i = 0; $i <= $#revdisplayorder; $i++) {
	    print "<HR size=1 NOSHADE>";
	    printLog($revdisplayorder[$i]);
	}

        print "<HR NOSHADE>";
	print "<A NAME=diff>\n";
	print "This form allows you to request diff's between any two\n";
	print "revisions of a file.  You may select a symbolic revision\n";
	print "name using the selection box or you may type in a numeric\n";
	print "name using the type-in text box.\n";
	print "</A><P>\n";
	print "<FORM METHOD=\"GET\" ACTION=\"${scriptwhere}.diff\" NAME=\"diff_select\">\n";
        foreach (@stickyvars) {
	    printf('<INPUT TYPE=HIDDEN NAME="%s" VALUE="%s">',  $_, $input{$_})
		if (defined($input{$_})
		    && ((!defined($DEFAULTVALUE{$_})
		         || $input{$_} ne $DEFAULTVALUE{$_})
		        && $input{$_} ne ""));
	}
	print "<TABLE><TR>\n";
	print "<TD align=right>Diffs between \n";
	print "<SELECT NAME=\"r1\">\n";
	print "<OPTION VALUE=\"text\" SELECTED>Use Text Field\n";
	print $sel;
	print "</SELECT>\n";
	$diffrev = $revdisplayorder[$#revdisplayorder];
	$diffrev = $input{"r1"} if (defined($input{"r1"}));
	print "<INPUT TYPE=\"TEXT\" SIZE=\"$inputTextSize\" NAME=\"tr1\" VALUE=\"$diffrev\" onChange='document.diff_select.r1.selectedIndex=0'></TD>";
	print "<TD><BR></TD></TR>\n";
	print "<TR><TD align=right>and \n";
	print "<SELECT NAME=\"r2\">\n";
	print "<OPTION VALUE=\"text\" SELECTED>Use Text Field\n";
	print $sel;
	print "</SELECT>\n";
	$diffrev = $revdisplayorder[0];
	$diffrev = $input{"r2"} if (defined($input{"r2"}));
	print "<INPUT TYPE=\"TEXT\" SIZE=\"$inputTextSize\" NAME=\"tr2\" VALUE=\"$diffrev\" onChange='document.diff_select.r2.selectedIndex=0'></TD>";
	print "<TD><INPUT TYPE=SUBMIT VALUE=\"  Get Diffs  \"></TD>\n";
	print "</FORM>\n";
	print "</TR></TABLE>\n";
	print "<HR noshade>\n";
	print "<TABLE>";
	print "<FORM METHOD=\"GET\" ACTION=\"$scriptwhere\">\n";
	print "<TR><TD align=right>Preferred Diff type:</TD>";
	print "<TD>";
	printDiffSelect($use_java_script);
	print "</TD><TD></TD></TR>\n";
        if (@branchnames) {
	    print "<TR><TD align=right>View only Branch:</TD>";
	    print "<TD>";
	    print "<A name=branch></A>\n";
	    print "<SELECT NAME=\"only_with_tag\"";
	    print " onchange=\"submit()\"" if ($use_java_script);
	    print ">\n";
	    print "<OPTION VALUE=\"\"";
	    print " SELECTED" if (defined($input{"only_with_tag"}) &&
		$input{"only_with_tag"} eq "");
	    print ">Show all branches\n";
	    foreach (reverse sort @branchnames) {
		print "<OPTION";
		print " SELECTED" if (defined($input{"only_with_tag"})
			&& $input{"only_with_tag"} eq $_);
		print ">${_}\n";
	    }
	    print "</SELECT></TD><TD></TD></TR>\n";
	}
	foreach (@stickyvars) {
	    next if ($_ eq "f");
	    next if ($_ eq "only_with_tag");
	    next if ($_ eq "logsort");
	    print "<INPUT TYPE=HIDDEN NAME=\"$_\" VALUE=\"$input{$_}\">\n"
		if (defined($input{$_})
		    && (!defined($DEFAULTVALUE{$_})
		        || $input{$_} ne $DEFAULTVALUE{$_})
		    && $input{$_} ne "");
	}
	print "<TR><TD align=right>";
	print "<A name=logsort></A>\n";
	print "Sort log by:</TD>";
	print "<TD>";
	printLogSortSelect($use_java_script);
	print "</TD>";
	print "<TD><INPUT TYPE=SUBMIT VALUE=\"  Set  \"></TD>";
	print "</FORM>\n";
	print "</TR></TABLE>";
        print &html_footer;
	print "</BODY></HTML>\n";
}

sub flush_diff_rows($$$$) {
    my $j;
    my ($leftColRef,$rightColRef,$leftRow,$rightRow) = @_;
    if ($state eq "PreChangeRemove") {          # we just got remove-lines before
      for ($j = 0 ; $j < $leftRow; $j++) {
          print  "<tr><td bgcolor=\"$diffcolorRemove\">@$leftColRef[$j]</td>";
          print  "<td bgcolor=\"$diffcolorEmpty\">&nbsp;</td></tr>\n";
      }
    }
    elsif ($state eq "PreChange") {             # state eq "PreChange"
      # we got removes with subsequent adds
      for ($j = 0; $j < $leftRow || $j < $rightRow ; $j++) {  # dump out both cols
          print  "<tr>";
          if ($j < $leftRow) {
	      print  "<td bgcolor=\"$diffcolorChange\">@$leftColRef[$j]</td>";
	  }
          else {
	      print  "<td bgcolor=\"$diffcolorDarkChange\">&nbsp;</td>";
	  }
          if ($j < $rightRow) {
	      print  "<td bgcolor=\"$diffcolorChange\">@$rightColRef[$j]</td>";
	  }
          else {
	      print  "<td bgcolor=\"$diffcolorDarkChange\">&nbsp;</td>";
	  }
          print  "</tr>\n";
      }
    }
}

##
# Function to generate Human readable diff-files
# human_readable_diff(String revision_to_return_to);
##
sub human_readable_diff($){
  my ($difftxt, $where_nd, $filename, $pathname, $scriptwhere_nd);
  my ($fh, $rev) = @_;
  my ($date1, $date2, $r1d, $r2d, $r1r, $r2r, $rev1, $rev2, $sym1, $sym2);
  my (@rightCol, @leftCol);

  ($where_nd = $where) =~ s/.diff$//;
  ($filename = $where_nd) =~ s/^.*\///;
  ($pathname = $where_nd) =~ s/(Attic\/)?[^\/]*$//;
  ($scriptwhere_nd = $scriptwhere) =~ s/.diff$//;

  navigateHeader($scriptwhere_nd, $pathname, $filename, $rev, "diff");

  # Read header to pick up read revision and date, if possible
  while (<$fh>) {
      ($r1d,$r1r) = /\t(.*)\t(.*)$/ if (/^--- /);
      ($r2d,$r2r) = /\t(.*)\t(.*)$/ if (/^\+\+\+ /);
      last if (/^\+\+\+ /);
  }
  if (defined($r1r) && $r1r =~ /^(\d+\.)+\d+$/) {
    $rev1 = $r1r;
    $date1 = $r1d;
  }
  if (defined($r2r) && $r2r =~ /^(\d+\.)+\d+$/) {
    $rev2 = $r2r;
    $date2 = $r2d;
  }

  print "<h3 align=center>Diff for /$where_nd between version $rev1 and $rev2</h3>\n",
    "<table border=0 cellspacing=0 cellpadding=0 width=\"100%\">\n",
      "<tr bgcolor=\"#ffffff\">\n",
	"<th width=\"50%\" valign=TOP>",
	  "version $rev1";
  print ", $date1" if (defined($date1));
  print "<br>Tag: $sym1\n" if ($sym1);
  print "</th>\n",
    "<th width=\"50%\" valign=TOP>",
      "version $rev2";
  print ", $date2" if (defined($date2));
  print "<br>Tag: $sym2\n" if ($sym1);
  print "</th>\n";

  my $fs = "<font face=\"$difffontface\" size=\"$difffontsize\"><tt>";
  my $fe = "</tt></font>";

  my $leftRow = 0;
  my $rightRow = 0;
  my ($oldline, $newline, $funname, $diffcode, $rest);

  # Process diff text
  # The diffrows are could make excellent use of
  # cascading style sheets because we've to set the
  # font and color for each row. anyone ...?
  ####

  # prefetch several lines
  my @buf = head($fh);

  my %d = scan_directives(@buf);

  while (@buf || !eof($fh)) {
      $difftxt = @buf ? shift @buf : <$fh>;

      if ($difftxt =~ /^@@/) {
	  ($oldline,$newline,$funname) = $difftxt =~ /@@ \-([0-9]+).*\+([0-9]+).*@@(.*)/;
          print  "<tr bgcolor=\"$diffcolorHeading\"><td width=\"50%\">";
	  print  "<table width=\"100%\" border=1 cellpadding=5><tr><td><b>Line $oldline</b>";
	  print  "&nbsp;<font size=-1>$funname</font></td></tr></table>";
          print  "</td><td width=\"50%\">";
	  print  "<table width=\"100%\" border=1 cellpadding=5><tr><td><b>Line $newline</b>";
	  print  "&nbsp;<font size=-1>$funname</font></td></tr></table>";
	  print  "</td>\n";
	  $state = "dump";
	  $leftRow = 0;
	  $rightRow = 0;
      }
      else {
	  ($diffcode,$rest) = $difftxt =~ /^([-+ ])(.*)/;
	  $_ = spacedHtmlText($rest, $d{'tabstop'});

	  # Add fontface, size
	  $_ = "$fs&nbsp;$_$fe";

	  #########
	  # little state machine to parse unified-diff output (Hen, zeller@think.de)
	  # in order to get some nice 'ediff'-mode output
	  # states:
	  #  "dump"             - just dump the value
	  #  "PreChangeRemove"  - we began with '-' .. so this could be the start of a 'change' area or just remove
	  #  "PreChange"        - okey, we got several '-' lines and moved to '+' lines -> this is a change block
	  ##########

	  if ($diffcode eq '+') {
	      if ($state eq "dump") {  # 'change' never begins with '+': just dump out value
		  print  "<tr><td bgcolor=\"$diffcolorEmpty\">&nbsp;</td><td bgcolor=\"$diffcolorAdd\">$_</td></tr>\n";
	      }
	      else {                   # we got minus before
		  $state = "PreChange";
		  $rightCol[$rightRow++] = $_;
	      }
	  }
	  elsif ($diffcode eq '-') {
	      $state = "PreChangeRemove";
	      $leftCol[$leftRow++] = $_;
        }
        else {  # empty diffcode
            flush_diff_rows \@leftCol, \@rightCol, $leftRow, $rightRow;
	      print  "<tr><td>$_</td><td>$_</td></tr>\n";
	      $state = "dump";
	      $leftRow = 0;
	      $rightRow = 0;
	  }
      }
  }
  flush_diff_rows \@leftCol, \@rightCol, $leftRow, $rightRow;

  # state is empty if we didn't have any change
  if (!$state) {
      print "<tr><td colspan=2>&nbsp;</td></tr>";
      print "<tr bgcolor=\"$diffcolorEmpty\" >";
      print "<td colspan=2 align=center><b>- No viewable Change -</b></td></tr>";
  }
  print  "</table>";
  close($fh);

  print "<br><hr noshade width=\"100%\">\n";

  print "<table border=0>";

  print "<tr><td>";
  # print legend
  print "<table border=1><tr><td>";
  print  "Legend:<br><table border=0 cellspacing=0 cellpadding=1>\n";
  print  "<tr><td align=center bgcolor=\"$diffcolorRemove\">Removed from v.$rev1</td><td bgcolor=\"$diffcolorEmpty\">&nbsp;</td></tr>";
  print  "<tr bgcolor=\"$diffcolorChange\"><td align=center colspan=2>changed lines</td></tr>";
  print  "<tr><td bgcolor=\"$diffcolorEmpty\">&nbsp;</td><td align=center bgcolor=\"$diffcolorAdd\">Added in v.$rev2</td></tr>";
  print  "</table></td></tr></table>\n";

  print "<td>";
  # Print format selector
  print "<FORM METHOD=\"GET\" ACTION=\"${scriptwhere}\">\n";
  foreach my $var (keys %input) {
    next if ($var eq "f");
    next if (defined($DEFAULTVALUE{$var})
	     && $DEFAULTVALUE{$var} eq $input{$var});
    print "<INPUT TYPE=HIDDEN NAME=\"",urlencode($var),"\" VALUE=\"",
	    urlencode($input{$var}),"\">\n";
  }
  printDiffSelect($use_java_script);
  print "<INPUT TYPE=SUBMIT VALUE=\"Show\">\n";
  print "</FORM>\n";
  print "</td>";

  print "</tr></table>";
}

sub navigateHeader($$$$$) {
    my ($swhere,$path,$filename,$rev,$title) = @_;
    $swhere = "" if ($swhere eq $scriptwhere);
    $swhere = './', urlencode($filename) if ($swhere eq "");

    print <<EOF;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META name="robots" content="nofollow">
<!-- knu-cvsweb $cvsweb_revision -->
<TITLE>$path$filename - $title - $rev</TITLE></HEAD>
$body_tag_for_src
<table width="100%" border=0 cellspacing=0 cellpadding=1 bgcolor="$navigationHeaderColor">
<tr valign=bottom><td>
EOF

    print &link($backicon, "$swhere$query#rev$rev");
    print "<b>Return to ", &link($filename,"$swhere$query#rev$rev")," CVS log";
    print "</b> $fileicon</td>";

    print "<td align=right>$diricon <b>Up to ", &clickablePath($path, 1), "</b></td>";
    print "</tr></table>";
}

sub plural_write($$) {
    my ($num,$text) = @_;
    if ($num != 1) {
	$text .= "s";
    }
    if ($num > 0) {
	return join(' ', $num, $text);
    }
    else {
	return "";
    }
}

##
# print readable timestamp in terms of
# '..time ago'
# H. Zeller <zeller@think.de>
##
sub readableTime($$) {
    my ($i, $break, $retval);
    my ($secs,$long) = @_;

    # this function works correct for time >= 2 seconds
    if ($secs < 2) {
	return "very little time";
    }

    my %desc = (1 , 'second',
		   60, 'minute',
		   3600, 'hour',
		   86400, 'day',
		   604800, 'week',
		   2628000, 'month',
		   31536000, 'year');
    my @breaks = sort {$a <=> $b} keys %desc;
    $i = 0;
    while ($i <= $#breaks && $secs >= 2 * $breaks[$i]) {
	$i++;
    }
    $i--;
    $break = $breaks[$i];
    $retval = plural_write(int ($secs / $break), $desc{$break});

    if ($long == 1 && $i > 0) {
	my $rest = $secs % $break;
	$i--;
	$break = $breaks[$i];
	my $resttime = plural_write(int ($rest / $break),
				$desc{$break});
	if ($resttime) {
	    $retval .= ", $resttime";
	}
    }

    return $retval;
}

##
# clickablePath(String pathname, boolean last_item_clickable)
#
# returns a html-ified path whereas each directory is a link for
# faster navigation. last_item_clickable controls whether the
# basename (last directory/file) is a link as well
##
sub clickablePath($$) {
    my ($pathname,$clickLast) = @_;
    my $retval = '';

    if ($pathname eq '/') {
	# this should never happen - chooseCVSRoot() is
	# intended to do this
	$retval = "[$cvstree]";
    }
    else {
	$retval .= ' ' . &link("[$cvstree]", sprintf('%s/%s#dirlist',
						     $scriptname,
						     $query));
	my $wherepath = '';
	my ($lastslash) = $pathname =~ m|/$|;
	foreach (split(/\//, $pathname)) {
	    $retval .= " / ";
	    $wherepath .= "/$_";
	    my ($last) = "$wherepath/" eq "/$pathname"
		|| $wherepath eq "/$pathname";
	    if ($clickLast || !$last) {
		$retval .= &link($_, join('',
					  $scriptname,
					  urlencode($wherepath),
					  (!$last || $lastslash ? '/' : ''),
					  $query,
					  (!$last || $lastslash ? "#dirlist" : "")));
	    }
	    else { # do not make a link to the current dir
		$retval .= $_;
	    }
	}
    }
    return $retval;
}

sub chooseCVSRoot() {
    if (2 <= @CVSROOT) {
	my ($k);
	print "<form method=\"GET\" action=\"${scriptwhere}\">\n";
	foreach $k (keys %input) {
	    print "<input type=hidden NAME=$k VALUE=$input{$k}>\n"
		if ($input{$k}) && ($k ne "cvsroot");
	}
	# Form-Elements look wierd in Netscape if the background
	# isn't gray and the form elements are not placed
	# within a table ...
	print "<table><tr>";
	print "<td>CVS Root:</td>";
	print "<td>\n<select name=\"cvsroot\"";
	print " onchange=\"submit()\"" if ($use_java_script);
	print ">\n";
	foreach $k (@CVSROOT) {
	    print "<option value=\"$k\"";
	    print " selected" if ($k eq $cvstree);
	    print ">", ($CVSROOTdescr{$k} ? $CVSROOTdescr{$k} : $k), "</option>\n";
	}
	print "</select>\n</td>";
	print "<td>";
    }
    else {
	# no choice ..
	print "CVS Root: <b>[$cvstree]</b>";
    }

    print " Module path or alias:\n";
    print "<INPUT TYPE=TEXT NAME=\"path\" VALUE=\"\" SIZE=15>\n";
    print "<input type=submit value=\"Go\">";

    if (2 <= @CVSROOT) {
	print "</td></tr></table></form>";
    }
}

sub chooseMirror() {
    my ($mirror,$moremirrors);
    $moremirrors = 0;
    # This code comes from the original BSD-cvsweb
    # and may not be useful for your site; If you don't
    # set %MIRRORS this won't show up, anyway
    #
    # Should perhaps exlude the current site somehow..
    if (keys %MIRRORS) {
	print "\nThis cvsweb is mirrored in:\n";
	foreach $mirror (keys %MIRRORS) {
	    print ", " if ($moremirrors);
	    print &link(htmlquote($mirror),$MIRRORS{$mirror});
	    $moremirrors = 1;
	}
	print "<p>\n";
    }
}

sub fileSortCmp() {
    my ($comp) = 0;
    my ($c,$d,$af,$bf);

    ($af = $a) =~ s/,v$//;
    ($bf = $b) =~ s/,v$//;
    my ($rev1,$date1,$log1,$author1,$filename1) = @{$fileinfo{$af}}
        if (defined($fileinfo{$af}));
    my ($rev2,$date2,$log2,$author2,$filename2) = @{$fileinfo{$bf}}
        if (defined($fileinfo{$bf}));

    if (defined($filename1) && defined($filename2) && $af eq $filename1 && $bf eq $filename2) {
	# Two files
	$comp = -revcmp($rev1, $rev2) if ($byrev && $rev1 && $rev2);
	$comp = ($date2 <=> $date1) if ($bydate && $date1 && $date2);
	$comp = ($log1 cmp $log2) if ($bylog && $log1 && $log2);
	$comp = ($author1 cmp $author2) if ($byauthor && $author1 && $author2);
    }
    if ($comp == 0) {
	# Directories first, then sorted on name if no other sort critera
	# available.
	my $ad = ((-d "$fullname/$a")?"D":"F");
	my $bd = ((-d "$fullname/$b")?"D":"F");
	($c=$a) =~ s|.*/||;
	($d=$b) =~ s|.*/||;
	$comp = ("$ad$c" cmp "$bd$d");
    }
    return $comp;
}

# make A url for downloading
sub download_url($$;$) {
    my ($url,$revision,$mimetype) = @_;

    $revision =~ s/\b0\.//;

    if (defined($checkoutMagic)
	&& (!defined($mimetype) || $mimetype ne "text/x-cvsweb-markup")) {
	my $path = $where;
	$path =~ s|/[^/]*$|/|;
	$url = "$scriptname/$checkoutMagic/${path}$url";
    }
    $url .= "?rev=$revision";
    $url .= '&content-type=' . urlencode($mimetype) if (defined($mimetype));

    $url;
}

# Presents a link to download the
# selected revision
sub download_link($$$;$) {
    my ($url, $revision, $textlink, $mimetype) = @_;
    my ($fullurl) = download_url($url, $revision, $mimetype);

    $fullurl =~ s/:/sprintf("%%%02x", ord($&))/eg;

    printf '<A HREF="%s"', hrefquote("$fullurl$barequery");

    if ($open_extern_window && (!defined($mimetype) || $mimetype ne "text/x-cvsweb-markup")) {
	print ' target="cvs_checkout"';
	# we should have
	#   'if (document.cvswin==null) document.cvswin=window.open(...'
	# in order to allow the user to resize the window; otherwise
	# the user may resize the window, but on next checkout - zap -
	# its original (configured s. cvsweb.conf) size is back again
	# .. annoying (if $extern_window_(width|height) is defined)
	# but this if (..) solution is far from perfect
	# what we need to do as well is
	# 1) save cvswin in an invisible frame that always exists
	#    (document.cvswin will be void on next load)
	# 2) on close of the cvs_checkout - window set the cvswin
	#    variable to 'null' again - so that it will be
	#    reopenend with the configured size
	# anyone a JavaScript programmer ?
	# .. so here without if (..):
	# currently, the best way is to comment out the size parameters
	# ($extern_window...) in cvsweb.conf.
	if ($use_java_script) {
	    my @attr = qw(resizeable scrollbars);

	    push @attr, qw(status toolbar)
	      if (defined($mimetype) && $mimetype eq "text/html");

	    push @attr, "width=$extern_window_width"
	      if (defined($extern_window_width));

	    push @attr, "height=$extern_window_height"
	      if (defined($extern_window_height));

	    printf q` onClick="window.open('%s','cvs_checkout','%s');"`,
	      hrefquote($fullurl), join(',', @attr);
	}
    }
    print "><b>$textlink</b></A>";
}

# Returns a Query string with the
# specified parameter toggled
sub toggleQuery($$) {
    my ($toggle,$value) = @_;
    my ($newquery,$var);
    my (%vars);
    %vars = %input;
    if (defined($value)) {
	$vars{$toggle} = $value;
    }
    else {
	$vars{$toggle} = $vars{$toggle} ? 0 : 1;
    }
    # Build a new query of non-default paramenters
    $newquery = "";
    foreach $var (@stickyvars) {
	my ($value) = defined($vars{$var}) ? $vars{$var} : "";
	my ($default) = defined($DEFAULTVALUE{$var}) ? $DEFAULTVALUE{$var} : "";
	if ($value ne $default) {
	    $newquery .= "&" if ($newquery ne "");
	    $newquery .= urlencode($var) . "=" . urlencode($value);
	}
    }
    if ($newquery) {
	return '?' . $newquery;
    }
    return "";
}

sub urlencode($) {
    local($_) = @_;

    s/[\000-+{-\377]/sprintf("%%%02x", ord($&))/ge;

    $_;
}

sub htmlquote($) {
    local($_) = @_;

    # Special Characters; RFC 1866
    s/&/&amp;/g;
    s/\"/&quot;/g;
    s/</&lt;/g;
    s/>/&gt;/g;

    $_;
}

sub htmlunquote($) {
    local($_) = @_;

    # Special Characters; RFC 1866
    s/&quot;/\"/g;
    s/&lt;/</g;
    s/&gt;/>/g;
    s/&amp;/&/g;

    $_;
}

sub hrefquote($) {
    local($_) = @_;

    y/ /+/;

    htmlquote($_)
}

sub http_header(;$) {
    my $content_type = shift || "text/html";

    $content_type .= "; charset=$charset"
      if $content_type =~ m,^text/, && defined($charset) && $charset;

    if (defined($moddate)) {
	if ($is_mod_perl) {
	    Apache->request->header_out("Last-Modified" => scalar gmtime($moddate) . " GMT");
	}
	else {
	    print "Last-Modified: ", scalar gmtime($moddate), " GMT\r\n";
	}
    }
    if ($is_mod_perl) {
	Apache->request->content_type($content_type);
    }
    else {
	    print "Content-type: $content_type\r\n";
    }
    if ($allow_compress && $maycompress) {
	if ($has_zlib || (defined($CMD{gzip}) && open(GZIP, "| $CMD{gzip} -1 -c"))) {
	    if ($is_mod_perl) {
		    Apache->request->content_encoding("x-gzip");
		    Apache->request->header_out(Vary => "Accept-Encoding");
		    Apache->request->send_http_header;
	    }
	    else {
		    print "Content-encoding: x-gzip\r\n";
		    print "Vary: Accept-Encoding\r\n";  #RFC 2068, 14.43
		    print "\r\n"; # Close headers
	    }
	    $| = 1; $| = 0; # Flush header output
	    if ($has_zlib) {
	    	tie *GZIP, __PACKAGE__, \*STDOUT;
	    }
	    select(GZIP);
	    $gzip_open = 1;
#	    print "<!-- gzipped -->" if ($content_type =~ m|^text/html\b|);
	}
	else {
	    if ($is_mod_perl) {
		    Apache->request->send_http_header;
	    }
	    else {
		    print "\r\n"; # Close headers
	    }
	    print "<font size=-1>Unable to find gzip binary in the <b>\$command_path</b> ($command_path) to compress output</font><br>";
	}
    }
    else {
	    if ($is_mod_perl) {
		    Apache->request->send_http_header;
	    }
	    else {
		    print "\r\n"; # Close headers
	    }
    }
}

sub html_header($) {
    my ($title) = @_;
    http_header("text/html");

    (my $header = &cgi_style::html_header) =~ s/^.*\n\n//; # remove HTTP response header

    print <<EOH;
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN"
 "http://www.w3.org/TR/REC-html40/loose.dtd">
$header
<!-- knu-cvsweb $cvsweb_revision -->
EOH
}

sub html_footer() {
    return &cgi_style::html_footer;
}

sub link_tags($) {
    my ($tags) = @_;
    my ($ret) = "";
    my ($fileurl,$filename);

    ($filename = $where) =~ s/^.*\///;
    $fileurl = './' . urlencode($filename);

    foreach my $sym (split(", ", $tags)) {
	$ret .= ",\n" if ($ret ne "");
	$ret .= &link($sym, $fileurl . toggleQuery('only_with_tag',$sym));
    }
    return "$ret\n";
}

#
# See if a module is listed in the config file's @HideModule list.
#
sub forbidden_module($) {
    my($module) = @_;

    for (my $i=0; $i < @HideModules; $i++) {
	return 1 if $module eq $HideModules[$i];
    }

    return 0;
}

# Close the GZIP handle remove the tie.

sub gzipclose {
	if ($gzip_open) {
	    select(STDOUT);
	    close(GZIP);
	    untie *GZIP;
	    $gzip_open = 0;
	}
}

# implement a gzipped file handle via the Compress:Zlib compression
# library.

sub MAGIC1() { 0x1f }
sub MAGIC2() { 0x8b }
sub OSCODE() { 3    }

sub TIEHANDLE {
	my ($class, $out) = @_;
	my ($d) = Compress::Zlib::deflateInit(-Level => Compress::Zlib::Z_BEST_COMPRESSION(),
		-WindowBits => -Compress::Zlib::MAX_WBITS()) or return undef;
	my ($o) = {
		handle => $out,
		dh => $d,
		crc => 0,
		len => 0,
	};
	my ($header) = pack("c10", MAGIC1, MAGIC2, Compress::Zlib::Z_DEFLATED(), 0,0,0,0,0,0, OSCODE);
	print {$o->{handle}} $header;
	return bless($o, $class);
}

sub PRINT {
	my ($o) = shift;
	my ($buf) = join(defined $, ? $, : "",@_);
	my ($len) = length($buf);
	my ($compressed, $status) = $o->{dh}->deflate($buf);
	print {$o->{handle}} $compressed if defined($compressed);
	$o->{crc} = Compress::Zlib::crc32($buf, $o->{crc});
	$o->{len} += $len;
	return $len;
}

sub PRINTF {
	my ($o) = shift;
	my ($fmt) = shift;
	my ($buf) = sprintf($fmt, @_);
	my ($len) = length($buf);
	my ($compressed, $status) = $o->{dh}->deflate($buf);
	print {$o->{handle}} $compressed if defined($compressed);
	$o->{crc} = Compress::Zlib::crc32($buf, $o->{crc});
	$o->{len} += $len;
	return $len;
}

sub WRITE {
	my ($o, $buf, $len, $off) = @_;
	my ($compressed, $status) = $o->{dh}->deflate(substr($buf, 0, $len));
	print {$o->{handle}} $compressed if defined($compressed);
	$o->{crc} = Compress::Zlib::crc32(substr($buf, 0, $len), $o->{crc});
	$o->{len} += $len;
	return $len;
}

sub CLOSE {
	my ($o) = @_;
	return if !defined( $o->{dh});
	my ($buf) = $o->{dh}->flush();
	$buf .= pack("V V", $o->{crc}, $o->{len});
	print {$o->{handle}} $buf;
	undef $o->{dh};
}

sub DESTROY {
	my ($o) = @_;
	CLOSE($o);
}

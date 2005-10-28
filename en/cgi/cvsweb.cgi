#!/usr/bin/perl -wT
#
# cvsweb - a CGI interface to CVS trees.
#
# Written in their spare time by
#             Bill Fenner          <fenner@FreeBSD.org>   (original work)
# extended by Henner Zeller        <zeller@think.de>,
#             Henrik Nordstrom     <hno@hem.passagen.se>
#             Ken Coar             <coar@Apache.Org>
#             Dick Balaska         <dick@buckosoft.com>
#             Akinori MUSHA        <knu@FreeBSD.org>
#             Jens-Uwe Mager       <jum@helios.de>
#             Ville Skyttä         <scop@FreeBSD.org>
#             Vassilii Khachaturov <vassilii@tarunz.org>
#
# Based on:
# * Bill Fenners cvsweb.cgi revision 1.28 available from:
#   http://www.FreeBSD.org/cgi/cvsweb.cgi/www/en/cgi/cvsweb.cgi
#
# Copyright (c) 1996-1998 Bill Fenner
#           (c) 1998-1999 Henner Zeller
#           (c) 1999      Henrik Nordstrom
#           (c) 2000-2002 Akinori MUSHA
#           (c) 2002      Ville Skyttä
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
# $Id: cvsweb.cgi,v 1.89 2005-10-28 14:55:57 fenner Exp $
# $Idaemons: /home/cvs/cvsweb/cvsweb.cgi,v 1.84 2001/10/07 20:50:10 knu Exp $
# $FreeBSD: www/en/cgi/cvsweb.cgi,v 1.88 2002/09/30 21:02:05 scop Exp $
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
    $where $pathinfo $Browser $nofilelinks $maycompress
    @stickyvars @unsafevars
    %funcline_regexp $is_mod_perl
    $is_links $is_lynx $is_w3m $is_msie $is_mozilla3 $is_textbased
    %input $query $barequery $sortby $bydate $byrev $byauthor
    $bylog $byfile $defaultDiffType $logsort $cvstree $cvsroot
    $mimetype $charset $output_filter $defaultTextPlain $defaultViewable
    $command_path %CMD $allow_compress
    $backicon $diricon $fileicon
    $fullname $newname $cvstreedefault
    $body_tag $body_tag_for_src $logo $defaulttitle $address
    $long_intro $short_instruction $shortLogLen
    $show_author $dirtable $tablepadding $columnHeaderColorDefault
    $columnHeaderColorSorted $hr_breakable $showfunc $hr_ignwhite
    $hr_ignkeysubst $diffcolorHeading $diffcolorEmpty $diffcolorRemove
    $diffcolorChange $diffcolorAdd $diffcolorDarkChange $difffontface
    $difffontsize $inputTextSize $mime_types
    $allow_annotate $allow_markup
    $allow_log_extra $allow_dir_extra $allow_source_extra
    $use_java_script $open_extern_window
    $extern_window_width $extern_window_height $edit_option_form
    $show_subdir_lastmod $show_log_in_markup $preformat_in_markup $v
    $navigationHeaderColor $tableBorderColor $markupLogColor
    $tabstop $state $annTable $sel $curbranch @HideModules @ForbiddenFiles
    $module $use_descriptions %descriptions @mytz $dwhere $moddate
    $use_moddate $has_zlib $gzip_open
    $allow_tar @tar_options @gzip_options @zip_options @cvs_options
    @annotate_options $LOG_FILESEPARATOR $LOG_REVSEPARATOR
    $tmpdir $HTML_DOCTYPE $HTML_META
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
sub fatal($$@);
sub redirect($);
sub safeglob($);
sub search_path($);
sub getMimeTypeFromSuffix($);
sub head($;$);
sub scan_directives(@);
sub openOutputFilter();
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
sub forbidden_file($);
sub forbidden_module($);

##### Start of Configuration Area ########
delete $ENV{PATH};

$cvsweb_revision = '2.0.6';

use File::Basename ();

($mydir) = (File::Basename::dirname($0) =~ /(.*)/);    # untaint

# == EDIT this ==
# Locations to search for user configuration, in order:
for ("$mydir/cvsweb.conf", '/usr/local/etc/cvsweb/cvsweb.conf') {
	if (defined($_) && -r $_) {
		$config = $_;
		last;
	}
}

# == Configuration defaults ==
# Defaults for configuration variables that shouldn't need
# to be configured..
$allow_version_select = 1;
$allow_log_extra = 1;

##### End of Configuration Area   ########

######## Configuration variables #########
# These are defined to allow checking with perl -cw
@CVSrepositories = @CVSROOT = %CVSROOT = %MIRRORS = %DEFAULTVALUE = %ICONS =
    %MTYPES = %tags = %alltags = @tabcolors = %fileinfo = ();
$cvstreedefault = $body_tag = $body_tag_for_src = $logo = $defaulttitle =
    $address = $long_intro = $short_instruction = $shortLogLen = $show_author =
    $dirtable = $tablepadding = $columnHeaderColorDefault =
    $columnHeaderColorSorted = $hr_breakable = $showfunc = $hr_ignwhite =
    $hr_ignkeysubst = $diffcolorHeading = $diffcolorEmpty = $diffcolorRemove =
    $diffcolorChange = $diffcolorAdd  = $diffcolorDarkChange = $difffontface   =
    $difffontsize    = $inputTextSize = $mime_types          = $allow_annotate =
    $allow_markup        = $use_java_script      = $open_extern_window =
    $extern_window_width = $extern_window_height = $edit_option_form   =
    $show_subdir_lastmod = $show_log_in_markup = $v = $navigationHeaderColor =
    $tableBorderColor = $markupLogColor = $tabstop = $use_moddate = $moddate =
    $gzip_open = $HTML_DOCTYPE = $HTML_META = undef;
$tmpdir = defined($ENV{TMPDIR}) ? $ENV{TMPDIR} : "/var/tmp";

$LOG_FILESEPARATOR = q/^={77}$/;
$LOG_REVSEPARATOR  = q/^-{28}$/;

@DIFFTYPES = qw(h H u c s);
@DIFFTYPES{@DIFFTYPES} = (
	{
		'descr'   => 'colored',
		'opts'    => ['-u'],
		'colored' => 1,
	},
	{
		'descr'   => 'long colored',
		'opts'    => ['--unified=15'],
		'colored' => 1,
	},
	{
		'descr'   => 'unified',
		'opts'    => ['-u'],
		'colored' => 0,
	},
	{
		'descr'   => 'context',
		'opts'    => ['-c'],
		'colored' => 0,
	},
	{
		'descr'   => 'side by side',
		'opts'    => ['--side-by-side', '--width=164'],
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

$cgi_style::hsty_base = 'http://www.FreeBSD.org';
$_ = q$FreeBSD: www/en/cgi/cvsweb.cgi,v 1.88 2002/09/30 21:02:05 scop Exp $;
@_ = split;
$cgi_style::hsty_date = "@_[3,4]";

# warningproof
0 if $cgi_style::hsty_base ne $cgi_style::hsty_date;

package cgi_style;
require "$main::mydir/cgi-style.pl";
package main;

$HTML_DOCTYPE =
  '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">';

$HTML_META = <<EOM;
<meta name="robots" content="nofollow">
<meta name="generator" content="FreeBSD-CVSweb $cvsweb_revision">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
EOM

##### End of configuration variables #####

use Time::Local ();
use IPC::Open2 qw(open2);

# Check if the zlib C library interface is installed, and if yes
# we can avoid using the extra gzip process.
eval { require Compress::Zlib; };
$has_zlib = !$@;

$verbose       = $v;
$checkoutMagic = "~checkout~";
$pathinfo      = defined($ENV{PATH_INFO}) ? $ENV{PATH_INFO} : '';
$where         = $pathinfo;
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
$is_links    = ($Browser =~ m`^Links `);
$is_lynx     = ($Browser =~ m`^Lynx/`i);
$is_w3m      = ($Browser =~ m`^w3m/`i);
$is_msie     = ($Browser =~ m`MSIE`);
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
$maycompress =
    (((defined($ENV{HTTP_ACCEPT_ENCODING})
    && $ENV{HTTP_ACCEPT_ENCODING} =~ m`gzip`) || $is_mozilla3) && !$is_msie
    && !($is_mod_perl && !$has_zlib));

# put here the variables we need in order
# to hold our state - they will be added (with
# their current value) to any link/query string
# you construct
@stickyvars = qw(cvsroot hideattic sortby logsort f only_with_tag);
@unsafevars = qw(logsort only_with_tag r1 r2 rev sortby tr1 tr2);

if (-f $config) {
	do "$config" or fatal("500 Internal Error",
			      'Error in loading configuration file: %s<br><br>%s<br>',
			      $config, $@);
} else {
	fatal("500 Internal Error",
	      'Configuration not found.  Set the variable <code>$config</code> in cvsweb.cgi to your <b>cvsweb.conf</b> configuration file first.'
	     );
}

undef %input;
$query = $ENV{QUERY_STRING};

if (defined($query) && $query ne '') {
	foreach (split (/&/, $query)) {
		y/+/ /;
		s/%(..)/sprintf("%c", hex($1))/ge;    # unquote %-quoted
		if (/(\S+)=(.*)/) {
			$input{$1} = $2 if ($2 ne "");
		} else {
			$input{$_}++;
		}
	}
}

# For backwards compability, set only_with_tag to only_on_branch if set.
$input{only_with_tag} = $input{only_on_branch}
    if (defined($input{only_on_branch}));

# Prevent cross-site scripting
foreach (@unsafevars) {
	# Colons are needed in diffs between tags.
	if (defined($input{$_}) && $input{$_} =~ /[^\w\-.:]/) {
		fatal("500 Internal Error",
		      'Malformed query (%s=%s)',
		      $_, $input{$_});
	}
}

if (defined($input{"content-type"})) {
	fatal("500 Internal Error", "Unsupported content-type")
	    if ($input{"content-type"} !~ /^[-0-9A-Za-z]+\/[-0-9A-Za-z]+$/);
}

$DEFAULTVALUE{'cvsroot'} = $cvstreedefault;

foreach (keys %DEFAULTVALUE) {

	# replace not given parameters with the default parameters
	if (!defined($input{$_}) || $input{$_} eq "") {

		# Empty Checkboxes in forms return -- nothing. So we define a helper
		# variable in these forms (copt) which indicates that we just set
		# parameters with a checkbox
		if (!defined($input{"copt"})) {

			# 'copt' isn't defined --> empty input is not the result
			# of empty input checkbox --> set default
			$input{$_} = $DEFAULTVALUE{$_}
			    if (defined($DEFAULTVALUE{$_}));
		} else {

			# 'copt' is defined -> the result of empty input checkbox
			# -> set to zero (disable) if default is a boolean (0|1).
			$input{$_} = 0
			    if (defined($DEFAULTVALUE{$_})
			    && ($DEFAULTVALUE{$_} eq "0"
			    || $DEFAULTVALUE{$_} eq "1"));
		}
	}
}

$barequery = "";
my @barequery;
foreach (@stickyvars) {

	# construct a query string with the sticky non default parameters set
	if (defined($input{$_}) && $input{$_} ne ''
	    && !(defined($DEFAULTVALUE{$_}) && $input{$_} eq $DEFAULTVALUE{$_}))
	{
		push @barequery,
		    join ('=', urlencode($_), urlencode($input{$_}));
	}
}

# is there any query ?
if (@barequery) {
	$barequery = join ('&', @barequery);
	$query     = "?$barequery";
	$barequery = "&$barequery";
} else {
	$query = "";
}
undef @barequery;

if (defined($input{path})) {
	redirect("$scriptname/$input{path}$query");
}

# get actual parameters
$sortby   = $input{"sortby"};
$bydate   = 0;
$byrev    = 0;
$byauthor = 0;
$bylog    = 0;
$byfile   = 0;
if ($sortby eq "date") {
	$bydate = 1;
} elsif ($sortby eq "rev") {
	$byrev = 1;
} elsif ($sortby eq "author") {
	$byauthor = 1;
} elsif ($sortby eq "log") {
	$bylog = 1;
} else {
	$byfile = 1;
}

$defaultDiffType = $input{'f'};

$logsort = $input{'logsort'};

{
	my @tmp = @CVSrepositories;
	my @pair;

	while (@pair = splice(@tmp, 0, 2)) {
		my ($key,   $val)     = @pair;
		my ($descr, $cvsroot) = @$val;

		next if !-d $cvsroot;

		$CVSROOTdescr{$key} = $descr;
		$CVSROOT{$key}      = $cvsroot;
		push @CVSROOT, $key;
	}
}

## Default CVS-Tree
if (!defined($CVSROOT{$cvstreedefault})) {
	fatal("500 Internal Error",
	      '<code>$cvstreedefault</code> points to a repository (%s) not defined in <code>%%CVSROOT</code> (edit your configuration file %s)',
	      $cvstreedefault, $config);
}

# alternate CVS-Tree, configured in cvsweb.conf
if ($input{'cvsroot'} && $CVSROOT{$input{'cvsroot'}}) {
	$cvstree = $input{'cvsroot'};
} else {
	$cvstree = $cvstreedefault;
}

$cvsroot = $CVSROOT{$cvstree};

# create icons out of description
foreach my $k (keys %ICONS) {
	no strict 'refs';
	my ($itxt, $ipath, $iwidth, $iheight) = @{$ICONS{$k}};
	if ($ipath) {
		${"${k}icon"} =
		    sprintf(
			'<img src="%s" alt="%s" border="0" width="%d" height="%d">',
			hrefquote($ipath), htmlquote($itxt), $iwidth, $iheight)
	} else {
		${"${k}icon"} = $itxt;
	}
}

my $config_cvstree = "$config-$cvstree";

# Do some special configuration for cvstrees
if (-f $config_cvstree) {
	do "$config_cvstree" or
	    fatal("500 Internal Error",
		  'Error in loading configuration file: %s<br><br>%s<br>',
		  $config_cvstree, $@);
}
undef $config_cvstree;

$re_prcategories = '(?:' . join ('|', @prcategories) . ')' if @prcategories;
$re_prkeyword = quotemeta($prkeyword) if defined($prkeyword);
$prcgi .= '%s' if defined($prcgi) && $prcgi !~ /%s/;

$fullname         = "$cvsroot/$where";
$mimetype         = &getMimeTypeFromSuffix($fullname);
$defaultTextPlain = ($mimetype eq "text/plain");
$defaultViewable  = $allow_markup && viewable($mimetype);

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
	fatal("500 Internal Error",
	      '$CVSROOT not found!<p>The server on which the CVS tree lives is probably down.  Please try again in a few minutes.');
}

#
# See if the module is in our forbidden list.
#
$where =~ m:([^/]*):;
$module = $1;
if ($module && &forbidden_module($module)) {
	fatal("403 Forbidden",
	      'Access to %s forbidden.',
	      $where);
}

#
# Handle tarball downloads before any headers are output.
#
if ($input{tarball}) {
	fatal("403 Forbidden",
	      'Downloading tarballs is prohibited.')
	    unless $allow_tar;
	my ($module) = ($where =~ m,^/?(.*),);    # untaint
	$module =~ s,/([^/]*)$,,;
	my ($ext)     = ($1      =~ /(\.tar\.gz|\.zip)$/);
	my ($basedir) = ($module =~ m,([^/]+)$,);

	if ($basedir eq '' || $module eq '') {
		fatal("500 Internal Error",
		      'You cannot download the top level directory.');
	}

	my $tmpexportdir = "$tmpdir/.cvsweb.$$." . int(time);

	mkdir($tmpexportdir, 0700)
	    or fatal("500 Internal Error",
		     'Unable to make temporary directory: %s',
		     $!);

	my @fatal;

	my $tag =
	    (exists $input{only_with_tag} && length $input{only_with_tag}) ?
	    $input{only_with_tag} : "HEAD";

	if ($tag eq 'MAIN') {
	    $tag = 'HEAD';
	}

	if (system $CMD{cvs}, @cvs_options, '-Qd', $cvsroot, 'export', '-r',
	    $tag, '-d', "$tmpexportdir/$basedir", $module)
	{
		@fatal = ("500 Internal Error",
			  'cvs co failure: %s: %s',
			  $!, $module);
	} else {
		$| = 1;    # Essential to get the buffering right.

		if ($ext eq '.tar.gz') {
			print "Content-Type: application/x-gzip\r\n\r\n";

			system
			    "$CMD{tar} @tar_options -cf - -C $tmpexportdir $basedir | $CMD{gzip} @gzip_options -c"
			    and @fatal =
				("500 Internal Error",
				 'tar zc failure: %s: %s',
			     $!, $basedir);
		} elsif ($ext eq '.zip' && $CMD{zip}) {
			print "Content-Type: application/zip\r\n\r\n";

			system
			    "cd $tmpexportdir && $CMD{zip} @zip_options -r - $basedir"
			    and @fatal =
				("500 Internal Error",
				 'zip failure: %s: %s',
				 $!, $basedir);
		} else {
			@fatal =
			    ("500 Internal Error",
			     'unsupported file type');
		}
	}

	system $CMD{rm}, '-rf', $tmpexportdir if -d $tmpexportdir;

	&fatal(@fatal) if @fatal;

	exit;
}

##############################
# View a directory
###############################
if (-d $fullname) {
	my $dh = do { local (*DH); };
	opendir($dh, $fullname) or fatal("404 Not Found",
					 '%s: %s',
					 $where, $!);
	my @dir = readdir($dh);
	closedir($dh);
	my @subLevelFiles = findLastModifiedSubdirs(@dir)
	    if ($show_subdir_lastmod);
	getDirLogs($cvsroot, $where, @subLevelFiles);

	if ($where eq '/') {
		html_header($defaulttitle);
		$long_intro =~ s/!!CVSROOTdescr!!/$CVSROOTdescr{$cvstree}/g;
		print $long_intro;
	} else {
		html_header($where);
		print $short_instruction;
	}

	if ($use_descriptions && open(DESC, "<$cvsroot/CVSROOT/descriptions"))
	{
		while (<DESC>) {
			chomp;
			my ($dir, $description) = /(\S+)\s+(.*)/;
			$descriptions{$dir} = $description;
		}
		close(DESC);
	}

	print "<p><a name=\"dirlist\"></a></p>\n";

	# give direct access to dirs
	if ($where eq '/') {
		chooseMirror ();
		chooseCVSRoot ();
	} else {
		print "<p>Current directory: <b>", &clickablePath($where, 0),
		    "</b></p>\n";

		print "<p>Current tag: <b>", $input{only_with_tag},"</b></p>\n"
		    if $input{only_with_tag};

	}

	print "<hr noshade>\n";

	# Using <menu> in this manner violates the HTML2.0 spec but
	# provides the results that I want in most browsers.  Another
	# case of layout spooging up HTML.

	my $infocols = 0;
	if ($dirtable) {
		print "<table style=\"border-width: 0";
		print "; background-color: $tableBorderColor"
		    if (defined $tableBorderColor);
		print "\" width=\"100%\" cellspacing=\"1\" cellpadding=\"$tablepadding\">\n";
		$infocols++;
		printf "<tr>\n<th style=\"text-align: left; background-color: %s\">",
		    $byfile ? $columnHeaderColorSorted :
		    $columnHeaderColorDefault;

		if ($byfile) {
			print 'File';
		} else {
			print &link(
				'File',
				sprintf(
					'./%s#dirlist',
					&toggleQuery("sortby", "file")
				)
			);
		}
		print "</th>\n";

		# do not display the other column-headers, if we do not have any files
		# with revision information:
		if (scalar(%fileinfo)) {
			$infocols++;
			printf '<th style="text-align: left; background-color: %s">',
			    $byrev ? $columnHeaderColorSorted :
			    $columnHeaderColorDefault;

			if ($byrev) {
				print 'Rev.';
			} else {
				print &link(
					'Rev.',
					sprintf(
						'./%s#dirlist',
						&toggleQuery("sortby", "rev")
					)
				);
			}
			print "</th>\n";
			$infocols++;
			printf '<th style="text-align: left; background-color: %s">',
			    $bydate ? $columnHeaderColorSorted :
			    $columnHeaderColorDefault;

			if ($bydate) {
				print 'Age';
			} else {
				print &link(
					'Age',
					sprintf(
						'./%s#dirlist',
						&toggleQuery("sortby", "date")
					)
				);
			}
			print "</th>\n";

			if ($show_author) {
				$infocols++;
				printf '<th style="text-align: left; background-color: %s">',
				    $byauthor ? $columnHeaderColorSorted :
				    $columnHeaderColorDefault;

				if ($byauthor) {
					print 'Author';
				} else {
					print &link(
						'Author',
						sprintf(
							'./%s#dirlist',
							&toggleQuery(
								"sortby",
								"author"
							)
						)
					);
				}
				print "</th>\n";
			}
			$infocols++;
			printf '<th style="text-align: left; background-color: %s">',
			    $bylog ? $columnHeaderColorSorted :
			    $columnHeaderColorDefault;

			if ($bylog) {
				print 'Last log entry';
			} else {
				print &link(
					'Last log entry',
					sprintf(
						'./%s#dirlist',
						&toggleQuery("sortby", "log")
					)
				);
			}
			print "</th>\n";
		} elsif ($use_descriptions) {
			printf '<th style="text-align: left; background-color: s">',
			    $columnHeaderColorDefault;
			print "Description</th>\n";
			$infocols++;
		}
		print "</tr>\n";
	} else {
		print "<menu>\n";
	}
	my $dirrow = 0;

	my $i;
	lookingforattic:
	for ($i = 0 ; $i <= $#dir ; $i++) {
		if ($dir[$i] eq "Attic") {
			last lookingforattic;
		}
	}

	if (!$input{'hideattic'} && ($i <= $#dir)
	    && opendir($dh, $fullname . "/Attic"))
	{
		splice(@dir, $i, 1, grep((s|^|Attic/|, !m|/\.|), readdir($dh)));
		closedir($dh);
	}

	my $hideAtticToggleLink =
	    $input{'hideattic'} ? '' :
	    &link('[Hide]', sprintf('./%s#dirlist', &toggleQuery("hideattic")));

	# Sort without the Attic/ pathname.
	# place directories first

	my $attic;
	my $url;
	my $fileurl;
	my $filesexists;
	my $filesfound;

	foreach my $file (sort { &fileSortCmp } @dir) {

		next if ($file eq '.');

		# ignore CVS lock and stale NFS files
		next if ($file =~ /^#cvs\.|^,|^\.nfs/);

		# Check whether to show the CVSROOT path
		next if ($input{'hidecvsroot'} && $file eq 'CVSROOT');

		# Check whether the module is in the restricted list
		next if ($file && &forbidden_module($file));

		# Ignore non-readable files
		next if ($input{'hidenonreadable'} && !(-r "$fullname/$file"));

		if ($file =~ s|^Attic/||) {
			$attic = " (in the Attic)&nbsp;" . $hideAtticToggleLink;
		} else {
			$attic = "";
		}

		if ($file eq '..' || -d "$fullname/$file") {
			next if ($file eq '..' && $where eq '/');
			my ($rev, $date, $log, $author, $filename) =
			    @{$fileinfo{$file}}
			    if (defined($fileinfo{$file}));
			printf "<tr style=\"background-color: %s\">\n<td>",
			     $tabcolors[$dirrow % 2] if $dirtable;

			if ($file eq '..') {
				$url = "../$query";
				if ($nofilelinks) {
					print $backicon;
				} else {
					print &link($backicon, $url);
				}
				print '&nbsp;', &link("Parent Directory", $url);
			} else {
				$url = './' . urlencode($file) . "/$query";
				print "<a name=\"$file\"></a>";

				if ($nofilelinks) {
					print $diricon;
				} else {
					print &link($diricon, $url);
				}
				print '&nbsp;', &link("$file/", $url), $attic;

				if ($file eq "Attic") {
					print "&nbsp; ";
					print &link(
						"[Don't hide]",
						sprintf(
							'./%s#dirlist',
							&toggleQuery(
								"hideattic")
						)
					);
				}
			}

			# Show last change in dir
			if ($filename) {
				print "</td>\n<td>&nbsp;</td>\n<td>&nbsp;"
				    if ($dirtable);
				if ($date) {
					print " <i>",
					    readableTime(time() - $date, 0),
					    "</i>";
				}

				if ($show_author) {
					print "</td>\n<td>&nbsp;" if ($dirtable);
					print $author;
				}
				print "</td>\n<td>&nbsp;" if ($dirtable);
				$filename =~ s%^[^/]+/%%;
				print "$filename/$rev";
				print "<br>" if ($dirtable);

				if ($log) {
					print "&nbsp;<span style=\"font-size: smaller\">",
					  &htmlify(
						substr($log, 0, $shortLogLen), $allow_dir_extra);
					if (length $log > 80) {
						print "...";
					}
					print "</span>";
				}
			} else {
				my ($dwhere) =
				    ($where ne "/" ? $where : "") . $file;

				if ($use_descriptions
				    && defined $descriptions{$dwhere})
				{
					print "<td colspan=\"",($infocols - 1),
					    "\">&nbsp;"
					    if $dirtable;
					print $descriptions{$dwhere};
				} elsif ($dirtable && $infocols > 1) {

					# close the row with the appropriate number of
					# columns, so that the vertical seperators are visible
					my ($cols) = $infocols;
					while ($cols > 1) {
						print "</td>\n<td>&nbsp;";
						$cols--;
					}
				}
			}

			if ($dirtable) {
				print "</td>\n</tr>\n";
			} else {
				print "<br>\n";
			}
			$dirrow++;
		} elsif ($file =~ s/,v$//) {

			# Skip forbidden files now so we'll give no hint
			# about their existence.  This should probably have
			# been done earlier, but it's straightforward here.
			next if forbidden_file("$fullname/$file");

			$fileurl = ($attic ? "Attic/" : "") . urlencode($file);
			$url = './' . $fileurl . $query;
			$filesexists++;
			next if (!defined($fileinfo{$file}));
			my ($rev, $date, $log, $author) = @{$fileinfo{$file}};
			$filesfound++;
			printf "<tr style=\"background-color: %s\">\n<td>",
			    $tabcolors[$dirrow % 2] if $dirtable;
			print "<a name=\"$file\"></a>";

			if ($nofilelinks) {
				print $fileicon;
			} else {
				print &link($fileicon, $url);
			}
			print '&nbsp;', &link(htmlquote($file), $url), $attic;
			print "</td>\n<td>&nbsp;" if ($dirtable);
			download_link($fileurl, $rev, $rev,
				$defaultViewable ? "text/x-cvsweb-markup" :
				undef);
			print "</td>\n<td>&nbsp;" if ($dirtable);

			if ($date) {
				print " <i>", readableTime(time() - $date, 0),
				    "</i>";
			}
			if ($show_author) {
				print "</td>\n<td>&nbsp;" if ($dirtable);
				print $author;
			}
			print "</td>\n<td>&nbsp;" if ($dirtable);

			if ($log) {
				print " <span style=\"font-size: smaller\">",
				    &htmlify(substr($log, 0, $shortLogLen), $allow_dir_extra);
				if (length $log > 80) {
					print "...";
				}
				print "</span>";
			}
			print "</td>\n" if ($dirtable);
			print(($dirtable) ? "</tr>" : "<br>");
			$dirrow++;
		}
		print "\n";
	}

	print($dirtable ? "</table>\n" : "</menu>\n");

	if ($filesexists && !$filesfound) {
		print
		    "<p><b>NOTE:</b> There are $filesexists files, but none matches the current tag ($input{only_with_tag}).</p>\n";
	}
	if ($input{only_with_tag} && (!%tags || !$tags{$input{only_with_tag}}))
	{
		%tags = %alltags
	}

	if (scalar %tags || $input{only_with_tag} || $edit_option_form
	    || defined($input{"options"}))
	{
		print "<hr size=\"1\" noshade>\n";
	}

	if (scalar %tags || $input{only_with_tag}) {
		print "<form method=\"get\" action=\"./\">\n";
		foreach my $var (@stickyvars) {
			print
			    "<input type=\"hidden\" name=\"$var\" value=\"$input{$var}\">\n"
			    if (defined($input{$var})
			    && (!defined($DEFAULTVALUE{$var})
			    || $input{$var} ne $DEFAULTVALUE{$var})
			    && $input{$var} ne "" && $var ne "only_with_tag");
		}
		print "<p><label for=\"only_with_tag\" accesskey=\"T\">";
		print "Show only files with tag:</label>\n";
		print "<select id=\"only_with_tag\" name=\"only_with_tag\"";
		print " onchange=\"this.form.submit()\"" if $use_java_script;
		print ">";
		print "<option value=\"\">All tags / default branch</option>\n";

		foreach my $tag (reverse sort { lc $a cmp lc $b } keys %tags) {
			print "<option",
			    defined($input{only_with_tag})
			    && $input{only_with_tag} eq $tag ? " selected" : "",
			    ">$tag</option>\n";
		}
		print "</select>\n";
		print " <label for=\"path\" accesskey=\"P\">";
		print "Module path or alias:</label>\n";
		printf "<input type=\"text\" id=\"path\" name=\"path\" value=\"%s\" size=\"15\">\n",
		    htmlquote($where);
		print "<input type=\"submit\" value=\"Go\" accesskey=\"G\"></p>\n";
		print "</form>\n";
	}

	if ($allow_tar) {
		my ($basefile) = ($where =~ m,(?:.*/)?([^/]+),);

		if (defined($basefile) && $basefile ne '') {
			print "<hr noshade>\n",
			    "<div align=\"center\">Download this directory in ";

			# Mangle the filename so browsers show a reasonable
			# filename to download.
			print &link("tarball", "./$basefile.tar.gz$query"
				. ($query ? "&" : "?") . "tarball=1");
			if ($CMD{zip}) {
				print " or ",
				    &link("zip archive", "./$basefile.zip$query"
					. ($query ? "&" : "?") . "tarball=1");
			}
			print "</div>\n";
		}
	}

	if ($edit_option_form || defined($input{"options"})) {

		my $formwhere = $scriptwhere;
		$formwhere =~ s|Attic/?$|| if ($input{'hideattic'});

		print "<form method=\"get\" action=\"${formwhere}\">\n";
		print "<input type=\"hidden\" name=\"copt\" value=\"1\">\n";
		if ($cvstree ne $cvstreedefault) {
			print
			    "<input type=\"hidden\" name=\"cvsroot\" value=\"$cvstree\">\n";
		}
		print "<center>\n<table cellpadding=\"0\" cellspacing=\"0\">";
		print "\n<tr style=\"background-color: $columnHeaderColorDefault\">\n";
		print "<th colspan=\"2\">Preferences</th>\n</tr>\n";
		print "<tr>\n<td>";
		print "<label for=\"sortby\" accesskey=\"F\">Sort files by ";
		print "</label><select id=\"sortby\" name=\"sortby\">\n";
		print "<option value=\"\">File</option>\n";
		print "<option", $bydate ? " selected" : "",
		    " value=\"date\">Age</option>\n";
		print "<option", $byauthor ? " selected" : "",
		    " value=\"author\">Author</option>\n"
		    if ($show_author);
		print "<option", $byrev ? " selected" : "",
		    " value=\"rev\">Revision</option>\n";
		print "<option", $bylog ? " selected" : "",
		    " value=\"log\">Log message</option>\n";
		print "</select>\n</td>\n";
		print "<td><label for=\"logsort\" accesskey=\"L\">";
		print "Sort log by: </label>";
		printLogSortSelect(0);
		print "</td>\n</tr>\n";
		print "<tr>\n<td><label for=\"f\" accesskey=\"D\">";
		print "Diff format: </label>";
		printDiffSelect(0);
		print "</td>\n";
		print "<td><label for=\"hideattic\" accesskey=\"A\">";
		print "Show Attic files: </label>";
		print "<input id=\"hideattic\" name=\"hideattic\" type=\"checkbox\"",
		    $input{'hideattic'} ? " checked" : "",
		     "></td>\n</tr>\n";
		print "<tr>\n<td align=\"center\" colspan=\"2\">";
		print "<input type=\"submit\" value=\"Change Options\" accesskey=\"C\">";
		print "</td>\n</tr>\n</table>\n</center>\n</form>\n";
	}
	html_footer();
}

###############################
# View Files
###############################
elsif (-f $fullname . ',v') {

	if (forbidden_file($fullname)) {
		fatal('403 Forbidden',
		      'Access forbidden.  This file is mentioned in @ForbiddenFiles');
		return;
	}

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
		&doDiff(
			$fullname,     $input{'r1'},
			$input{'tr1'}, $input{'r2'},
			$input{'tr2'}, $input{'f'}
		);
		gzipclose();
		exit;
	}
	print("going to dolog($fullname)\n") if ($verbose);
	&doLog($fullname);

	##############################
	# View Diff
	##############################
} elsif ($fullname =~ s/\.diff$// && -f $fullname . ",v" && $input{'r1'}
    && $input{'r2'})
{

	# $where-diff-removal if 'cvs rdiff' is used
	# .. but 'cvs rdiff'doesn't support some options
	# rcsdiff does (-w and -p), so it is disabled
	# $where =~ s/\.diff$//;

	# Allow diffs using the ".diff" extension
	# so that browsers that default to the URL
	# for a save filename don't save diff's as
	# e.g. foo.c
	&doDiff(
		$fullname,     $input{'r1'}, $input{'tr1'}, $input{'r2'},
		$input{'tr2'}, $input{'f'}
	);
	gzipclose();
	exit;
} elsif (($newname = $fullname) =~ s|/([^/]+)$|/Attic/$1| && -f $newname . ",v")
{

	# The file has been removed and is in the Attic.
	# Send a redirect pointing to the file in the Attic.
	(my $newplace = $scriptwhere) =~ s|/([^/]+)$|/Attic/$1|;
	if ($ENV{QUERY_STRING} ne "") {
		redirect("${newplace}?$ENV{QUERY_STRING}");
	} else {
		redirect($newplace);
	}
	exit;
} elsif (0 && (my @files = &safeglob($fullname . ",v"))) {
	http_header("text/plain");
	print "You matched the following files:\n";
	print join ("\n", @files);

	# Find the tags from each file
	# Display a form offering diffs between said tags
} else {
	my $fh = do { local (*FH); };
	my ($xtra, $module);

	# Assume it's a module name with a potential path following it.
	$xtra = (($module = $where) =~ s|/.*||) ? $& : '';

	# Is there an indexed version of modules?
	if (open($fh, "< $cvsroot/CVSROOT/modules")) {
		while (<$fh>) {
			if (/^(\S+)\s+(\S+)/o && $module eq $1
			    && -d "$cvsroot/$2" && $module ne $2)
			{
				redirect("$scriptname/$2$xtra$query");
			}
		}
	}
	fatal("404 Not Found",
	      '%s: no such file or directory',
	      $where);
}

gzipclose();

## End MAIN

sub printDiffSelect($) {
	my ($use_java_script) = @_;
	my $f = $input{'f'};

	print '<select id="f" name="f"';
	print ' onchange="this.form.submit()"' if $use_java_script;
	print ">\n";

	local $_;
	for (@DIFFTYPES) {
		printf("<option value=\"%s\"%s>%s</option>\n", $_,
		    $f eq $_ ? ' selected' : '', "\u$DIFFTYPES{$_}{'descr'}");
	}

	print "</select>";
}

sub printLogSortSelect($) {
	my ($use_java_script) = @_;

	print '<select id="logsort" name="logsort"';
	print ' onchange="this.form.submit()"' if $use_java_script;
	print ">\n";

	local $_;
	for (@LOGSORTKEYS) {
		printf("<option value=\"%s\"%s>%s</option>\n", $_,
		    $logsort eq $_ ? ' selected' : '',
		    "\u$LOGSORTKEYS{$_}{'descr'}");
	}

	print "</select>";
}

sub findLastModifiedSubdirs(@) {
	my (@dirs) = @_;
	my ($dirname, @files);

	foreach $dirname (@dirs) {
		next if ($dirname eq ".");
		next if ($dirname eq "..");
		my ($dir) = "$fullname/$dirname";
		next if (!-d $dir);

		my ($lastmod)     = undef;
		my ($lastmodtime) = undef;
		my $dh = do { local (*DH); };

		opendir($dh, $dir) or next;
		my (@filenames) = readdir($dh);
		closedir($dh);

		foreach my $filename (@filenames) {
			$filename = "$dirname/$filename";
			my ($file) = "$fullname/$filename";
			next if ($filename !~ /,v$/ || !-f $file);

			# Skip forbidden files.
			(my $f = $file) =~ s/,v$//;
			next if forbidden_file($f);

			$filename =~ s/,v$//;
			my $modtime = -M $file;

			if (!defined($lastmod) || $modtime < $lastmodtime) {
				$lastmod     = $filename;
				$lastmodtime = $modtime;
			}
		}
		push (@files, $lastmod) if (defined($lastmod));
	}
	return @files;
}

sub htmlify_sub(&$) {
	(my $proc, local $_) = @_;
	my @a = split (m`(<a [^>]+>[^<]*</a>)`i);
	my $linked;
	my $result = '';

	while (($_, $linked) = splice(@a, 0, 2)) {
		&$proc();
		$result .= $_      if defined($_);
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
	    }
	    $_;

	if ($extra) {

		# get PR #'s as link: "PR#nnnn" "PR: nnnn, ..." "PR nnnn, ..." "bin/nnnn"
		if (defined($prcgi) && defined($re_prkeyword))
		{
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
				    }
				    $_;
			} while ($_ ne $prev);

			if (defined($re_prcategories)) {
				$_ = htmlify_sub {
					s{
			  (\b$re_prcategories/(\d+)\b)
			}{
				&link($1, sprintf($prcgi, $2))
			}egox;
				    }
				    $_;
			}
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
			    }
			    $_;
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
		s/  / \001nbsp;/g;    # 2 * <space>
		                      # leave single space as it is
	} else {
		s/ /\001nbsp;/g;
	}

	$_ = htmlify($_, $allow_source_extra);

	# unescape
	y/\001/&/;

	return $_;
}

# Note that this doesn't htmlquote the first argument...
sub link($$) {
	my ($name, $url) = @_;

	$url =~ s/:/sprintf("%%%02x", ord($&))/eg
	    if $url =~ /^[^a-z]/;    # relative

	sprintf '<a href="%s">%s</a>', hrefquote($url), $name;
}

sub revcmp($$) {
	my ($rev1, $rev2) = @_;

	# make no comparison for a tag or a branch
	return 0 if $rev1 =~ /[^\d.]/ || $rev2 =~ /[^\d.]/;

	my (@r1) = split (/\./, $rev1);
	my (@r2) = split (/\./, $rev2);
	my ($a, $b);

	while (($a = shift (@r1)) && ($b = shift (@r2))) {
		if ($a != $b) {
			return $a <=> $b;
		}
	}
	if (@r1) { return 1; }
	if (@r2) { return -1; }
	return 0;
}

sub fatal($$@) {
	my ($errcode, $format, @args) = @_;
	if ($is_mod_perl) {
		Apache->request->status((split (/ /, $errcode))[0]);
	} else {
		print "Status: $errcode\r\n";
	}
	html_header("Error");
	print "<p>Error: ",
	  sprintf($format, map(htmlquote($_), @args)),
	  "</p>\n";
	html_footer();
	exit(1);
}

sub redirect($) {
	my ($url) = @_;
	if ($is_mod_perl) {
		Apache->request->status(301);
		Apache->request->header_out(Location => $url);
	} else {
		print "Status: 301 Moved\r\n";
		print "Location: $url\r\n";
	}
	html_header("Moved");
	print "<p>This document is located ", &link('here', $url), "</p>\n";
	html_footer();
	exit(1);
}

sub safeglob($) {
	my ($filename) = @_;
	my ($dirname);
	my (@results);
	my $dh = do { local (*DH); };

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
				push (@results, "$dirname/" . $_);
			}
		}
		closedir($dh);
	}

	@results;
}

sub search_path($) {
	my ($command) = @_;
	my $d;

	for $d (split (/:/, $command_path)) {
		return "$d/$command" if -x "$d/$command";
	}

	'';
}

sub getMimeTypeFromSuffix($) {
	my ($fullname) = @_;
	my ($mimetype, $suffix);
	my $fh = do { local (*FH); };

	($suffix = $fullname) =~ s/^.*\.([^.]*)$/$1/;
	$mimetype = $MTYPES{$suffix};
	$mimetype = $MTYPES{'*'} if (!$mimetype);

	if (!$mimetype && -f $mime_types) {

		# okey, this is something special - search the
		# mime.types database
		open($fh, "<$mime_types");
		while (<$fh>) {
			if ($_ =~ /^\s*(\S+\/\S+).*\b$suffix\b/) {
				$mimetype = $1;
				last;
			}
		}
		close($fh);
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
	my $fh        = $_[0];
	my $linecount = $_[1] || 10;

	my @buf;

	if ($linecount > 0) {
		my $i;
		for ($i = 0 ; !eof($fh) && $i < $linecount ; $i++) {
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

sub openOutputFilter() {
	return if !defined($output_filter) || $output_filter eq '';

	open(STDOUT, "|-") and return;

	# child of child
	open(STDERR, '>/dev/null');
	exec($output_filter) or exit -1;
}

###############################
# show Annotation
###############################
sub doAnnotate($$) {
	my ($rev) = @_;
	my ($pid);
	my ($pathname, $filename);
	my $reader = do { local (*FH); };
	my $writer = do { local (*FH); };

	# make sure the revisions are wellformed, for security
	# reasons ..
	if ($rev =~ /[^\w.]/) {
		fatal("404 Not Found",
		      'Malformed query "%s"',
		      $ENV{QUERY_STRING});
	}

	($pathname = $where) =~ s/(Attic\/)?[^\/]*$//;
	($filename = $where) =~ s/^.*\///;

	# this seems to be necessary
	$| = 1;
	$| = 0;    # Flush

	# Work around a mod_perl bug (?) in order to make open2() work.
	# Search for "untie STDIN" in mod_perl mailing list archives.
	my $old_stdin;
	if ($is_mod_perl && ($old_stdin = tied *STDIN)) {
	  local $^W = undef;
	  untie *STDIN;
	}

	# this annotate version is based on the
	# cvs annotate-demo Perl script by Cyclic Software
	# It was written by Cyclic Software, http://www.cyclic.com/, and is in
	# the public domain.
	# we could abandon the use of rlog, rcsdiff and co using
	# the cvsserver in a similiar way one day (..after rewrite)
	$pid = open2($reader, $writer, $CMD{cvs}, @annotate_options, 'server')
	    or fatal("500 Internal Error",
		     'Fatal Error - unable to open cvs for annotation');

	# Re-tie STDIN if we fiddled around with it earlier, just to be sure.
	tie(*STDIN, ref($old_stdin), $old_stdin) if ($old_stdin && !tied(*STDIN));

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
	print $writer
	    "Valid-responses ok error Valid-requests Checked-in Updated Merged Removed M E\n";

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
	my @dirs = split ('/', $where);
	my $path = "";
	foreach (@dirs) {

		if ($path eq "") {

			# In our example, $_ is "dir".
			$path = $_;
		} else {
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
	close($writer) or die "cannot close: $!";

	http_header();

	navigateHeader($scriptwhere, $pathname, $filename, $rev, "annotate");
	print
	    "<h3 style=\"text-align: center\">Annotation of $pathname$filename, Revision $rev</h3>\n";

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
		print "<table style=\"border: none\" cellspacing=\"0\" cellpadding=\"0\">\n";
	} else {
		print "<pre>";
	}

	# prefetch several lines
	my @buf = head($reader);

	my %d = scan_directives(@buf);

	while (@buf || !eof($reader)) {
		$_ = @buf ? shift @buf : <$reader>;

		my @words = split;

		# Adding one is for the (single) space which follows $words[0].
		my $rest = substr($_, length($words[0]) + 1);
		if ($words[0] eq "E") {
			next;
		} elsif ($words[0] eq "M") {
			$lineNr++;
			(my $lrev = substr($_, 2,  13)) =~ y/ //d;
			(my $lusr = substr($_, 16, 9))  =~ y/ //d;
			my $line = substr($_, 36);
			my $isCurrentRev = ($rev eq $lrev);

			# we should parse the date here ..
			if ($lrev eq $oldLrev) {
				$revprint = sprintf('%-8s', '');
			} else {
				$revprint = sprintf('%-8s', $lrev);
				$revprint =~
				    s`\S+`&link($&, "$scriptwhere$query#rev$&")`e
				    ;    # `
				$oldLusr = '';
			}

			if ($lusr eq $oldLusr) {
				$usrprint = '';
			} else {
				$usrprint = $lusr;
			}
			$oldLrev = $lrev;
			$oldLusr = $lusr;

			# Set bold for text-based browsers only - graphical
			# browsers show bold fonts a bit wider than regular fonts,
			# so it looks irregular.
			print "<b>" if ($isCurrentRev && $is_textbased);

			printf "%s%s %-8s %4d:", $revprint,
			    $isCurrentRev ? '!' : ' ', $usrprint, $lineNr;
			print spacedHtmlText($line, $d{'tabstop'});

			print "</b>" if ($isCurrentRev && $is_textbased);
		} elsif ($words[0] eq "ok") {

			# We could complain about any text received after this, like the
			# CVS command line client.  But for simplicity, we don't.
		} elsif ($words[0] eq "error") {
			fatal("500 Internal Error",
			      'Error occured during annotate: <b>%s</b>',
			      $_);
		}
	}

	if ($annTable) {
		print "</table>";
	} else {
		print "</pre>";
	}
	html_footer();

	close($reader) or warn "cannot close: $!";
	wait;
}

###############################
# make Checkout
###############################
sub doCheckout($$) {
	my ($fullname, $rev) = @_;
	my ($mimetype, $revopt);
	my $fh = do { local (*FH); };

	if ($rev eq 'HEAD' || $rev eq '.') {
		$rev = undef;
	}

	# make sure the revisions a wellformed, for security
	# reasons ..
	if (defined($rev) && $rev =~ /[^\w.]/) {
		fatal("404 Not Found",
		      'Malformed query "%s"',
		      $ENV{QUERY_STRING});
	}

	# get mimetype
	if (defined($input{"content-type"})
	    && ($input{"content-type"} =~ /\S\/\S/))
	{
		$mimetype = $input{"content-type"}
	} else {
		$mimetype = &getMimeTypeFromSuffix($fullname);
	}

	if (defined($rev)) {
		$revopt = "-r$rev";
		if ($use_moddate) {
			readLog($fullname, $rev);
			$moddate = $date{$rev};
		}
	} else {
		$revopt = "-rHEAD";

		if ($use_moddate) {
			readLog($fullname);
			$moddate = $date{$symrev{HEAD}};
		}
	}

	### just for the record:
	### 'cvs co' seems to have a bug regarding single checkout of
	### directories/files having spaces in it;
	### this is an issue that should be resolved on cvs's side
	#
	# Safely for a child process to read from.
	if (!open($fh, "-|")) {    # child
		 # chdir to $tmpdir before to avoid non-readable cgi-bin directories
		chdir($tmpdir);
		open(STDERR, ">&STDOUT");    # Redirect stderr to stdout

		# work around a bug of cvs -p; expand symlinks
		use Cwd 'abs_path';
		exec($CMD{cvs}, @cvs_options,
		     '-d', abs_path($cvsroot),
		     'co', '-p',
		     $revopt, $where) or exit -1;
	}

	if (eof($fh)) {
		fatal("404 Not Found",
		      '%s is not (any longer) pertinent',
		      $where);
	}

	#===================================================================
	#Checking out squid/src/ftp.c
	#RCS:  /usr/src/CVS/squid/src/ftp.c,v
	#VERS: 1.1.1.28.6.2
	#***************

	# Parse CVS header
	my ($revision, $filename, $cvsheader);
	$filename = "";
	while (<$fh>) {
		last if (/^\*\*\*\*/);
		$revision = $1 if (/^VERS: (.*)$/);

		if (/^Checking out (.*)$/) {
			$filename = $1;
			$filename =~ s/^\.\/*//;
		}
		$cvsheader .= $_;
	}

	if ($filename ne $where) {
		fatal("500 Internal Error",
		      'Unexpected output from cvs co: %s',
		      $cvsheader);
	}
	$| = 1;

	if ($mimetype eq "text/x-cvsweb-markup") {
		&cvswebMarkup($fh, $fullname, $revision);
	} else {
		http_header($mimetype);
		print <$fh>;
	}
	close($fh);
}

sub cvswebMarkup($$$) {
	my ($filehandle, $fullname, $revision) = @_;
	my ($pathname,   $filename);

	($pathname = $where) =~ s/(Attic\/)?[^\/]*$//;
	($filename = $where) =~ s/^.*\///;
	my ($fileurl) = urlencode($filename);

	http_header();

	navigateHeader($scriptwhere, $pathname, $filename, $revision, "view");
	print "<hr noshade>";
	print "<table width=\"100%\">\n<tr>\n<td style=\"background-color: $markupLogColor\">";
	print "File: ", &clickablePath($where, 1);
	print "&nbsp;(";
	&download_link($fileurl, $revision, "download");
	print ")";

	if (!$defaultTextPlain) {
		print "&nbsp;(";
		&download_link($fileurl, $revision, "as text", "text/plain");
		print ")";
	}
	print "<br>\n";

	if ($show_log_in_markup) {
		readLog($fullname);    #,$revision);
		printLog($revision, 0);
	} else {
		print "Version: <b>$revision</b><br>\n";
		print "Tag: <b>", $input{only_with_tag}, "</b><br>\n"
		    if $input{only_with_tag};
	}
	print "</td>\n</tr>\n</table>";
	my $url = download_url($fileurl, $revision, $mimetype);
	print "<hr noshade>";

	if ($mimetype =~ /^image/) {
		printf '<img src="%s" alt=""><br>', hrefquote("$url$barequery");
	} elsif ($mimetype =~ m%^application/pdf%) {
		printf '<embed src="%s" width="100%"><br>',
		    hrefquote("$url$barequery");
	} elsif ($preformat_in_markup) {
		print "<pre>";

		# prefetch several lines
		my @buf = head($filehandle);

		my %d = scan_directives(@buf);

		while (@buf || !eof($filehandle)) {
			$_ = @buf ? shift @buf : <$filehandle>;

			print spacedHtmlText($_, $d{'tabstop'});
		}
		print "</pre>";
	} else {
		print "<pre>";

		while (<$filehandle>) {
			print htmlquote($_);
		}
		print "</pre>";
	}
}

sub viewable($) {
	my ($mimetype) = @_;

	$mimetype =~ m%^((text|image)/|application/pdf)%;
}

###############################
# Show Colored Diff
###############################
sub doDiff($$$$$$) {
	my ($fullname, $r1, $tr1, $r2, $tr2, $f) = @_;
	my $fh = do { local (*FH); };
	my ($rev1, $rev2, $sym1, $sym2, $f1, $f2);

	if (&forbidden_file($fullname)) {
		fatal("403 Forbidden",
		      'Access forbidden.  This file is mentioned in @ForbiddenFiles');
		return;
	}

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
		fatal("404 Not Found",
		      'Malformed query "%s"',
		      $ENV{QUERY_STRING});
	}

	#
	# rev1 and rev2 are now both numeric revisions.
	# Thus we do a DWIM here and swap them if rev1 is after rev2.
	# XXX should we warn about the fact that we do this?
	if (&revcmp($rev1, $rev2) > 0) {
		my ($tmp1, $tmp2) = ($rev1, $sym1);
		($rev1, $sym1) = ($rev2, $sym2);
		($rev2, $sym2) = ($tmp1, $tmp2);
	}
	my $difftype = $DIFFTYPES{$f};

	if (!$difftype) {
		fatal("400 Bad arguments",
		      'Diff format %s not understood',
		      $f);
	}

	my @difftype       = @{$difftype->{'opts'}};
	my $human_readable = $difftype->{'colored'};

	# apply special options
	if ($showfunc) {
		push @difftype, '-p' if $f ne 's';

		my ($re1, $re2);

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

	if (!open($fh, "-|")) {    # child
		open(STDERR, ">&STDOUT");    # Redirect stderr to stdout
		openOutputFilter();
		exec($CMD{rcsdiff}, @difftype, "-r$rev1", "-r$rev2", $fullname) or exit -1;
	}
	if ($human_readable) {
		http_header();
		&human_readable_diff($fh, $rev2);
		html_footer();
		gzipclose();
		exit;
	} else {
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
	if (grep { $_ eq '-u' } @difftype) {
		$f1 = '---';
		$f2 = '\+\+\+';
	} else {
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
		} elsif (m|^$f2 $cvsroot|o) {
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
	my ($cvsroot, $dirname, @otherFiles) = @_;
	my ($state, $otherFiles, $tag, $file, $date, $branchpoint, $branch,
	    $log);
	my ($rev, $revision, $revwanted, $filename, $head, $author);

	$tag = $input{only_with_tag};

	my ($DirName) = "$cvsroot/$where";
	my (@files, @filetags);
	my $fh = do { local (*FH); };

	push (@files, &safeglob("$DirName/*,v"));
	push (@files, &safeglob("$DirName/Attic/*,v"))
	    if (!$input{'hideattic'});
	foreach my $file (@otherFiles) {
		push (@files, "$DirName/$file");
	}

	# just execute rlog if there are any files
	if ($#files < 0) {
		return;
	}

	if (defined($tag)) {

		#can't use -r<tag> as - is allowed in tagnames, but misinterpreated by rlog..
		if (!open($fh, "-|")) {    # child
			open(STDERR, '>/dev/null'); # rlog may complain; ignore.
			openOutputFilter();
			exec($CMD{rlog}, @files) or exit -1;
		}
	} else {

		if (!open($fh, "-|")) {    # child
			open(STDERR, '>/dev/null'); # rlog may complain; ignore.
			openOutputFilter();
			exec($CMD{rlog}, '-r', @files) or exit -1;
		}
	}
	$state = "start";

	while (<$fh>) {
		if ($state eq "start") {

			#Next file. Initialize file variables
			$rev         = '';
			$revwanted   = '';
			$branch      = '';
			$branchpoint = '';
			$filename    = '';
			$log         = '';
			$revision    = '';
			%symrev      = ();
			@filetags    = ();

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
				($branch = $head) =~ s/\.\d+$//
				    if $branch eq '';
				$branch =~ s/(\d+)$/0.$1/;
				$symrev{MAIN}  = $branch;
				$symrev{HEAD}  = $branch;
				$alltags{MAIN} = 1;
				$alltags{HEAD} = 1;
				push (@filetags, "MAIN", "HEAD");
			} elsif (/$LOG_REVSEPARATOR/o) {
				$state = "log";
				$rev   = '';
				$date  = '';
				$log   = '';

				# Try to reconstruct the relative filename if RCS spits out a full path
				$filename =~ s%^\Q$DirName\E/%%;
			}
			next;
		}

		if ($state eq "tags") {
			if (/^\s+([^:]+):\s+([\d\.]+)\s*$/) {
				push (@filetags, $1);
				$symrev{$1}  = $2;
				$alltags{$1} = 1;
				next;
			} elsif (/^\S/) {

				if (defined($tag)) {
					if (defined($symrev{$tag})
					    || $tag eq "HEAD")
					{
						$revwanted =
						    $symrev{$tag eq "HEAD" ?
						    "MAIN" : $tag};
						($branch = $revwanted) =~
						    s/\b0\.//;
						($branchpoint = $branch) =~
						    s/\.?\d+$//;
						$revwanted = ''
						    if ($revwanted ne $branch);
					} elsif ($tag ne "HEAD") {
						print
						    "Tag not found, skip this file"
						    if ($verbose);
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
				    "Branchpoint: $branchpoint\n"
				    if ($verbose);

				if ($revwanted eq '' && $branch ne ''
				    && $branch eq $revbranch || !defined($tag))
				{
					print
					    "File revision $rev found for branch $branch\n"
					    if ($verbose);
					$revwanted = $rev;
				}

				if ($revwanted ne '' ? $rev eq $revwanted :
				    $branchpoint ne '' ? $rev eq $branchpoint :
				    0 && ($rev eq $head))
				{    # Don't think head is needed here..
					print
					    "File info $rev found for $filename\n"
					    if ($verbose);
					my @finfo =
					    ($rev, $date, $log, $author,
						$filename);
					my ($name);
					($name = $filename) =~ s%/.*%%;
					$fileinfo{$name} = [@finfo];
					$state = "done" if ($rev eq $revwanted);
				}
				$rev  = '';
				$date = '';
				$log  = '';
			} elsif ($date eq ''
			    && m|^date:\s+(\d+)/(\d+)/(\d+)\s+(\d+):(\d+):(\d+);|
			    )
			{
				my $yr = $1;

				# damn 2-digit year routines :-)
				if ($yr > 100) {
					$yr -= 1900;
				}
				$date =
				    &Time::Local::timegm($6, $5, $4, $3, $2 - 1,
					$yr);
				($author) = /author: ([^;]+)/;
				$state = "log";
				$log   = '';
				next;
			} elsif ($rev eq '' && /^revision (\d+(?:\.\d+)+).*$/) {
				$rev = $1; # .*$ eats up the locker(lockers?) info, if any
				next;
			} else {
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
		      'Failed to spawn GNU rlog on <em>"%s"</em>.  <p>Did you set the <b>$command_path</b> in your configuration file correctly ? (Currently "%s"',
		      join (", ", @files), $command_path);
	}
	close($fh);
}

sub readLog($;$) {
	my ($fullname, $revision) = @_;
	my ($symnames, $head, $rev, $br, $brp, $branch, $branchrev);
	my $fh = do { local (*FH); };

	if (defined($revision)) {
		$revision = "-r$revision";
	} else {
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
	if (!open($fh, "-|")) {    # child
		if ($revision ne '') {
			openOutputFilter();
			exec($CMD{rlog}, $revision, $fullname) or exit -1;
		} else {
			openOutputFilter();
			exec($CMD{rlog}, $fullname) or exit -1;
		}
	}

	while (<$fh>) {
		print if ($verbose);
		if ($symnames) {
			if (/^\s+([^:]+):\s+([\d\.]+)/) {
				$symrev{$1} = $2;
			} else {
				$symnames = 0;
			}
		} elsif (/^head:\s+([\d\.]+)/) {
			$head = $1;
		} elsif (/^branch:\s+([\d\.]+)/) {
			$curbranch = $1;
		} elsif (/^symbolic names/) {
			$symnames = 1;
		} elsif (/^-----/) {
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

	# For a locked revision, the first line after the separator 
	# becomes smth like
	# revision 9.19	locked by: vassilii;

	logentry:

	while (!/$LOG_FILESEPARATOR/o) {
		$_ = <$fh>;
		last logentry if (!defined($_));    # EOF
		print "R:", $_ if ($verbose);
		if (/^revision (\d+(?:\.\d+)+)/) {
			$rev = $1;
			unshift (@allrevisions, $rev);
		} elsif (/$LOG_FILESEPARATOR/o || /$LOG_REVSEPARATOR/o) {
			next logentry;
		} else {

			# The rlog output is syntactically ambiguous.  We must
			# have guessed wrong about where the end of the last log
			# message was.
			# Since this is likely to happen when people put rlog output
			# in their commit messages, don't even bother keeping
			# these lines since we don't know what revision they go with
			# any more.
			next logentry;
		}
		$_ = <$fh>;
		print "D:", $_ if ($verbose);
		if (
		    m|^date:\s+(\d+)/(\d+)/(\d+)\s+(\d+):(\d+):(\d+);\s+author:\s+(\S+);\s+state:\s+(\S+);\s+(lines:\s+([0-9\s+-]+))?|
		    )
		{
			my $yr = $1;

			# damn 2-digit year routines :-)
			if ($yr > 100) {
				$yr -= 1900;
			}
			$date{$rev} =
			    &Time::Local::timegm($6, $5, $4, $3, $2 - 1, $yr);
			$author{$rev}    = $7;
			$state{$rev}     = $8;
			$difflines{$rev} = $10;
		} else {
			fatal("500 Internal Error",
			      'Error parsing RCS output: %s',
			      $_);
		}
		line:

		while (<$fh>) {
			print "L:", $_ if ($verbose);
			next line if (/^branches:\s/);
			last line
			    if (/$LOG_FILESEPARATOR/o || /$LOG_REVSEPARATOR/o);
			$log{$rev} .= $_;
		}
		print "E:", $_ if ($verbose);
	}
	close($fh);
	print "Done reading RCS file\n" if ($verbose);

	@revorder = reverse sort { revcmp($a, $b) } @allrevisions;
	print "Done sorting revisions", join (" ", @revorder), "\n"
	    if ($verbose);

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
			push (@branchnames, $_);

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
			$rev   = $head;

			foreach my $r (@revorder) {
				if ($r =~ /^${regex}\b/) {
					$rev = $branchrev;
					last;
				}
			}
			next if ($rev eq "");

			if ($rev ne $head && $head ne "") {
				$branchpoint{$head} .= ", "
				    if ($branchpoint{$head});
				$branchpoint{$head} .= $_;
			}
		}
		$revsym{$rev} .= ", " if ($revsym{$rev});
		$revsym{$rev} .= $_;
		$sel .= "<option value=\"${rev}:${_}\">$_</option>\n";
	}
	print "Done associating revisions with branches\n" if ($verbose);

	my ($onlyonbranch, $onlybranchpoint);
	if ($onlyonbranch = $input{'only_with_tag'}) {
		$onlyonbranch = $symrev{$onlyonbranch};
		if ($onlyonbranch =~ s/\b0\.//) {
			($onlybranchpoint = $onlyonbranch) =~ s/\.\d+$//;
		} else {
			$onlybranchpoint = $onlyonbranch;
		}

		if (!defined($onlyonbranch) || $onlybranchpoint eq "") {
			fatal("404 Tag not found",
			      'Tag %s not defined',
			      $input{'only_with_tag'});
		}
	}

	undef @revisions;

	foreach (@allrevisions) {
		($br  = $_)  =~ s/\.\d+$//;
		($brp = $br) =~ s/\.\d+$//;
		next
		    if ($onlyonbranch && $br ne $onlyonbranch
		    && $_ ne $onlybranchpoint);
		unshift (@revisions, $_);
	}

	if ($logsort eq "date") {

		# Sort the revisions in commit order an secondary sort on revision
		# (secondary sort needed for imported sources, or the first main
		# revision gets before the same revision on the 1.1.1 branch)
		@revdisplayorder =
		    sort { $date{$b} <=> $date{$a} || -revcmp($a, $b) }
		    @revisions;
	} elsif ($logsort eq "rev") {

		# Sort the revisions in revision order, highest first
		@revdisplayorder = reverse sort { revcmp($a, $b) } @revisions;
	} else {

		# No sorting. Present in the same order as rlog / cvs log
		@revdisplayorder = @revisions;
	}

}

sub printDiffLinks($$) {
	my ($text, $url) = @_;
	my @extra;

	local $_;
	for ($DIFFTYPES{$defaultDiffType}{'colored'} ? qw(u) : qw(h)) {
		my $f = $_ eq $defaultDiffType ? '' : $_;

		push @extra, &link(lc $DIFFTYPES{$_}{'descr'}, "$url&f=$f");
	}

	print &link($text, $url), ' (', join (', ', @extra), ')';
}

sub printLog($;$) {
	my ($link, $br, $brp);
	($_, $link) = @_;
	($br  = $_)  =~ s/\.\d+$//;
	($brp = $br) =~ s/\.?\d+$//;
	my ($isDead, $prev);

	$link = 1 if (!defined($link));
	$isDead = ($state{$_} eq "dead");

	print "<p>\n";
	if ($link && !$isDead) {
		my ($filename);
		($filename = $where) =~ s/^.*\///;
		my ($fileurl) = urlencode($filename);
		print "<a name=\"rev$_\"></a>";

		if (defined($revsym{$_})) {
			foreach my $sym (split (", ", $revsym{$_})) {
				print "<a name=\"$sym\"></a>";
			}
		}

		if (defined($revsym{$br}) && $revsym{$br}
		    && !defined($nameprinted{$br}))
		{
			foreach my $sym (split (", ", $revsym{$br})) {
				print "<a name=\"$sym\"></a>";
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
			&download_link($fileurl, $_, "view",
				"text/x-cvsweb-markup");
			print ")";
		}

		if ($allow_annotate) {
			print " - ";
			print &link(
				'annotate',
				sprintf(
					'%s/%s?annotate=%s%s', $scriptname,
					urlencode($where),     $_,
					$barequery
				)
			);
		}

		# Plus a select link if enabled, and this version isn't selected
		if ($allow_version_select) {
			if ((!defined($input{"r1"}) || $input{"r1"} ne $_)) {
				print " - ";
				print &link(
					'[select for diffs]',
					sprintf(
						'%s?r1=%s%s', $scriptwhere,
						$_,           $barequery
					)
				);
			} else {
				print " - <b>[selected]</b>";
			}
		}
	} else {
		print "Revision <b>$_</b>";
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
	print readableTime(time() - $date{$_}, 1), " ago)";
	print " by ";
	print "<i>", $author{$_}, "</i>\n";
	print "<br>Branch: <b>", $link ? link_tags($revsym{$br}) : $revsym{$br},
	    "</b>\n"
	    if ($revsym{$br});
	print "<br>CVS Tags: <b>", $link ? link_tags($revsym{$_}) : $revsym{$_},
	    "</b>"
	    if ($revsym{$_});
	print "<br>Branch point for: <b>",
	    $link ? link_tags($branchpoint{$_}) : $branchpoint{$_}, "</b>\n"
	    if ($branchpoint{$_});

	# Find the previous revision
	my @prevrev = split (/\./, $_);
	do {
		if (--$prevrev[$#prevrev] <= 0) {

			# If it was X.Y.Z.1, just make it X.Y
			pop (@prevrev);
			pop (@prevrev);
		}
		$prev = join (".", @prevrev);
	} until (defined($date{$prev}) || $prev eq "");

	if ($prev ne "") {
		if ($difflines{$_}) {
			print
			    "<br>Changes since <b>$prev: $difflines{$_} lines</b>";
		}
	}

	if ($isDead) {
		print "<br><b><i>FILE REMOVED</i></b>\n";
	} elsif ($link) {
		my %diffrev = ();
		$diffrev{$_} = 1;
		$diffrev{""} = 1;
		print '<br>';
		my $diff = 'Diff';

		#
		# Offer diff to previous revision
		if ($prev) {
			$diffrev{$prev} = 1;

			my $url =
			    sprintf('%s.diff?r1=%s&r2=%s%s', $scriptwhere,
				$prev, $_, $barequery);

			print $diff, " to previous ";
			$diff = '';
			printDiffLinks($prev, $url);
		}

		#
		# Plus, if it's on a branch, and it's not a vendor branch,
		# offer a diff with the branch point.
		if ($revsym{$brp} && !/^1\.1\.1\.\d+$/
		    && !defined($diffrev{$brp}))
		{
			my $url =
			    sprintf('%s.diff?r1=%s&r2=%s%s', $scriptwhere, $brp,
				$_, $barequery);

			print $diff, " to branchpoint ";
			$diff = '';
			printDiffLinks($brp, $url);
		}

		#
		# Plus, if it's on a branch, and it's not a vendor branch,
		# offer to diff with the next revision of the higher branch.
		# (e.g. change gets committed and then brought
		# over to -stable)
		if (/^\d+\.\d+\.\d+/ && !/^1\.1\.1\.\d+$/) {
			my ($i, $nextmain);

			for ($i = 0 ; $i < $#revorder && $revorder[$i] ne $_ ;
			    $i++)
			{
			}
			my @tmp2 = split (/\./, $_);
			for ($nextmain = "" ; $i > 0 ; $i--) {
				my $next = $revorder[$i - 1];
				my @tmp1 = split (/\./, $next);

				if (@tmp1 < @tmp2) {
					$nextmain = $next;
					last;
				}

				# Only the highest version on a branch should have
				# a diff for the "next main".
				last
				    if (@tmp1 - 1 <= @tmp2
				    && join (".", @tmp1[0 .. $#tmp1 - 1]) eq
				    join (".", @tmp2[0 .. $#tmp1 - 1]));
			}

			if (!defined($diffrev{$nextmain})) {
				$diffrev{$nextmain} = 1;

				my $url =
				    sprintf('%s.diff?r1=%s&r2=%s%s',
					$scriptwhere, $nextmain, $_,
					$barequery);

				print $diff, " next main ";
				$diff = '';
				printDiffLinks($nextmain, $url);
			}
		}

		# Plus if user has selected only r1, then present a link
		# to make a diff to that revision
		if (defined($input{"r1"}) && !defined($diffrev{$input{"r1"}})) {
			$diffrev{$input{"r1"}} = 1;

			my $url =
			    sprintf('%s.diff?r1=%s&r2=%s%s', $scriptwhere,
				$input{'r1'}, $_, $barequery);

			print $diff, " to selected ";
			$diff = '';
			printDiffLinks($input{'r1'}, $url);
		}

	}
	print "\n</p>\n<pre>\n";
	print &htmlify($log{$_}, $allow_log_extra);
	print "</pre>\n";
}

sub doLog($) {
	my ($fullname) = @_;
	my ($diffrev, $upwhere, $filename, $backurl);

	readLog($fullname);

	html_header("CVS log for $where");
	($upwhere  = $where) =~ s|(Attic/)?[^/]+$||;
	($filename = $where) =~ s|^.*/||;
	$backurl = $scriptname . "/" . urlencode($upwhere) . $query;
	print "<p>\n ";
	print &link($backicon, "$backurl#$filename"), " <b>Up to ",
	    &clickablePath($upwhere, 1), "</b>\n</p>\n";
	print "<p>\n ";
	print &link('Request diff between arbitrary revisions', '#diff');
	print "\n</p>\n<hr noshade>\n";

	print "<p>\n";
	if ($curbranch) {
		print "Default branch: ", ($revsym{$curbranch} || $curbranch);
	} else {
		print "No default branch";
	}
	print "<br>\n";

	if ($input{only_with_tag}) {
		print "Current tag: $input{only_with_tag}<br>\n";
	}
	print "</p>\n";

	undef %nameprinted;

	for (my $i = 0 ; $i <= $#revdisplayorder ; $i++) {
		print "<hr size=\"1\" noshade>\n";
		printLog($revdisplayorder[$i]);
	}

	print "<hr noshade>\n<p>\n";
	print "<a name=\"diff\">\n";
	print "This form allows you to request diff's between any two\n";
	print "revisions of a file.  You may select a symbolic revision\n";
	print "name using the selection box or you may type in a numeric\n";
	print "name using the type-in text box.\n";
	print "</a>\n</p>\n";
	print
	    "<form method=\"get\" action=\"${scriptwhere}.diff\" name=\"diff_select\">\n";

	foreach (@stickyvars) {
		printf('<input type="hidden" name="%s" value="%s">', $_,
		    $input{$_})
		    if (defined($input{$_})
		    && ((!defined($DEFAULTVALUE{$_})
		    || $input{$_} ne $DEFAULTVALUE{$_}) && $input{$_} ne ""));
	}
	print "<table style=\"border: none\">\n<tr>\n";
	print "<td align=\"right\">";
	print "<label for=\"r1\" accesskey=\"1\">Diffs between </label>\n";
	print "<select id=\"r1\" name=\"r1\">\n";
	print "<option value=\"text\" selected>Use Text Field</option>\n";
	print $sel;
	print "</select>\n";
	$diffrev = $revdisplayorder[$#revdisplayorder];
	$diffrev = $input{"r1"} if (defined($input{"r1"}));
	print
	    "<input type=\"text\" size=\"$inputTextSize\" name=\"tr1\" value=\"$diffrev\" onchange=\"this.form.r1.selectedIndex=0\"></td>\n";
	print "<td><br></td>\n</tr>\n";
	print "<tr>\n<td align=\"right\">";
	print "<label for=\"r2\" accesskey=\"2\">and </label>\n";
	print "<select id=\"r2\" name=\"r2\">\n";
	print "<option value=\"text\" selected>Use Text Field</option>\n";
	print $sel;
	print "</select>\n";
	$diffrev = $revdisplayorder[0];
	$diffrev = $input{"r2"} if (defined($input{"r2"}));
	print
	    "<input type=\"text\" size=\"$inputTextSize\" name=\"tr2\" value=\"$diffrev\" onchange=\"this.form.r2.selectedIndex=0\"></td>\n";
	print "<td><input type=\"submit\" value=\"  Get Diffs  \" accesskey=\"G\"></td>\n";
	print "</tr>\n</table>\n";
	print "</form>\n";
	print "<hr noshade>\n";
	print "<form method=\"get\" action=\"$scriptwhere\">\n";
	print "<table style=\"border: none\">\n";
	print "<tr>\n<td align=\"right\">";
	print "<label for=\"f\" accesskey=\"D\">Preferred Diff type:";
	print "</label></td>\n";
	print "<td>";
	printDiffSelect($use_java_script);
	print "</td>\n<td></td>\n</tr>\n";

	if (@branchnames) {
		print "<tr>\n<td align=\"right\">";
		print "<label for=\"only_with_tag\" accesskey=\"B\">";
		print "View only Branch:</label></td>\n";
		print "<td>";
		print "<a name=\"branch\"></a>\n";
		print "<select id=\"only_with_tag\" name=\"only_with_tag\"";
		print " onchange=\"this.form.submit()\"" if $use_java_script;
		print ">\n";
		print "<option value=\"\"";
		print " selected"
		    if (defined($input{"only_with_tag"})
		    && $input{"only_with_tag"} eq "");
		print ">Show all branches</option>\n";

		foreach (reverse sort @branchnames) {
			print "<option";
			print " selected"
			    if (defined($input{"only_with_tag"})
			    && $input{"only_with_tag"} eq $_);
			print ">${_}</option>\n";
		}
		print "</select></td>\n<td></td>\n</tr>\n";
	}

	foreach (@stickyvars) {
		next if ($_ eq "f");
		next if ($_ eq "only_with_tag");
		next if ($_ eq "logsort");
		print "<input type=\"hidden\" name=\"$_\" value=\"$input{$_}\">\n"
		    if (defined($input{$_})
		    && (!defined($DEFAULTVALUE{$_})
		    || $input{$_} ne $DEFAULTVALUE{$_}) && $input{$_} ne "");
	}
	print "<tr>\n<td align=\"right\">";
	print "<a name=\"logsort\"></a>\n";
	print "<label for=\"logsort\" accesskey=\"L\">Sort log by:";
	print "</label></td>\n<td>";
	printLogSortSelect($use_java_script);
	print "</td>\n";
	print "<td><input type=\"submit\" value=\"  Set  \" accesskey=\"S\"></td>\n";
	print "</tr>\n</table>\n";
	print "</form>\n";
	html_footer();
}

sub flush_diff_rows($$$$) {
	my $j;
	my ($leftColRef, $rightColRef, $leftRow, $rightRow) = @_;

	if (!defined($state)) {
		return;
	}

	if ($state eq "PreChangeRemove") {    # we just got remove-lines before
		for ($j = 0 ; $j < $leftRow ; $j++) {
			print
			    "<tr>\n<td class=\"diff-removed\">&nbsp;@$leftColRef[$j]</td>\n";
			print
			    "<td class=\"diff-empty\">&nbsp;</td>\n</tr>\n";
		}
	} elsif ($state eq "PreChange") {    # state eq "PreChange"
		    # we got removes with subsequent adds

		for ($j = 0 ; $j < $leftRow || $j < $rightRow ; $j++)
		{    # dump out both cols
			print "<tr>\n";
			if ($j < $leftRow) {
				print
				    "<td class=\"diff-changed\">&nbsp;@$leftColRef[$j]</td>";
			} else {
				print
				    "<td class=\"diff-changed-missing\">&nbsp;</td>";
			}
			print "\n";

			if ($j < $rightRow) {
				print
				    "<td class=\"diff-changed\">&nbsp;@$rightColRef[$j]</td>";
			} else {
				print
				    "<td class=\"diff-changed-missing\">&nbsp;</td>";
			}
			print "\n</tr>\n";
		}
	}
}

##
# Function to generate Human readable diff-files
# human_readable_diff(String revision_to_return_to);
##
sub human_readable_diff($) {
	my ($difftxt, $where_nd, $filename, $pathname, $scriptwhere_nd);
	my ($fh, $rev) = @_;
	my ($date1, $date2, $r1d, $r2d, $r1r, $r2r, $rev1, $rev2, $sym1, $sym2);
	my (@rightCol, @leftCol);

	($where_nd       = $where)       =~ s/.diff$//;
	($filename       = $where_nd)    =~ s/^.*\///;
	($pathname       = $where_nd)    =~ s/(Attic\/)?[^\/]*$//;
	($scriptwhere_nd = $scriptwhere) =~ s/.diff$//;

	navigateHeader($scriptwhere_nd, $pathname, $filename, $rev, "diff");

	# Read header to pick up read revision and date, if possible
	while (<$fh>) {
		($r1d, $r1r) = /\t(.*)\t(.*)$/ if (/^--- /);
		($r2d, $r2r) = /\t(.*)\t(.*)$/ if (/^\+\+\+ /);
		last if (/^\+\+\+ /);
	}

	if (defined($r1r) && $r1r =~ /^(\d+\.)+\d+$/) {
		$rev1  = $r1r;
		$date1 = $r1d;
	}
	if (defined($r2r) && $r2r =~ /^(\d+\.)+\d+$/) {
		$rev2  = $r2r;
		$date2 = $r2d;
	}

	print
	    "<h3 style=\"text-align: center\">Diff for /$where_nd between version $rev1 and $rev2</h3>\n",
	    # Using style=\"border: none\" here breaks NS 4.x badly...
	    "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">\n",
	    "<tr style=\"background-color: #ffffff\">\n", "<th width=\"50%\" valign=\"top\">",
	    "version $rev1";
	print ", $date1"         if (defined($date1));
	print "<br>Tag: $sym1\n" if ($sym1);
	print "</th>\n", "<th width=\"50%\" valign=\"top\">", "version $rev2";
	print ", $date2"         if (defined($date2));
	print "<br>Tag: $sym2\n" if ($sym1);
	print "</th>\n";

	my $leftRow  = 0;
	my $rightRow = 0;
	my ($oldline, $newline, $funname, $diffcode, $rest);

	# Process diff text

	# prefetch several lines
	my @buf = head($fh);

	my %d = scan_directives(@buf);

	while (@buf || !eof($fh)) {
		$difftxt = @buf ? shift @buf : <$fh>;

		if ($difftxt =~ /^@@/) {
			($oldline, $newline, $funname) =
			    $difftxt =~ /@@ \-([0-9]+).*\+([0-9]+).*@@(.*)/;
			$funname = htmlquote($funname);
			$funname =~ s/\s/&nbsp;/go;
			print
			    "<tr class=\"diff-heading\">\n<td width=\"50%\">";
			print
			    "<table width=\"100%\" border=\"1\" cellpadding=\"5\">\n<tr>\n<td><b>Line&nbsp;$oldline</b>";
			print
			    "&nbsp;<span style=\"font-size: smaller\">$funname</span></td>\n</tr>\n</table>";
			print "</td>\n<td width=\"50%\">";
			print
			    "<table width=\"100%\" border=\"1\" cellpadding=\"5\">\n<tr>\n<td><b>Line&nbsp;$newline</b>";
			print
			    "&nbsp;<span style=\"font-size: smaller\">$funname</span></td>\n</tr>\n</table>\n";
			print "</td>\n";
			$state    = "dump";
			$leftRow  = 0;
			$rightRow = 0;
		} else {
			($diffcode, $rest) = $difftxt =~ /^([-+ ])(.*)/;
			$_ = spacedHtmlText($rest, $d{'tabstop'});

			#########
			# little state machine to parse unified-diff output (Hen, zeller@think.de)
			# in order to get some nice 'ediff'-mode output
			# states:
			#  "dump"             - just dump the value
			#  "PreChangeRemove"  - we began with '-' .. so this could be the start of a 'change' area or just remove
			#  "PreChange"        - okey, we got several '-' lines and moved to '+' lines -> this is a change block
			##########

			if ($diffcode eq '+') {
				if ($state eq "dump")
				{ # 'change' never begins with '+': just dump out value
					print
					    "<tr>\n<td class=\"diff-empty\">&nbsp;</td>\n<td class=\"diff-added\">&nbsp;$_</td>\n</tr>\n";
				} else {    # we got minus before
					$state = "PreChange";
					$rightCol[$rightRow++] = $_;
				}
			} elsif ($diffcode eq '-') {
				$state = "PreChangeRemove";
				$leftCol[$leftRow++] = $_;
			} else {    # empty diffcode
				flush_diff_rows \@leftCol, \@rightCol, $leftRow,
				    $rightRow;
				print "<tr>\n<td class=\"diff-same\">&nbsp;$_</td>\n<td class=\"diff-same\">&nbsp;$_</td>\n</tr>\n";
				$state    = "dump";
				$leftRow  = 0;
				$rightRow = 0;
			}
		}
	}
	close($fh);

	flush_diff_rows \@leftCol, \@rightCol, $leftRow, $rightRow;

	# state is empty if we didn't have any change
	if (!$state) {
		print "<tr>\n<td colspan=\"2\">&nbsp;</td>\n</tr>\n";
		print "<tr class=\"diff-empty\">\n";
		print
		    "<td colspan=\"2\" align=\"center\"><b>- No viewable change -</b></td>\n</tr>\n";
	}
	print "</table>\n";

	print "<hr style=\"width: 100%\" noshade>\n";
	print "<form method=\"get\" action=\"${scriptwhere}\">\n";
	print "<table style=\"border: none\">\n<tr>\n<td>\n";

	# print legend
	print "<table border=\"1\">\n<tr>\n<td>";
	print "Legend:<br><table style=\"border: none\" cellspacing=\"0\" cellpadding=\"1\">\n";
	print
	    "<tr>\n<td align=\"center\" class=\"diff-removed\">Removed from v.$rev1</td>\n<td class=\"diff-empty\">&nbsp;</td>\n</tr>\n";
	print
	    "<tr class=\"diff-changed\">\n<td align=\"center\" colspan=\"2\">changed lines</td>\n</tr>\n";
	print
	    "<tr>\n<td class=\"diff-empty\">&nbsp;</td>\n<td align=\"center\" class=\"diff-added\">Added in v.$rev2</td>\n</tr>\n";
	print "</table>\n</td>\n</tr>\n</table>\n</td>\n<td>";

	# Print format selector
	foreach my $var (keys %input) {
		next if ($var eq "f");
		next
		    if (defined($DEFAULTVALUE{$var})
		    && $DEFAULTVALUE{$var} eq $input{$var});
		print "<input type=\"hidden\" name=\"", urlencode($var),
		    "\" value=\"", urlencode($input{$var}), "\">\n";
	}
	printDiffSelect($use_java_script);
	print "<input type=\"submit\" value=\"Show\">\n";
	print "</td>\n";

	print "</tr>\n</table>\n";
	print "</form>\n";
}

sub navigateHeader($$$$$) {
	my ($swhere, $path, $filename, $rev, $title) = @_;
	$swhere = "" if ($swhere eq $scriptwhere);
	$swhere = './' . urlencode($filename) if ($swhere eq "");

	# TODO: this should be moved into external CSS file.
	my $css = '';
	if ($title eq 'diff') {
	    $css = "
<style type=\"text/css\">
.diff-heading {
  background-color: $diffcolorHeading;
}
.diff-same {
  font-family: $difffontface;
  font-size: smaller;
}
.diff-empty {
  background-color: $diffcolorEmpty;
}
.diff-added {
  background-color: $diffcolorAdd;
  font-family: $difffontface;
  font-size: smaller;
}
.diff-removed {
  background-color: $diffcolorRemove;
  font-family: $difffontface;
  font-size: smaller;
}
.diff-changed {
  background-color: $diffcolorChange;
  font-family: $difffontface;
  font-size: smaller;
}
.diff-changed-missing {
  background-color: $diffcolorDarkChange;
}
</style>";
	}

	print <<EOF;
$HTML_DOCTYPE
<html>
<head>
<title>$path$filename - $title - $rev</title>$css
$HTML_META</head>
$body_tag_for_src
<table width="100%" style="border: none; background-color: $navigationHeaderColor" cellspacing="0" cellpadding="1">
<tr valign="bottom"><td>
EOF

	print &link($backicon, "$swhere$query#rev$rev");
	print "<b>Return to ", &link($filename, "$swhere$query#rev$rev"),
	    " CVS log";
	print "</b> $fileicon</td>";

	print "<td align=\"right\">$diricon <b>Up to ",
	  &clickablePath($path, 1),
	    "</b></td>";
	print "</tr></table>";
}

sub plural_write($$) {
	my ($num, $text) = @_;
	if ($num != 1) {
		$text .= "s";
	}

	if ($num > 0) {
		return join (' ', $num, $text);
	} else {
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
	my ($secs, $long) = @_;

	# this function works correct for time >= 2 seconds
	if ($secs < 2) {
		return "very little time";
	}

	my %desc = (
		1,        'second', 60,     'minute', 3600,    'hour',
		86400,    'day',    604800, 'week',   2628000, 'month',
		31536000, 'year'
	);
	my @breaks = sort { $a <=> $b } keys %desc;
	$i = 0;

	while ($i <= $#breaks && $secs >= 2 * $breaks[$i]) {
		$i++;
	}
	$i--;
	$break  = $breaks[$i];
	$retval = plural_write(int($secs / $break), $desc{$break});

	if ($long == 1 && $i > 0) {
		my $rest = $secs % $break;
		$i--;
		$break = $breaks[$i];
		my $resttime = plural_write(int($rest / $break), $desc{$break});
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
	my ($pathname, $clickLast) = @_;
	my $retval = '';

	if ($pathname eq '/') {

		# this should never happen - chooseCVSRoot() is
		# intended to do this
		$retval = "[$cvstree]";
	} else {
		$retval .= ' ' . &link("[$cvstree]",
			sprintf('%s/%s#dirlist', $scriptname, $query));
		my $wherepath = '';
		my ($lastslash) = $pathname =~ m|/$|;

		foreach (split (/\//, $pathname)) {
			$retval .= " / ";
			$wherepath .= "/$_";
			my ($last) = "$wherepath/" eq "/$pathname"
			    || $wherepath eq "/$pathname";

			if ($clickLast || !$last) {
				$retval .= &link($_,
					join ('', $scriptname,
					urlencode($wherepath),
					(!$last || $lastslash ? '/' : ''),
					$query,
					(!$last || $lastslash ? "#dirlist" : "")
				));
			} else {    # do not make a link to the current dir
				$retval .= $_;
			}
		}
	}
	return $retval;
}

sub chooseCVSRoot() {

	print "<form method=\"get\" action=\"${scriptwhere}\">\n";
	if (2 <= @CVSROOT) {
		my ($k);
		foreach $k (keys %input) {
			print "<input type=\"hidden\" name=\"$k\" value=\"$input{$k}\">\n"
			    if ($input{$k}) && ($k ne "cvsroot");
		}

		# Form-Elements look wierd in Netscape if the background
		# isn't gray and the form elements are not placed
		# within a table ...
		print "<table style=\"border: none\">\n<tr>\n";
		print "<td><label for=\"cvsroot\" accesskey=\"C\">CVS Root:</label></td>\n";
		print "<td>\n<select id=\"cvsroot\" name=\"cvsroot\"";
		print " onchange=\"this.form.submit()\"" if $use_java_script;
		print ">\n";

		foreach $k (@CVSROOT) {
			print "<option value=\"$k\"";
			print " selected" if ($k eq $cvstree);
			print ">",($CVSROOTdescr{$k} ? $CVSROOTdescr{$k} : $k),
			    "</option>\n";
		}
		print "</select>\n</td>\n<td>";
	} else {

		# no choice -- but we need the form to select module/path,
		# at least for Netscape
		print "<p>\n";
		print "CVS Root: <b>[$cvstree]</b>";
	}

	print " <label for=\"mpath\" accesskey=\"M\">Module path or alias:";
	print "</label>\n";
	print "<input type=\"text\" id=\"mpath\" name=\"path\" value=\"\" size=\"15\">\n";
	print "<input type=\"submit\" value=\"Go\" accesskey=\"O\">";

	if (2 <= @CVSROOT) {
		print "</td>\n</tr>\n</table>";
	} else {
		print "</p>";
	}
	print "\n</form>";
}

sub chooseMirror() {

	# This code comes from the original BSD-cvsweb
	# and may not be useful for your site; If you don't
	# set %MIRRORS this won't show up, anyway.
	scalar(%MIRRORS) or return;

	# Should perhaps exclude the current site somehow...
	print "\n<p>\nThis CVSweb is mirrored in\n";

	my @tmp = map(&link(htmlquote($_), $MIRRORS{$_}),
		      sort keys %MIRRORS);
	my $tmp = pop(@tmp);

	if (scalar(@tmp)) {
	    print join(', ', @tmp), ' and ';
	}

	print "$tmp.\n</p>\n";
}

sub fileSortCmp() {
	my ($comp) = 0;
	my ($c, $d, $af, $bf);

	($af = $a) =~ s/,v$//;
	($bf = $b) =~ s/,v$//;
	my ($rev1, $date1, $log1, $author1, $filename1) = @{$fileinfo{$af}}
	    if (defined($fileinfo{$af}));
	my ($rev2, $date2, $log2, $author2, $filename2) = @{$fileinfo{$bf}}
	    if (defined($fileinfo{$bf}));

	if (defined($filename1) && defined($filename2) && $af eq $filename1
	    && $bf eq $filename2)
	{

		# Two files
		$comp = -revcmp($rev1, $rev2) if ($byrev && $rev1 && $rev2);
		$comp = ($date2 <=> $date1) if ($bydate && $date1 && $date2);
		$comp = ($log1 cmp $log2) if ($bylog && $log1 && $log2);
		$comp = ($author1 cmp $author2)
		    if ($byauthor && $author1 && $author2);
	}

	if ($comp == 0) {

		# Directories first, then files under version control,
		# then other, "rogue" files.
		# Sort by filename if no other criteria available.

		my $ad = ((-d "$fullname/$a") ? 'D'
		    : (defined($fileinfo{$af}) ? 'F' : 'R'));
		my $bd = ((-d "$fullname/$b") ? 'D'
		    : (defined($fileinfo{$bf}) ? 'F' : 'R'));
		($c = $a) =~ s|.*/||;
		($d = $b) =~ s|.*/||;
		$comp = ("$ad$c" cmp "$bd$d");
	}
	return $comp;
}

# make A url for downloading
sub download_url($$;$) {
	my ($url, $revision, $mimetype) = @_;

	$revision =~ s/\b0\.//;

	if (defined($checkoutMagic)
	    && (!defined($mimetype) || $mimetype ne "text/x-cvsweb-markup"))
	{
		my $path = $where;
		$path =~ s|[^/]+$||;
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

	printf '<a href="%s"', hrefquote("$fullurl$barequery");

	if ($open_extern_window
	    && (!defined($mimetype) || $mimetype ne "text/x-cvsweb-markup"))
	{
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
			my @attr = qw(resizable scrollbars);

			push @attr, qw(status toolbar)
			    if (defined($mimetype) && $mimetype eq "text/html");

			push @attr, "width=$extern_window_width"
			    if (defined($extern_window_width));

			push @attr, "height=$extern_window_height"
			    if (defined($extern_window_height));

			# We need the "return false" here to prevent browsers
			# from following the href after the onclick handler.
			# This would effectively load the same document in
			# the same window *twice*.
			printf
			    q` onclick="window.open('%s','cvs_checkout','%s');return false"`,
			    hrefquote("$fullurl$barequery"), join (',', @attr);
		}
	}
	print "><b>$textlink</b></a>";
}

# Returns a Query string with the
# specified parameter toggled
sub toggleQuery($$) {
	my ($toggle, $value) = @_;
	my ($newquery, $var);
	my (%vars);
	%vars = %input;

	if (defined($value)) {
		$vars{$toggle} = $value;
	} else {
		$vars{$toggle} = $vars{$toggle} ? 0 : 1;
	}

	# Build a new query of non-default paramenters
	$newquery = "";
	foreach $var (@stickyvars) {
		my ($value) = defined($vars{$var}) ? $vars{$var} : "";
		my ($default) =
		    defined($DEFAULTVALUE{$var}) ? $DEFAULTVALUE{$var} : "";

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
	local ($_) = @_;

	s/[\000-+{-\377]/sprintf("%%%02x", ord($&))/ge;

	$_;
}

sub htmlquote($) {
	local ($_) = @_;

	# Special Characters; RFC 1866
	s/&/&amp;/g;
	s/\"/&quot;/g;
	s/</&lt;/g;
	s/>/&gt;/g;

	$_;
}

sub htmlunquote($) {
	local ($_) = @_;

	# Special Characters; RFC 1866
	s/&quot;/\"/g;
	s/&lt;/</g;
	s/&gt;/>/g;
	s/&amp;/&/g;

	$_;
}

sub hrefquote($) {
	local ($_) = @_;

	y/ /+/;

	htmlquote($_)
}

sub http_header(;$) {
	my $content_type = shift || "text/html";

	$content_type .= "; charset=$charset"
	    if $content_type =~ m,^text/, && defined($charset) && $charset;

	if (defined($moddate)) {
		if ($is_mod_perl) {
			Apache->request->header_out(
				"Last-Modified" => scalar gmtime($moddate)
				. " GMT");
		} else {
			print "Last-Modified: ", scalar gmtime($moddate),
			    " GMT\r\n";
		}
	}

	if ($is_mod_perl) {
		Apache->request->content_type($content_type);
	} else {
		print "Content-Type: $content_type\r\n";
	}

	if ($allow_compress && $maycompress) {
		if ($has_zlib
		    || (defined($CMD{gzip}) && open(GZIP, "| $CMD{gzip} -1 -c"))
		    )
		{

			if ($is_mod_perl) {
				Apache->request->content_encoding("x-gzip");
				Apache->request->header_out(
					Vary => "Accept-Encoding");
				Apache->request->send_http_header;
			} else {
				print "Content-Encoding: x-gzip\r\n";
				print "Vary: Accept-Encoding\r\n"
				    ;            #RFC 2068, 14.43
				print "\r\n";    # Close headers
			}
			$| = 1;
			$| = 0;    # Flush header output

			if ($has_zlib) {
				tie *GZIP, __PACKAGE__, \*STDOUT;
			}
			select(GZIP);
			$gzip_open = 1;

			#	    print "<!-- gzipped -->" if ($content_type =~ m|^text/html\b|);
		} else {
			if ($is_mod_perl) {
				Apache->request->send_http_header;
			} else {
				print "\r\n";    # Close headers
			}
			print
			    "<span style=\"font-size: smaller\">Unable to find gzip binary in the <b>\$command_path</b> ($command_path) to compress output</span><br>";
		}
	} else {

		if ($is_mod_perl) {
			Apache->request->send_http_header;
		} else {
			print "\r\n";    # Close headers
		}
	}
}

sub html_header($) {
	my ($title) = @_;
	http_header("text/html");

	(my $header = &cgi_style::html_header($title, 0)) =~ s,\A.*<head>,<head>\n$HTML_META,s;
	print $header;
}

sub html_footer() {
	print &cgi_style::html_footer;
}

sub link_tags($) {
	my ($tags) = @_;
	my ($ret)  = "";
	my ($fileurl, $filename);

	($filename = $where) =~ s/^.*\///;
	$fileurl = './' . urlencode($filename);

	foreach my $sym (split (", ", $tags)) {
		$ret .= ",\n" if ($ret ne "");
		$ret .=
		    &link($sym, $fileurl . toggleQuery('only_with_tag', $sym));
	}
	return "$ret\n";
}

#
# See if a module is listed in the config file's @HideModules list.
#
sub forbidden_module($) {
	my ($module) = @_;
	local $_;

	for (@HideModules) {
		return 1 if $module =~ $_;
	}
	return 0;
}

sub forbidden_file($) {
	my ($path) = @_;
	$path =  substr($path, length($cvsroot) + 1);
	local $_;
	for (@ForbiddenFiles) {
		return 1 if $path =~ $_;
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
sub OSCODE() { 3 }

sub TIEHANDLE {
	my ($class, $out) = @_;
	my ($d) = Compress::Zlib::deflateInit(
		-Level      => Compress::Zlib::Z_BEST_COMPRESSION(),
		-WindowBits => -Compress::Zlib::MAX_WBITS()
	) or return undef;
	my ($o) = {
		handle => $out,
		dh     => $d,
		crc    => 0,
		len    => 0,
	};
	my ($header) =
	    pack("c10", MAGIC1, MAGIC2, Compress::Zlib::Z_DEFLATED(), 0, 0, 0,
	    0, 0, 0, OSCODE);
	print {$o->{handle}} $header;
	return bless($o, $class);
}

sub PRINT {
	my ($o)   = shift;
	my ($buf) = join (defined $, ? $, : "", @_);
	my ($len) = length($buf);
	my ($compressed, $status) = $o->{dh}->deflate($buf);
	print {$o->{handle}} $compressed if defined($compressed);
	$o->{crc} = Compress::Zlib::crc32($buf, $o->{crc});
	$o->{len} += $len;
	return $len;
}

sub PRINTF {
	my ($o)   = shift;
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
	return if !defined($o->{dh});
	my ($buf) = $o->{dh}->flush();
	$buf .= pack("V V", $o->{crc}, $o->{len});
	print {$o->{handle}} $buf;
	undef $o->{dh};
}

sub DESTROY {
	my ($o) = @_;
	CLOSE($o);
}

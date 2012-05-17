#!/usr/bin/perl -T
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
#           (c) 2002-2005 Ville Skyttä
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
# $FreeBSD: www/en/cgi/cvsweb.cgi,v 1.92 2008/09/23 16:31:45 wosch Exp $
# $Id: cvsweb.cgi,v 1.93 2010-11-13 16:37:18 simon Exp $
# $Idaemons: /home/cvs/cvsweb/cvsweb.cgi,v 1.84 2001/10/07 20:50:10 knu Exp $
#
###

require 5.006;

use strict;

use warnings;
use filetest qw(access);

use vars qw (
  $VERSION $CheckoutMagic $MimeTypes $DEBUG
  $config $allow_version_select
  @CVSrepositories @CVSROOT %CVSROOT %CVSROOTdescr
  %MIRRORS %DEFAULTVALUE %ICONS %MTYPES
  %DIFF_COMMANDS @DIFFTYPES %DIFFTYPES @LOGSORTKEYS %LOGSORTKEYS
  %alltags %fileinfo %tags @branchnames %nameprinted
  %symrev %revsym @allrevisions %date %author @revdisplayorder
  @revisions %state %difflines %log %branchpoint @revorder $keywordsubstitution
  $prcgi @prcategories $re_prcategories $prkeyword $re_prkeyword $mancgi
  $doCheckout $scriptname $scriptwhere
  $where $Browser $nofilelinks $maycompress @stickyvars %funcline_regexp
  $is_links $is_lynx $is_w3m $is_msie $is_mozilla3 $is_textbased
  %input $query $barequery $sortby $bydate $byrev $byauthor
  $bylog $byfile $defaultDiffType $logsort $cvstree $cvsroot
  $charset $output_filter
  @command_path %CMD $allow_compress $backicon $diricon $fileicon $graphicon
  $fullname $cvstreedefault $logo $defaulttitle $address $binfileicon
  $long_intro $short_instruction $shortLogLen $show_author
  $tablepadding $hr_breakable $showfunc $hr_ignwhite $hr_ignkeysubst
  $inputTextSize $mime_types $allow_annotate $allow_markup $allow_mailtos
  $allow_log_extra $allow_dir_extra $allow_source_extra
  $allow_cvsgraph $cvsgraph_config $use_java_script $edit_option_form
  $show_subdir_lastmod $show_log_in_markup $preformat_in_markup
  $tabstop $state $annTable $sel @ForbiddenFiles
  $use_descriptions %descriptions @mytz $dwhere
  $use_moddate $gzip_open $file_list_len
  $allow_tar @tar_options @gzip_options @zip_options @cvs_options
  @annotate_options @rcsdiff_options
  $HTML_DOCTYPE $HTML_META $cssurl $CSS $cvshistory_url
  $allow_enscript @enscript_options %enscript_types
);

use Cwd                   qw(abs_path);
use File::Basename        qw(dirname);
use File::Path            qw(rmtree);
use File::Spec::Functions qw(canonpath catdir catfile curdir devnull rootdir
                             tmpdir updir);
use File::Temp            qw(tempdir tempfile);
use IPC::Run              qw();
use Time::Local           qw(timegm);
use URI::Escape           qw(uri_escape uri_unescape);

use constant VALID_PATH   => qr/^([[:^cntrl:]]+)$/o;
use constant VALID_TAG1   => qr/^([a-zA-Z][[:graph:]]*)$/o;
use constant VALID_TAG2   => qr/^([^\$,.:;@]+)$/o;
use constant CVSWEBMARKUP => qr{^text/(x-cvsweb|vnd\.viewcvs)-markup$}io;
use constant LOG_FILESEPR => qr/^={77}$/o;
use constant LOG_REVSEPR  => qr/^-{28}$/o;

use constant HAS_ZLIB     => eval { require Compress::Zlib; };
use constant HAS_EDIFF    => eval { require String::Ediff;  };

# -----------------------------------------------------------------------------

# All global initialization that can be done in compile time should go to
# the BEGIN block.  Persistent environments, such as mod_perl, will benefit
# from this.

BEGIN
{
  $VERSION = '3.0.6';

  $HTML_DOCTYPE =
    '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" ' .
    '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';

  $HTML_META = <<EOM;
<meta name="robots" content="nofollow" />
<meta name="generator" content="FreeBSD-CVSweb $VERSION" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
EOM

  # Use MIME::Types for MIME type lookups if it's available.
  eval {
    require MIME::Types;
    $MimeTypes = MIME::Types->new(only_complete => 1);
  };
  $MimeTypes = undef if $@;

  $CheckoutMagic = '~checkout~';

  $cgi_style::hsty_base = 'http://www.FreeBSD.org';
  $_ = q$FreeBSD: www/en/cgi/cvsweb.cgi,v 1.92 2008/09/23 16:31:45 wosch Exp $;
  @_ = split;
  $cgi_style::hsty_date = "@_[3,4]";

  # warningproof
  0 if $cgi_style::hsty_base ne $cgi_style::hsty_date;

  package cgi_style;
  require "./cgi-style.pl";
  $cgi_style::t_style = qq{\n<link rel="search" type="application/opensearchdescription+xml" href="http://www.freebsd.org/search/opensearch/cvsweb.xml" title="FreeBSD cvsweb" />\n};
  package main;
}

# -----------------------------------------------------------------------------

sub printDiffSelect($);
sub printDiffSelectStickyVars();
sub getDiffLinks($$$);
sub printLogSortSelect($);
sub findLastModifiedSubdirs(@);
sub htmlify_sub(&$);
sub htmlify($;$);
sub spacedHtmlText($;$);
sub link($$);
sub revcmp($$);
sub fatal($$@);
sub config_error($$);
sub redirect($;$);
sub safeglob($);
sub search_path($);
sub getEnscriptHL($);
sub getMimeType($;$);
sub head($;$);
sub scan_directives(@);
sub openOutputFilter();
sub doAnnotate($$);
sub doCheckout($$$);
sub doEnscript($$$;$);
sub doGraph();
sub doGraphView();
sub cvswebMarkup($$$$$$;$);
sub viewable($);
sub doDiff($$$$$$);
sub getDirLogs($$@);
sub readLog($;$);
sub printLog($$$;$$);
sub doLog($);
sub flush_diff_rows($$$$);
sub human_readable_diff($$);
sub navigateHeader($$$$$;$);
sub plural_write($$);
sub readableTime($$);
sub clickablePath($$);
sub chooseCVSRoot();
sub chooseMirror();
sub fileSortCmp();
sub download_url($$;$);
sub download_link($$$;$);
sub display_url($$;$);
sub display_link($$;$$);
sub graph_link($;$);
sub history_link($$;$);
sub toggleQuery($;$);
sub htmlquote($);
sub htmlunquote($);
sub uri_escape_path($);
sub http_header(;$$);
sub html_header($;$);
sub html_footer();
sub link_tags($);
sub forbidden($);
sub startproc(@);
sub runproc(@);
sub checkout_to_temp($$$);

# Get rid of unsafe environment vars.  Don't do this in the BEGIN block
# (think mod_perl)...
delete(@ENV{qw(PATH IFS CDPATH ENV BASH_ENV)});

my ($mydir) = (dirname($0) =~ /(.*)/);    # untaint

##### Start of Configuration Area ########

# == EDIT this ==
# Locations to search for user configuration, in order:
for (catfile($mydir, 'cvsweb.conf'), '/usr/local/etc/cvsweb/cvsweb.conf') {
  if (-r $_) {
    $config = $_;
    last;
  }
}

##### End of Configuration Area   ########

undef $mydir;

######## Configuration parameters #########

@CVSrepositories = @CVSROOT = %CVSROOT = %MIRRORS = %DEFAULTVALUE = %ICONS =
  %MTYPES = %tags = %alltags = %fileinfo = %DIFF_COMMANDS = ();

$cvstreedefault = $logo = $defaulttitle =
  $address = $long_intro = $short_instruction = $shortLogLen = $show_author =
  $tablepadding = $hr_breakable = $showfunc = $hr_ignwhite =
  $hr_ignkeysubst = $inputTextSize = $mime_types = $allow_annotate =
  $allow_markup = $allow_compress = $use_java_script = $edit_option_form =
  $show_subdir_lastmod = $show_log_in_markup = $preformat_in_markup =
  $tabstop = $use_moddate = $gzip_open = $DEBUG = $allow_cvsgraph =
  $cvsgraph_config = $cvshistory_url = $allow_tar = undef;

$allow_version_select = $allow_mailtos = $allow_log_extra = 1;

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
    # width=168 should be enough to support 80 character line lengths
    'opts'    => ['--side-by-side', '--width=168'],
    'colored' => 0,
  },
);

@LOGSORTKEYS = qw(cvs date rev);
@LOGSORTKEYS{@LOGSORTKEYS} = (
  { descr => 'Not sorted',  },
  { descr => 'Commit date', },
  { descr => 'Revision',    },
);

##### End of configuration parameters #####

my $pathinfo = '';
if (defined($ENV{PATH_INFO}) && $ENV{PATH_INFO} ne '') {
  ($pathinfo) = ($ENV{PATH_INFO} =~ VALID_PATH)
    or fatal('500 Internal Error',
             'Illegal PATH_INFO in environment: <code>%s</code>',
             $ENV{PATH_INFO});
}
if ($ENV{SCRIPT_NAME}) {
  ($scriptname) = ($ENV{SCRIPT_NAME} =~ VALID_PATH)
    or fatal('500 Internal Error',
             'Illegal SCRIPT_NAME in environment: <code>%s</code>',
             $ENV{SCRIPT_NAME});
}

$scriptname    = '' unless defined($scriptname);

$where         =  $pathinfo;
$doCheckout    =  $where =~ s|^/$CheckoutMagic/|/|o;
$where         =~ s|^/||;
$scriptname    =~ s|^/*|/|;

# Let's workaround thttpd's stupidity..
if ($scriptname =~ m|/$|) {
  $pathinfo .= '/';
  my $re = quotemeta $pathinfo;
  $scriptname =~ s/$re$//;
}

# $scriptname : the URI escaped path to this script
# $where      : the path in the CVS repository (without leading /, or only /)
# $scriptwhere: the URI escaped $scriptname + '/' + $where
$scriptname   = uri_escape_path($scriptname);
$scriptwhere  = join('/', $scriptname, uri_escape_path($where));
$where        = '/' if ($where eq '');

# In text-based browsers, it's very annoying to have two links per file;
# skip linking the image for them.

$Browser     = $ENV{HTTP_USER_AGENT} || '';
$is_links    = ($Browser =~ m`^E?Links `);
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
$maycompress = (
  ((defined($ENV{HTTP_ACCEPT_ENCODING})
    && $ENV{HTTP_ACCEPT_ENCODING} =~ /gzip/)
   || $is_mozilla3)
  && !$is_msie
  && !(defined($ENV{MOD_PERL}) && !HAS_ZLIB)
);

# Parameters that will be sticky in all constructed links/query strings.
@stickyvars =
  qw(cvsroot hideattic ignorecase sortby logsort f only_with_tag ln
     hidecvsroot hidenonreadable);

#
# Load configuration.
#
if (-f $config) {
  do "$config" or config_error($config, $@);
} else {
  fatal("500 Internal Error",
        'Configuration not found.  Set the parameter <code>$config</code> in cvsweb.cgi to your <b>cvsweb.conf</b> configuration file first.');
}

# Try to find a readable dir where we can cd into.  Some abs_path()
# implementations as well as various cvs operations require such a dir to
# work properly.
{
  local $^W = 0;
  for my $dir (tmpdir(), rootdir()) {
    last if (-r $dir && chdir($dir));
  }
}

$CSS = $cssurl ?
  sprintf("<link rel=\"stylesheet\" type=\"text/css\" href=\"%s\" />\n",
          htmlquote($cssurl)) : '';

# --- input parameters

my %query = ();
if (defined($ENV{QUERY_STRING})) {
  for my $p (split(/[;&]+/, $ENV{QUERY_STRING})) {
    next unless $p;
    $p =~ y/+/ /;
    my ($key, $val) = split(/=/, $p, 2);
    next unless defined($key);
    $val = 1 unless defined($val);
    ($key = uri_unescape($key)) =~ /[[:graph:]]/ or next;
    ($val = uri_unescape($val)) =~ /[[:graph:]]/ or next;
    $query{$key} = $val;
  }
}

undef %input;

my $t;
for my $p (qw(graph hideattic hidecvsroot hidenonreadable ignorecase ln copt
              makeimage options tarball)) {
  $t = $query{$p};
  if (defined($t)) {
    ($input{$p}) = ($t =~ /^([01]|on)$/)
      or fatal('500 Internal Error',
               'Invalid boolean value: <code>%s=%s</code>', $p, $t);
  }
}
for my $p (qw(annotate r1 r2 rev tr1 tr2)) {
  $t = $query{$p};
  if (defined($t)) {
    if (($p eq 'r1' || $p eq 'r2') && $t eq 'text') {
      # Special case for the "Use text field" option in the log view diff form.
      $input{$p} = $t;
      next;
    } elsif (($p eq 'rev' || $p eq 'annotate') && ($t eq '.' || $t eq 'HEAD')){
      # Another special case, allow linking to latest revision using these.
      $input{$p} = '.';
      next;
    }
    my ($rev, $tag) = split(/:/, $t, 2);
    ($input{$p}) = ($rev =~ /^(\d+(?:\.\d+)*)$/)
      or fatal('500 Internal Error',
               'Invalid revision: <code>%s=%s</code>', $p, $t);
    if (defined($tag)) {
      ($tag) = ($tag =~ VALID_TAG1)
        or fatal('500 Internal Error',
                 'Invalid tag/branch name in revision: <code>%s=%s</code>',
                 $p, $t);
      ($tag) = ($tag =~ VALID_TAG2)
        or fatal('500 Internal Error',
                 'Invalid tag/branch name in revision: <code>%s=%s</code>',
                 $p, $t);
      $input{$p} .= ':' . $tag;
    }
  }
}
$t = defined($query{only_with_tag}) ?
  $query{only_with_tag} : $query{only_on_branch}; # Backwards compatibility.
if (defined($t)) {
  ($input{only_with_tag}) = ($t =~ VALID_TAG1)
    or fatal('500 Internal Error',
             'Invalid tag/branch name: <code>%s</code>', $t);
  ($input{only_with_tag}) = ($t =~ VALID_TAG2)
    or fatal('500 Internal Error',
             'Invalid tag/branch name: <code>%s</code>', $t);
}
$t = $query{logsort};
if (defined($t)) {
  ($input{logsort}) = ($t =~ /^(cvs|date|rev)$/)
    or fatal('500 Internal Error',
             'Unsupported log sort key: <code>%s</code>', $t);
}
$t = $query{f};
if (defined($t)) {
  ($input{f}) = ($t =~ /^(([hH]|[ucs]c?)|ext\d*)$/)
    or fatal('500 Internal Error',
             'Unsupported diff format: <code>%s</code>', $t);
}
$t = $query{sortby};
if (defined($t)) {
  ($input{sortby}) = ($t =~ /^(file|date|rev|author|log)$/)
    or fatal('500 Internal Error',
             'Unsupported dir sort key: <code>%s</code>', $t);
}
$t = $query{'content-type'};
if (defined($t)) {
  ($input{'content-type'}) = ($t =~ m|^([-0-9A-Za-z]+/[-0-9A-Za-z\.\+]+)$|)
    or fatal('500 Internal Error',
             'Unsupported content type: <code>%s</code>', $t);
}
$t = $query{cvsroot};
if (defined($t)) {
  ($input{cvsroot}) = ($t =~ /^([[:print:]]+)$/)
    or fatal('500 Internal Error',
             'Invalid symbolic CVS root name: <code>%s</code>', $t);
}
$t = $query{path};
if (defined($t)) {
  ($input{path}) = ($t =~ VALID_PATH)
    or fatal('500 Internal Error',
             'Invalid path: <code>%s</code>', $t);
}
undef($t);
undef(%query);

# --- end input parameters

#
# CVS roots
#
my $rootfound = 0;
for (my $i = 0; $i < scalar(@CVSrepositories); $i += 2) {
  my $key = $CVSrepositories[$i];
  my ($descr, $root) = @{$CVSrepositories[$i+1]};
  $root = canonpath($root);
  unless (-d $root) {
    warn("Root '$root' defined in \@CVSrepositories is not a directory, " .
         'entry ignored');
    next;
  }
  $rootfound ||= 1;
  $cvstreedefault = $key unless defined($cvstreedefault);
  $CVSROOTdescr{$key} = $descr;
  $CVSROOT{$key} = $root;
  push(@CVSROOT, $key);
}
unless ($rootfound) {
  fatal('500 Internal Error',
        'No valid CVS roots found!  See <code>@CVSrepositories</code> in ' .
        'the configuration file (<code>%s</code>).',
        $config);
}
undef $rootfound;

#
# Default CVS root
#
if (!defined($CVSROOT{$cvstreedefault})) {
  fatal("500 Internal Error",
        '<code>$cvstreedefault</code> points to a repository (%s) not ' .
        'defined in <code>@CVSrepositories</code> in your configuration ' .
        'file (<code>%s</code>).',
        $cvstreedefault,
        $config);
}

$DEFAULTVALUE{cvsroot} = $cvstreedefault;

while (my ($key, $defval) = each %DEFAULTVALUE) {

  # Replace not given parameters with defaults.
  next unless (defined($defval) && $defval =~ /\S/ && !defined($input{$key}));

  # Empty checkboxes in forms return nothing, so we define a helper parameter
  # in these forms (copt) which indicates that we just set parameters with a
  # checkbox.
  if ($input{copt}) {

    # 'copt' is set -> the result of empty input checkbox
    # -> set to zero (disable) if default is a boolean (0|1).
    $input{$key} = 0 if ($defval eq '0' || $defval eq '1');

  } else {

    # 'copt' isn't set --> empty input is not the result
    # of empty input checkbox --> set default.
    $input{$key} = $defval;
  }
}

$barequery = "";
my @barequery;
foreach (@stickyvars) {

  # construct a query string with the sticky non default parameters set
  if (defined($input{$_})
      && !(defined($DEFAULTVALUE{$_}) && $input{$_} eq $DEFAULTVALUE{$_}))
  {
    push(@barequery, join('=', uri_escape($_), uri_escape($input{$_})));
  }
}

if ($allow_enscript) {
  push(@DIFFTYPES, qw(uc cc sc));
  @DIFFTYPES{qw(uc cc sc)} = (
    {
     'descr'   => 'unified, colored',
     'opts'    => ['-u'],
     'colored' => 0,
    },
    {
     'descr'   => 'context, colored',
     'opts'    => ['-c'],
     'colored' => 0,
    },
    {
     'descr'   => 'side by side, colored',
     # width=168 should be enough to support 80 character line lengths
     'opts'    => ['--side-by-side', '--width=168'],
     'colored' => 0,
    },
  );
} else {
  # No Enscript -> respect difftype, but don't offer colorization.
  if ($input{f} && $input{f} =~ /^([ucs])c$/) {
    $input{f} = $1;
  }
}

# is there any query ?
if (@barequery) {
  $barequery = join (';', @barequery);
  $query     = "?$barequery";
  $barequery = ";$barequery";
} else {
  $query = "";
}
undef @barequery;

if (defined($input{path})) {
  redirect("$scriptname/$input{path}$query");
}

# get actual parameters
{
  my $sortby = $input{sortby} || 'file';
  $bydate    = 0;
  $byrev     = 0;
  $byauthor  = 0;
  $bylog     = 0;
  $byfile    = 0;
  if ($sortby eq 'date') {
    $bydate = 1;
  } elsif ($sortby eq 'rev') {
    $byrev = 1;
  } elsif ($sortby eq 'author') {
    $byauthor = 1;
  } elsif ($sortby eq 'log') {
    $bylog = 1;
  } else {
    $byfile = 1;
  }
}

$defaultDiffType = $input{f};

$logsort = $input{logsort};

# alternate CVS-Tree, configured in cvsweb.conf
if ($input{cvsroot} && $CVSROOT{$input{cvsroot}}) {
  $cvstree = $input{cvsroot};
} else {
  $cvstree = $cvstreedefault;
}

$cvsroot = $CVSROOT{$cvstree};

# create icons out of description
foreach my $k (keys %ICONS) {
  my ($itxt, $ipath, $iwidth, $iheight) = @{$ICONS{$k}};
  no strict 'refs';
  if ($ipath) {
    ${"${k}icon"} =
      sprintf('<img src="%s" alt="%s" border="0" width="%d" height="%d" />',
              htmlquote($ipath), htmlquote($itxt), $iwidth, $iheight);
  } else {
    ${"${k}icon"} = $itxt;
  }
}

my $config_cvstree = "$config-$cvstree";

# Do some special configuration for cvstrees
if (-f $config_cvstree) {
  do "$config_cvstree"
    or fatal("500 Internal Error",
             'Error in loading configuration file: %s<br /><br />%s<br />',
             $config_cvstree, $@);
}
undef $config_cvstree;

$re_prcategories  = '(?:' . join ('|', @prcategories) . ')' if @prcategories;
$re_prkeyword     = quotemeta($prkeyword) if defined($prkeyword);
$prcgi           .= '%s' if defined($prcgi) && $prcgi !~ /%s/;

$fullname         = catfile($cvsroot, $where);

my $rewrite = 0;
if ($pathinfo =~ m|//|) {
  $pathinfo =~ y|/|/|s;
  $rewrite = 1;
}
if (-d $fullname) {
  if ($pathinfo !~ m|/$|) {
    $pathinfo .= '/';
    $rewrite   = 1;
  }
} elsif ($pathinfo =~ m|/$|) {
  chop $pathinfo;
  $rewrite = 1;
}
if ($rewrite) {
  redirect($scriptname . uri_escape_path($pathinfo) . $query, 1);
}
undef $rewrite;

undef $pathinfo;

if (!-d $cvsroot) {
  fatal("500 Internal Error",
        '$CVSROOT not found!<p>The server on which the CVS tree lives is probably down.  Please try again in a few minutes.');
}

#
# Short-circuit forbidden things.  Note that $fullname should not change
# after this, because the rest of the code assumes this check has already
# been done.
#
fatal('403 Forbidden', 'Access to %s forbidden.', $where)
  if forbidden($fullname);

#
# Handle tarball downloads before any headers are output.
#
if ($input{tarball}) {
  fatal('403 Forbidden', 'Downloading tarballs is prohibited.')
    unless $allow_tar;

  my ($module)  =  ($where =~ m,^/?(.*),);    # untaint
  $module       =~ s,/([^/]*)$,,;
  my ($ext)     =  ($1 =~ /(\.t(?:ar\.)?gz|\.zip)$/);
  my ($basedir) =  ($module =~ m,([^/]+)$,);

  if ($basedir eq '' || $module eq '') {
    fatal('500 Internal Error',
          'You cannot download the top level directory.');
  }

  my $istar = ($ext eq '.tar.gz' || $ext eq '.tgz');
  if ($istar) {
    fatal('500 Internal Error', 'tar command not found.') unless $CMD{tar};
    fatal('500 Internal Error', 'gzip command not found.') unless $CMD{gzip};
  }
  my $iszip = ($ext eq '.zip');
  if ($iszip && !$CMD{zip}) {
    fatal('500 Internal Error', 'zip command not found.');
  }
  if (!$istar && !$iszip) {
    fatal('500 Internal Error', 'Unsupported archive type.');
  }

  my $tmpexportdir;
  eval {
    local $SIG{__DIE__};
    # Don't use the CLEANUP argument to tempdir() here, since we might be under
    # mod_perl (the process runs for a long time), unlink explicitly later.
    $tmpexportdir = tempdir('.cvsweb.XXXXXXXX', TMPDIR => 1);
  };
  if ($@) {
    fatal('500 Internal Error', 'Unable to make temporary directory: %s', $@);
  }
  if (!chdir($tmpexportdir)) {
    fatal('500 Internal Error',
          "Can't cd to temporary directory %s: %s", $tmpexportdir, $!);
  }

  my @fatal;
  my $tag = $input{only_with_tag} || 'HEAD';
  $tag = 'HEAD' if ($tag eq 'MAIN');

  my @cmd =
    ($CMD{cvs}, @cvs_options, '-Qd', $cvsroot, 'export', '-r', $tag,
     '-d', $basedir, $module);
  my $export_err;
  my ($errcode, $err) = runproc(\@cmd, '2>', \$export_err);
  if ($errcode) {
    @fatal =
      ('500 Internal Error',
       'Export failure (exit status %s), output: <pre>%s</pre>',
       $errcode, $err || $export_err);

  } else {

    $| = 1;    # Essential to get the buffering right.
    local (*TAR_OUT);

    my (@cmd, $ctype);
    if ($istar) {
      my @tar = ($CMD{tar}, @tar_options, '-cf', '-', $basedir);
      my @gzip = ($CMD{gzip}, @gzip_options, '-c');
      push(@cmd, \@tar, '|', \@gzip);
      $ctype = 'application/x-gzip';
    } elsif ($iszip) {
      my @zip = ($CMD{zip}, @zip_options, '-r', '-', $basedir);
      push(@cmd, \@zip, \'');
      $ctype = 'application/zip';
    }
    push(@cmd, '>pipe', \*TAR_OUT);

    my ($h, $err) = startproc(@cmd);
    if ($h) {
      print "Content-Type: $ctype\r\n\r\n";
      local $/ = undef;
      print <TAR_OUT>;
      $h->finish();
    } else {
      @fatal = ('500 Internal Error',
                '%s failure (exit status %s), output: <pre>%s</pre>',
                $istar ? 'Tar' : 'Zip', $? >> 8 || -1, $err);
    }
  }

  # Clean up.
  rmtree($tmpexportdir);

  &fatal(@fatal) if @fatal;

  exit;
}

##############################
# View a directory
###############################
if (-d $fullname) {

  my $dh = do { local (*DH); };
  opendir($dh, $fullname) or fatal("404 Not Found", '%s: %s', $where, $!);
  my @dir = grep(!forbidden(catfile($fullname, $_)), readdir($dh));
  closedir($dh);
  my @subLevelFiles = findLastModifiedSubdirs(@dir) if $show_subdir_lastmod;
  my @unreadable = getDirLogs($cvsroot, $where, @subLevelFiles);

  if ($where eq '/') {
    html_header($defaulttitle);
    $long_intro =~ s/!!CVSROOTdescr!!/$CVSROOTdescr{$cvstree}/g;
    print $long_intro;
  } else {
    html_header($where);
    my $html = (-f catfile($fullname, 'README.cvs.html,v') ||
                -f catfile($fullname, 'Attic', 'README.cvs.html,v'));
    my $text = (!$html &&
                (-f catfile($fullname, 'README.cvs,v') ||
                 -f catfile($fullname, 'Attic', 'README.cvs,v')));
    if ($html || $text) {
      my $rev = $input{only_with_tag} || 'HEAD';
      my $cr = abs_path($cvsroot) || $cvsroot;
      my $co = "$where/README.cvs.html" if $html;
      $co ||= "$where/README.cvs" if $text;
      # abs_path() taints when run as a CGI...
      if ($cr =~ VALID_PATH) {
        $cr = $1;
      } else {
        fatal('500 Internal Error', 'Illegal CVS root: <code>%s</code>', $cr);
      }
      my @cmd = ($CMD{cvs}, @cvs_options, '-d', $cr, 'co', '-p', "-r$rev",$co);
      local (*CVS_OUT, *CVS_ERR);
      my ($h, $err) = startproc(\@cmd, \"", '>pipe', \*CVS_OUT,
                                '2>pipe', \*CVS_ERR);
      fatal('500 Internal Error', $err) unless $h;
      if ($html) {
        local $/ = undef;
        print <CVS_OUT>;
      } else {
        print "<p>\n";
        while (<CVS_OUT>) {
          chomp;
          print htmlquote($_), '<br />';
        }
        print "</p>";
      }
      $h->finish();
    }
    print $short_instruction;
  }

  if ($use_descriptions &&
      open(DESC, catfile($cvsroot, 'CVSROOT', 'descriptions'))) {
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
    chooseMirror();
    chooseCVSRoot();

  } else {
    print '<p>Current directory: <b>', clickablePath($where, 0), '</b>';
    if ($cvshistory_url) {
      (my $d = $where) =~ s|^/*(.*?)/*$|$1|;
      print ' - ', history_link($d, '');
    }
    print "</p>\n";
    print "<p>Current tag: <b>", htmlquote($input{only_with_tag}), "</b></p>\n"
      if $input{only_with_tag};
  }

  print "<hr />\n";

  my $infocols = 1;

  printf(<<EOF, 'Directory index of ' . htmlquote($where));
<table class="dir" width="100%%" cellspacing="0" cellpadding="$tablepadding" summary="%s">
<tr>
EOF
  printf('<th colspan="2"%s>', ($byfile ? ' class="sorted"' : ''));

  if ($byfile) {
    print 'File';
  } else {
    print &link('File',
                sprintf('./%s#dirlist', toggleQuery('sortby', 'file')));
  }
  print "</th>\n";

  # Do not display the other column headers if we do not have any files
  # with revision information.
  if (scalar(%fileinfo)) {
    $infocols++;
    printf('<th%s>', ($byrev ? ' class="sorted"' : ''));

    if ($byrev) {
      print 'Rev.';
    } else {
      print &link('Rev.',
                  sprintf('./%s#dirlist', toggleQuery('sortby', 'rev')));
    }
    print "</th>\n";
    $infocols++;
    printf('<th%s>', ($bydate ? ' class="sorted"' : ''));

    if ($bydate) {
      print 'Age';
    } else {
      print &link('Age',
                  sprintf('./%s#dirlist', toggleQuery('sortby', 'date')));
    }
    print "</th>\n";

    if ($show_author) {
      $infocols++;
      printf('<th%s>', ($byauthor ? ' class="sorted"' : ''));

      if ($byauthor) {
        print 'Author';
      } else {
        print
          &link('Author',
                sprintf('./%s#dirlist', toggleQuery('sortby', 'author')));
      }
      print "</th>\n";
    }
    $infocols++;
    printf('<th%s>', ($bylog ? ' class="sorted"' : ''));

    if ($bylog) {
      print 'Last log entry';
    } else {
      print &link('Last log entry',
                  sprintf('./%s#dirlist', toggleQuery('sortby', 'log')));
    }
    print "</th>\n";
  } elsif ($use_descriptions) {
    print "<th>Description</th>\n";
    $infocols++;
  }
  print "</tr>\n";

  my $dirrow = 0;

  my $i;
  lookingforattic:
  for ($i = 0; $i <= $#dir; $i++) {
    if ($dir[$i] eq "Attic") {
      last lookingforattic;
    }
  }

  if (!$input{hideattic}
      && ($i <= $#dir)
      && opendir($dh, $fullname . '/Attic'))
  {
    splice(@dir, $i, 1, grep((s|^|Attic/|, !m|/\.|), readdir($dh)));
    closedir($dh);
  }

  my $hideAtticToggleLink =
    $input{hideattic}
    ? ''
    : &link('[hide]', sprintf('./%s#dirlist', &toggleQuery('hideattic')));

  # Sort without the Attic/ pathname.
  # place directories first

  my $filesexists;
  my $filesfound;

  foreach my $file (sort { &fileSortCmp } @dir) {

    next if ($file eq curdir());

    # ignore CVS lock and stale NFS files
    next if ($file =~ /^\#cvs\.|^,|^\.nfs/); # \# for XEmacs cperl-mode...

    # Check whether to show the CVSROOT path
    next if ($input{hidecvsroot} && $where eq '/' && $file eq 'CVSROOT');

    # Is it a directory?
    my $isdir = -d catdir($fullname, $file);

    # Ignore non-readable files and directories?
    next if ($input{hidenonreadable} && (! -r _ || ($isdir && ! -x _)));

    my $attic = '';
    if ($file =~ s|^Attic/||) {
      $attic = ' <span class="attic">(in the Attic) ' .
        $hideAtticToggleLink . '</span>';
    }

    if ($file eq updir() || $isdir) {
      next if ($file eq updir() && $where eq '/');
      my ($rev, $date, $log, $author, $filename, $keywordsubst) =
        @{$fileinfo{$file}} if (defined($fileinfo{$file}));
      printf "<tr class=\"%s\">\n<td class=\"dir\" colspan=\"2\">",
        ($dirrow % 2) ? 'even' : 'odd';

      if ($file eq updir()) {
        my $url = "../$query";
        print $nofilelinks ? $backicon : &link($backicon, $url);
        print '&nbsp;', &link("Parent Directory", $url);

      } else {
        my $url = './' . uri_escape_path($file) . "/$query";
        print '<a name="', htmlquote($file), '"></a>';
        print $nofilelinks ? $diricon : &link($diricon, $url);
        print '&nbsp;', &link(htmlquote("$file/"), $url), $attic;
        if ($file eq "Attic") {
          print ' <span class="attic">',
            &link('[show]',
                  sprintf('./%s#dirlist', &toggleQuery('hideattic'))),
                    '</span>';
        }
      }

      # Show last change in dir
      if ($filename) {
        print "</td>\n<td>&nbsp;</td>\n<td class=\"age\">";
        print readableTime(time() - $date, 0) if $date;
        print "</td>\n<td class=\"author\">", htmlquote($author)
          if $show_author;
        print "</td>\n<td class=\"log\">";
        $filename =~ s%^[^/]+/%%;
        print &link(htmlquote("$filename/$rev"),
                    sprintf('%s/%s%s#rev%s',
                            uri_escape($file), uri_escape($filename),
                            $query, $rev)), '<br />';
        if ($log) {
          print htmlify(substr($log, 0, $shortLogLen), $allow_dir_extra);
          print '...' if (length($log) > 80);
        }

      } else {
        my $dwhere = ($where ne '/' ? $where : '') . $file;

        if ($use_descriptions && defined $descriptions{$dwhere}) {
          print '<td colspan="', ($infocols - 1), '">';
          print $descriptions{$dwhere};

        } elsif ($infocols > 1) {

          # close the row with the appropriate number of
          # columns, so that the vertical seperators are visible
          my ($cols) = $infocols;
          while ($cols > 1) {
            print "</td>\n<td>&nbsp;";
            $cols--;
          }
        }
      }

      print "</td>\n</tr>\n";
      $dirrow++;

    } elsif ($file =~ s/,v$//) {

      my $fileurl = ($attic ? 'Attic/' : '') . uri_escape_path($file);
      my $url     = './' . $fileurl . $query;
      $filesexists++;
      next if (!defined($fileinfo{$file}));
      my ($rev, $date, $log, $author, $filename, $keywordsubst) =
        @{$fileinfo{$file}};
      my $isbinary = $keywordsubst eq 'b' ? 1 : 0;
      $filesfound++;

      printf "<tr class=\"%s\">\n", ($dirrow % 2) ? 'even' : 'odd';
      printf '<td class="file"%s>', $allow_cvsgraph ? '' : ' colspan="2"';

      my $icon = $isbinary ? $binfileicon : $fileicon;
      print $nofilelinks ? $icon : &link($icon, $url);
      print '&nbsp;', &link(htmlquote($file), $url), $attic;
      print '</td><td class="graph">', graph_link($fileurl) if $allow_cvsgraph;
      print "</td>\n<td width=\"30\">", display_link($fileurl, $rev);
      print "</td>\n<td class=\"age\">";
      print readableTime(time() - $date, 0) if $date;
      print "</td>\n<td class=\"author\">", htmlquote($author) if $show_author;
      print "</td>\n<td class=\"log\">";

      if ($log) {
        print htmlify(substr($log, 0, $shortLogLen), $allow_dir_extra);
        print '...' if (length $log > 80);
      }
      print "</td>\n</tr>";
      $dirrow++;
    }
    print "\n";
  }

  print "</table>\n";

  if ((my $num = scalar(@unreadable)) && ! $input{hidenonreadable}) {
    printf(<<EOF, $num, htmlquote(join(', ', @unreadable)));
<p>
 <b>NOTE:</b> The following %d unreadable files were ignored:<br />
 <em>%s</em>
</p>
EOF
  }

  if ($filesexists && !$filesfound) {
    my $currtag = defined($input{only_with_tag}) ?
      sprintf(' (%s)', htmlquote($input{only_with_tag})) : '';
    printf(<<EOF, $filesexists, $currtag);
<p>
 <b>NOTE:</b> There are %d files, but none matches the current tag%s.
</p>
EOF
  }

  if ($input{only_with_tag} && (!%tags || !$tags{$input{only_with_tag}})) {
    %tags = %alltags;
  }

  if (scalar %tags
      || $input{only_with_tag}
      || $edit_option_form
      || defined($input{options}))
  {
    print "<hr />\n";
  }

  if (scalar %tags || $input{only_with_tag}) {
    print "<form method=\"get\" action=\"./\">\n<p>\n";
    foreach my $var (@stickyvars) {
      printf("<input type=\"hidden\" name=\"$var\" value=\"%s\" />\n",
             htmlquote($input{$var}))
        if (defined($input{$var})
            && (!defined($DEFAULTVALUE{$var})
                || $input{$var} ne $DEFAULTVALUE{$var})
            && $var ne 'only_with_tag');
    }
    printf(<<EOF, ($use_java_script ? ' onchange="this.form.submit()"' : ''));
<span class="nowrap">
<label for="only_with_tag" accesskey="T">Show only files with tag:
<select id="only_with_tag" name="only_with_tag"%s>
<option value="">All tags / default branch</option>
EOF
    foreach my $tag (reverse sort { lc $a cmp lc $b } keys %tags) {
      my $selected =
        defined($input{only_with_tag}) && $input{only_with_tag} eq $tag;
      printf("<option%s>%s</option>\n",
             $selected ? ' selected="selected"' : '',
             htmlquote($tag));
    }
    printf(<<EOF, htmlquote($where));
</select>
</label></span> <span class="nowrap">
<label for="path" accesskey="P">Module path or alias:
<input type="text" id="path" name="path" value="%s" size="15" /></label>
</span>
<input type="submit" value="Go" accesskey="G" />
</p>
</form>
EOF
  }

  if ($allow_tar && $filesfound) {
    my ($basefile) = ($where =~ m,(?:.*/)?([^/]+),);
    my $havetar = $CMD{tar} && $CMD{gzip};
    my $havezip = $CMD{zip};
    if (defined($basefile) && $basefile ne '' && ($havetar || $havezip)) {
      my $q = ($query ? "$query;" : '?') . 'tarball=1';
      print "<hr />\n",
        '<div style="text-align: center">Download this directory in ';
      # Mangle the filename so browsers show a reasonable filename to download.
      my @types = ();
      $basefile = uri_escape($basefile);
      push(@types, &link('tarball', "$basefile.tar.gz$q")) if $havetar;
      push(@types, &link('zip archive', "$basefile.zip$q")) if $havezip;
      print join(' or ', @types), "</div>\n";
    }
  }

  if ($edit_option_form || defined($input{options})) {

    print <<EOF;
<form method="get" action="./">
<fieldset>
<legend>General options</legend>
<input type="hidden" name="copt" value="1" />
EOF
    for my $v qw(hidecvsroot hidenonreadable) {
      printf(qq{<input type="hidden" name="%s" value="%s" />\n},
             $v, $input{$v} || 0);
    }
    if ($cvstree ne $cvstreedefault) {
      print "<input type=\"hidden\" name=\"cvsroot\" value=\"$cvstree\" />\n";
    }
    print <<EOF;
<table summary="General options">
<tr>
<td class="opt-label">
<label for="sortby" accesskey="F">Sort files by:</label>
</td>
<td class="opt-value">
<select id="sortby" name="sortby">
<option value="">File</option>
EOF
    print "<option", $bydate ? ' selected="selected"' : '',
      " value=\"date\">Age</option>\n";
    print "<option", $byauthor ? ' selected="selected"' : '',
      " value=\"author\">Author</option>\n"
        if $show_author;
    print "<option", $byrev ? ' selected="selected"' : '',
      " value=\"rev\">Revision</option>\n";
    print "<option", $bylog ? ' selected="selected"' : '',
      " value=\"log\">Log message</option>\n";
    print <<EOF;
</select>,
<label for="ignorecase" accesskey="I">case-insensitive:
EOF
    print '<input id="ignorecase" name="ignorecase" type="checkbox"',
      $input{ignorecase} ? ' checked="checked"' : '',
        " value=\"1\" /></label>\n";
    print <<EOF;
</td>
<td class="opt-label">
<label for="hideattic" accesskey="A">Hide files in Attic:</label>
</td>
<td class="opt-value">
EOF
    print '<input id="hideattic" name="hideattic" type="checkbox"',
      $input{hideattic} ? ' checked="checked"' : '', ' value="1" />';
    print <<EOF;
</td>
</tr>
<tr>
<td class="opt-label">
<label for="logsort" accesskey="L">Sort log by:</label>
</td>
<td class="opt-value">
EOF
    printLogSortSelect(0);
    print <<EOF;
</td>
<td class="opt-label">
<label for="ln" accesskey="N">Show line numbers:</label>
</td>
<td class="opt-value">
EOF
    print '<input id="ln" name="ln" type="checkbox"',
      $input{ln} ? ' checked="checked"' : '', " value=\"1\" />\n";
    print <<EOF;
</td>
</tr>
<tr>
<td class="opt-label">
<label for="f" accesskey="D">Diff format:</label>
</td>
<td>
EOF
    printDiffSelect(0);
    print <<EOF;
</td>
<td colspan="2" class="opt-label">
<input type="submit" value="Change Options" accesskey="C" />
</td>
</tr>
</table>
</fieldset>
</form>
EOF
  }
  html_footer();
}

###############################
# View Files
###############################
elsif (-f $fullname . ',v') {

  if (defined($input{rev}) || $doCheckout) {
    &doCheckout($fullname, $input{rev}, $input{only_with_tag});
    gzipclose();
    exit;
  }

  if (defined($input{annotate}) && $allow_annotate) {
    &doAnnotate($input{annotate}, $input{only_with_tag});
    gzipclose();
    exit;
  }

  if (defined($input{r1}) && defined($input{r2})) {
    &doDiff($fullname,  $input{r1},  $input{tr1},
            $input{r2}, $input{tr2}, $input{f});
    gzipclose();
    exit;
  }

  if ($allow_cvsgraph && $input{graph}) {
    if ($input{makeimage}) {
      doGraph();
    } else {
      doGraphView();
    }
    gzipclose();
    exit;
  }

  &doLog($fullname);
}

##############################
# View Diff
##############################
elsif ($fullname =~ s/\.diff$//
       && -f $fullname . ',v' && $input{r1} && $input{r2})
{

  # $where-diff-removal if 'cvs rdiff' is used
  # .. but 'cvs rdiff'doesn't support some options
  # rcsdiff does (-w and -p), so it is disabled
  # $where =~ s/\.diff$//;

  # Allow diffs using the ".diff" extension so that browsers that default
  # to the filename in the URL when saving don't save diffs as eg. foo.c.
  &doDiff($fullname,  $input{r1},  $input{tr1},
          $input{r2}, $input{tr2}, $input{f});
  gzipclose();
  exit;

}

elsif (do { (my $tmp = $fullname) =~ s|/([^/]+)$|/Attic/$1|; -f "$tmp,v" }) {
  # The file has been removed and is in the Attic.
  # Send a redirect pointing to the file in the Attic.
  (my $newplace = $scriptwhere) =~ s|/([^/]+)$|/Attic/$1|;
  if ($ENV{QUERY_STRING} ne "") {
    redirect("$newplace?$ENV{QUERY_STRING}");
  } else {
    redirect($newplace);
  }
  exit;

}

elsif (0 && (my @files = &safeglob($fullname . ",v"))) {
  http_header("text/plain");
  print "You matched the following files:\n";
  print join ("\n", @files);

  # TODO:
  # Find the tags from each file
  # Display a form offering diffs between said tags
}

else {
  # Assume it's a module name with a potential path following it.
  my $module;
  my $xtra = (($module = $where) =~ s|(/.*)||) ? $1 : '';

  # Is there an indexed version of modules?
  my $fh = do { local (*FH); };
  if (open($fh, catfile($cvsroot, 'CVSROOT', 'modules'))) {
    while (<$fh>) {
      if (/^(\S+)\s+(\S+)/o
          && $module eq $1
          && $module ne $2
          && -d "$cvsroot/$2")
      {
        close($fh);
        redirect("$scriptname/$2$xtra$query");
      }
    }
    close($fh);
  }
  fatal("404 Not Found", '%s: no such file or directory', $where);
}

gzipclose();

## End MAIN


sub printDiffSelect($)
{
  my ($use_java_script) = @_;

  print '<select id="f" name="f"';
  print ' onchange="this.form.submit()"' if $use_java_script;
  print ">\n";

  for my $difftype (@DIFFTYPES) {
    printf("<option value=\"%s\"%s>%s</option>\n",
           $difftype, $input{f} eq $difftype ? ' selected="selected"' : '',
           "\u$DIFFTYPES{$difftype}{descr}");
  }

  print "</select>";
}


sub printDiffSelectStickyVars()
{
  while (my ($key, $val) = each %input) {
    next if ($key eq 'f');
    next if (defined($DEFAULTVALUE{$key}) && $DEFAULTVALUE{$key} eq $val);
    print "<input type=\"hidden\" name=\"", htmlquote($key), "\" value=\"",
      htmlquote($val), "\" />\n";
  }
}


sub printLogSortSelect($)
{
  my ($use_java_script) = @_;

  print '<select id="logsort" name="logsort"';
  print ' onchange="this.form.submit()"' if $use_java_script;
  print ">\n";

  for my $sortkey (@LOGSORTKEYS) {
    printf("<option value=\"%s\"%s>%s</option>\n",
           $sortkey, $logsort eq $sortkey ? ' selected="selected"' : '',
           "\u$LOGSORTKEYS{$sortkey}{descr}");
  }

  print "</select>";
}


#
# Find the last modified, version controlled files in the given directories.
# Compares solely based on modification timestamps.  Files in the returned list
# are without the ,v suffix, and unreadable files have been filtered out.
#
sub findLastModifiedSubdirs(@)
{
  my (@dirs) = @_;

  my @files;
  foreach my $dirname (@dirs) {
    next if ($dirname eq curdir() || $dirname eq updir());
    my $dir = catdir($fullname, $dirname);
    next if (!-d $dir);

    my $dh = do { local (*DH); };
    opendir($dh, $dir) or next;
    my (@filenames) = grep(!forbidden(catfile($dir, $_)), readdir($dh));
    closedir($dh);

    my $lastmod     = undef;
    my $lastmodtime = undef;
    foreach my $filename (@filenames) {
      ($filename) =
        (catfile($dirname, $filename) =~ VALID_PATH) or next; # untaint
      my ($file) = catfile($fullname, $filename);
      next if ($filename !~ /,v$/o || !-f $file || !-r _);
      my $modtime = -M _;
      if (!defined($lastmod) || $modtime < $lastmodtime) {
        ($lastmod    = $filename) =~ s/,v$//;
        $lastmodtime = $modtime;
      }
    }
    push(@files, $lastmod) if (defined($lastmod));
  }
  return @files;
}


sub htmlify_sub(&$)
{
  (my $proc, local $_) = @_;
  my @a = split(m|(<a [^>]+>[^<]*</a>)|i);
  my $linked;
  my $result = '';

  while (($_, $linked) = splice(@a, 0, 2)) {
    &$proc();
    $result .= $_      if defined($_);
    $result .= $linked if defined($linked);
  }

  return $result;
}


sub htmlify($;$)
{
  (local $_, my $extra) = @_;

  $_ = htmlquote($_);

  # get URL's as link
  s{
    ((https?|ftp)://.+?)([\s\']|&(quot|[lg]t);)
   }{
     &link($1, htmlunquote($1)) . $3
   }egx;

  if ($allow_mailtos) {
    # Make mailto: links from email addresses.
    $_ = htmlify_sub {
      s<
        ([\w+=\-.!]+@[\w\-]+(?:\.[\w\-]+)+)
       ><
         &link($1, "mailto:$1")
       >egix;
    } $_;
  }

  if ($extra) {

    # get PR #'s as link: "PR#nnnn" "PR: nnnn, ..." "PR nnnn, ..." "bin/nnnn"
    if (defined($prcgi) && defined($re_prkeyword)) {
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

      if (defined($re_prcategories)) {
        $_ = htmlify_sub {
          s{
            (\b$re_prcategories/(\d+)\b)
           }{
             &link($1, sprintf($prcgi, $2))
           }egox;
        } $_;
      }
    }

    # get manpage specs as link: "foo.1" "foo(1)"
    if (defined($mancgi)) {
      $_ = htmlify_sub {
        s{
          (
           \b ( \w[\w+\-.]* (?: ::\w[\w+\-.]*)* )
           (?:
            \( ([0-9n]) \) \B
            |
            \. ([0-9n]) \b
           )
          )
         }{
            my($text, $name, $section) = ($1, $2, defined($3) ? $3 : $4);
            ($name =~ /[A-Za-z]/ && $name !~ /\.(:|$)/)
             ? &link($text, sprintf($mancgi, $section, uri_escape($name)))
              : $text;
         }egx;
      } $_;
    }
  }

  return $_;
}


sub spacedHtmlText($;$)
{
  (local $_, my $ts) = @_;
  return '' unless defined($_);
  $ts ||= $tabstop || 8;

  # Expand tabs
  1 while s/(.*?)(\t+)/$1 . ' ' x (length($2) * $ts - length($1) % $ts)/e;

  if ($hr_breakable) {
    s/^ /\001nbsp;/;      # protect leading and...
    s/ $/\001nbsp;/;      # ...trailing whitespace (mostly for String::Ediff),
    s/  / \001nbsp;/g;    # ...and leave every other space 'breakable'
  } else {
    s/ /\001nbsp;/g;
  }

  $_ = htmlify($_, $allow_source_extra);

  # unescape
  y/\001/&/;

  return $_;
}


# Note that this doesn't htmlquote the first argument...
sub link($$)
{
  my ($name, $url) = @_;
  return sprintf('<a href="%s">%s</a>', htmlquote($url), $name);
}


sub revcmp($$)
{
  my ($rev1, $rev2) = @_;

  # make no comparison for a tag or a branch
  return 0 if $rev1 =~ /[^\d.]/ || $rev2 =~ /[^\d.]/;

  my (@r1) = split(/\./, $rev1);
  my (@r2) = split(/\./, $rev2);
  my ($a, $b);

  while (($a = shift(@r1)) && ($b = shift(@r2))) {
    return $a <=> $b unless ($a == $b);
  }
  if (@r1) { return  1; }
  if (@r2) { return -1; }
  return 0;
}


#
# Signal a fatal error.
#
sub fatal($$@)
{
  my ($errcode, $format, @args) = @_;
  print "Status: $errcode\r\n";
  html_header('Error');
  print '<div id="error">Error: ',
    sprintf($format, map(htmlquote($_), @args)), "</div>\n";
  html_footer();
  exit(1);
}


#
# Signal a (fatal) configuration error.
#
sub config_error($$)
{
  fatal('500 Internal Error',
        'Error loading configuration file "<code>%s</code>":<br /><br />' .
        '%s<br />', @_);
}


#
# Sends a redirect to the given URL.
#
sub redirect($;$)
{
  my ($url, $permanent) = @_;
  my ($status, $text);
  if ($permanent) {
    $status = '301';
    $text   = 'Moved Permanently';
  } else {
    $status = '302';
    $text   = 'Found';
  }
  print "Status: $status $text\r\n", "Location: $url\r\n";
  html_header($text);
  print "<p>This document has moved ", &link('here', $url), ".</p>\n";
  html_footer();
  exit(1);
}


sub safeglob($)
{
  my ($filename) = @_;

  (my $dirname = $filename) =~ s|/[^/]+$||;
  $filename =~ s|.*/||;

  my @results;
  my $dh = do { local (*DH); };
  if (opendir($dh, $dirname)) {
    my $glob = $filename;
    my $t;

    #   transform filename from glob to regex.  Deal with:
    #   [, {, ?, * as glob chars
    #   make sure to escape all other regex chars
    $glob =~ s/([\.\(\)\|\+])/\\$1/g;
    $glob =~ s/\*/.*/g;
    $glob =~ s/\?/./g;
    $glob =~ s/{([^}]+)}/($t = $1) =~ s-,-|-g; "($t)"/eg;
    $glob = qr/^$glob$/;

    foreach (readdir($dh)) {
      if ($_ =~ $glob && $_ =~ VALID_PATH) {
        push(@results, catfile($dirname, $1)); # untaint
      }
    }
    closedir($dh);
  }

  return @results;
}


#
# Searches @command_path for the given executable file.
#
sub search_path($)
{
  my ($command) = @_;
  for my $d (@command_path) {
    my $cmd = catfile($d, $command);
    return $cmd if (-x $cmd && !-d _);
  }
  return '';
}


#
# Gets the enscript(1) highlight mode corresponding to the given filename,
# or undef if unsupported.
#
sub getEnscriptHL($)
{
  return undef unless $allow_enscript;
  my ($filename) = @_;
  while (my ($hl, $regex) = each %enscript_types) {
    return $hl if ($filename =~ $regex);
  }
  return undef;
}


#
# Gets the MIME type for the given file name.
#
sub getMimeType($;$)
{
  my ($fullname, $binary) = @_;
  $binary = ($keywordsubstitution && $keywordsubstitution =~ /b/)
    unless defined($binary);

  (my $suffix = $fullname) =~ s/^.*\.([^.]*)$/$1/;

  my $mimetype = $MTYPES{$suffix};
  $mimetype  ||= $MimeTypes->mimeTypeOf($fullname) if defined($MimeTypes);

  if (!$mimetype && $suffix ne '*' && -f $mime_types && -r _) {
    my $fh = do { local (*FH); };
    if (open($fh, $mime_types)) {
      my $re = sprintf('^\s*(\S+\/\S+)\s.+\b%s\b', quotemeta($suffix));
      $re = qr/$re/;
      while (my $line = <$fh>) {
        if ($line =~ $re) {
          $mimetype = $1;
          $MTYPES{$suffix} = $mimetype;
          last;
        }
      }
      close($fh);
    } else {
      warn("Can't open MIME types file $mime_types for reading: $!");
    }
  }

  $mimetype ||= $MTYPES{'*'};
  $mimetype ||= $binary ? 'application/octet-stream' : 'text/plain';
  return $mimetype;
}


###############################
# read first lines like head(1)
###############################
sub head($;$)
{
  my ($fh, $linecount) = @_;
  $linecount ||= 10;

  my @buf;
  if ($linecount > 0) {
    for (my $i = 0; !eof($fh) && $i < $linecount; $i++) {
      push @buf, scalar <$fh>;
    }
  } else {
    @buf = <$fh>;
  }
  return @buf;
}


###############################
# scan vim and Emacs directives
###############################
sub scan_directives(@)
{
  my $ts = undef;

  for (@_) {
    $ts = $1 if /\b(?:ts|tabstop|tab-width)[:=]\s*([1-9]\d*)\b/;
  }

  ('tabstop' => $ts);
}


sub openOutputFilter()
{
  return unless $output_filter;

  open(STDOUT, "|-") and return;

  # child of child
  open(STDERR, '>', devnull()) unless $DEBUG;
  exec($output_filter) or exit -1;
}


###############################
# show Annotation
###############################
sub doAnnotate($$)
{
  my ($rev, $tag) = @_;
  $rev = $tag || 'HEAD' if ($rev eq '.');
  (my $pathname = $where) =~ s|((?<=/)Attic/)?[^/]*$||;
  (my $filename = $where) =~ s|^.*/||;

  # This annotate version is based on the cvs annotate-demo Perl script by
  # Cyclic Software.  It was written by Cyclic Software,
  # http://www.cyclic.com/, and is in the public domain.
  # We could abandon the use of rlog, rcsdiff and co using
  # the cvs server in a similiar way one day (..after rewrite).

  local (*CVS_IN, *CVS_OUT);
  my $annotate_err;
  my ($h, $err) =
    startproc([ $CMD{cvs}, @annotate_options, 'server' ],
              '<pipe', \*CVS_IN, '>pipe', \*CVS_OUT,
              '2>', \$annotate_err);
  fatal('500 Internal Error',
        'Annotate failure (exit status %s), output: <pre>%s</pre>',
        $? >> 8 || -1, $err)
    unless $h;

  # OK, first send the request to the server.  A simplified example is:
  #     Root /home/kingdon/zwork/cvsroot
  #     Argument foo/xx
  #     Directory foo
  #     /home/kingdon/zwork/cvsroot/foo
  #     Directory .
  #     /home/kingdon/zwork/cvsroot
  #     annotate
  # although as you can see there are a few more details.

  print CVS_IN "Root $cvsroot\n";
  print CVS_IN
    "Valid-responses ok error Valid-requests Checked-in Updated Merged Removed M E\n";

  # Don't worry about sending valid-requests, the server just needs to
  # support "annotate" and if it doesn't, there isn't anything to be done.
  print CVS_IN "UseUnchanged\n";
  print CVS_IN "Argument -r\n";
  print CVS_IN "Argument $rev\n";
  print CVS_IN "Argument $where\n";

  # The protocol requires us to fully fake a working directory (at
  # least to the point of including the directories down to the one
  # containing the file in question).
  # So if $where is "dir/sdir/file", then dirs will be ("dir","sdir","file")
  my $path = '';
  foreach my $dir (split('/', $where)) {

    if ($path eq "") {
      # In our example, $dir is "dir".
      $path = $dir;
    } else {
      print CVS_IN "Directory $path\n";
      print CVS_IN "$cvsroot/$path\n";

      # In our example, $_ is "sdir" and $path becomes "dir/sdir"
      # And the next time, "file" and "dir/sdir/file" (which then gets
      # ignored, because we don't need to send Directory for the file).
      $path .= "/$dir";
    }
  }
  undef $path;

  # And the last "Directory" before "annotate" is the top level.
  print CVS_IN "Directory .\n";
  print CVS_IN "$cvsroot\n";

  print CVS_IN "annotate\n";

  # OK, we've sent our command to the server.  Thing to do is to
  # close the writer side and get all the responses.
  if (!close(CVS_IN)) {
    $h->finish();
    fatal('500 Internal Error',
          'Annotate failure (exit status %s): <code>%s</code>, output: ' .
          '<pre>%s</pre>', $? >> 8, $!, $annotate_err);
  }

  navigateHeader($scriptwhere, $pathname, $filename, $rev, 'annotate');

  my $revtype = ($rev =~ /\./) ? 'revision' : 'tag'; # TODO: tag -> branch/tag?
  print '<h3 style="text-align: center">Annotation of ',
    htmlquote("$pathname$filename"), ", $revtype $rev</h3>\n";

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
    print <<EOF;
<table style="border: none" cellspacing="0" cellpadding="0" summary="Annotation">
EOF
  } else {
    print "<pre>";
  }

  # prefetch several lines
  my @buf = head(*CVS_OUT);

  my %d = scan_directives(@buf);

  while (@buf || !eof(*CVS_OUT)) {

    $_ = @buf ? shift @buf : <CVS_OUT>;
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
      # TODO: this does not work for branch/tag revisions.
      my $isCurrentRev = ($rev eq $lrev);

      # we should parse the date here ..
      if ($lrev eq $oldLrev) {
        $revprint = sprintf('%-8s', '');
      } else {
        $revprint = sprintf('%-8s', $lrev);
        $revprint =~ s|(\S+)|&link($1, uri_escape($filename)."$query#rev$1")|e;
        $oldLusr = '';
      }

      $usrprint = ($lusr eq $oldLusr) ? '' : $lusr;
      $oldLrev = $lrev;
      $oldLusr = $lusr;

      print $is_textbased ? '<b>' : '<span class="current-rev">'
        if $isCurrentRev;

      $usrprint = sprintf('%-8s', $usrprint);
      printf '%s%s %s %4d:', $revprint, $isCurrentRev ? '!' : ' ',
        htmlquote($usrprint), $lineNr;
      print spacedHtmlText($line, $d{tabstop});

      print $is_textbased ? '</b>' : '</span>' if $isCurrentRev;

    } elsif ($words[0] eq "ok") {
      # We could complain about any text received after this, like the
      # CVS command line client.  But for simplicity, we don't.

    } elsif ($words[0] eq "error") {
      fatal("500 Internal Error",
            'Error occured during annotate: <b>%s</b>', $_);
    }
  }
  $h->finish();

  if ($annTable) {
    print "</table>";
  } else {
    print "</pre>";
  }
  html_footer();
}

###############################
# make Checkout
###############################
sub doCheckout($$$)
{
  my ($fullname, $rev, $tag) = @_;
  $rev = $tag || undef if (!$rev || $rev eq '.');

  # Start resolving whether we will do a markup view or not.
  my $do_markup = undef;
  my $want_type = $input{'content-type'};

  # No markup if markup disallowed.
  $do_markup = 0 unless $allow_markup;

  # No markup if checkout magic cookie in URL.
  $do_markup = 0 if (!defined($do_markup) && $doCheckout);

  # Do markup if explicitly asked using cvsweb-markup content type.  If the
  # asked content type is anything else, no markup.
  if (!defined($do_markup) && $want_type) {
    if ($want_type =~ CVSWEBMARKUP) {
      $want_type = undef;
      $do_markup = 1;
    } else {
      $do_markup = 0;
    }
  }

  # Ok, if $do_markup is still undefined, we know that a download has not been
  # explicitly asked.  For the last check further down below we'll need to
  # know if the file is binary, and possibly run a log on it.
  my $needlog = $do_markup || $use_moddate;

  my $moddate = undef;
  my $revopt;
  if (defined($rev)) {
    $revopt = "-r$rev";
    if ($needlog) {
      readLog($fullname, $rev);
      $moddate   = $date{$rev};
      # TODO: even this does not work for branch tags, but only normal tags :(
      $moddate ||= $date{$symrev{$rev}} if defined($symrev{$rev});
    }
  } else {
    $revopt = "-rHEAD";
    if ($needlog) {
      readLog($fullname);
      $moddate = $date{$symrev{HEAD}};
    }
  }

  my $cr = abs_path($cvsroot) || $cvsroot;
  # abs_path() taints when run as a CGI...
  if ($cr =~ VALID_PATH) {
    $cr = $1;
  } else {
    fatal('500 Internal Error', 'Illegal CVS root: <code>%s</code>', $cr);
  }
  # Use abs_path() to work around a bug of cvs -p; expand symlinks if we can.
  my @cmd = ($CMD{cvs}, @cvs_options, '-d', $cr, 'co', '-p', $revopt, $where);

  local (*CVS_OUT, *CVS_ERR);
  my ($h, $err) =
    startproc(\@cmd, \"", '>pipe', \*CVS_OUT, '2>pipe', \*CVS_ERR);
  fatal('500 Internal Error',
        'Checkout failure (exit status %s), output: <pre>%s</pre>',
        $? >> 8 || -1, $err)
    unless $h;

  if (eof(CVS_ERR)) {
    $h->finish();
    fatal("404 Not Found", '%s is not (any longer) pertinent', $where);
  }

  #===================================================================
  #Checking out squid/src/ftp.c
  #RCS:  /usr/src/CVS/squid/src/ftp.c,v
  #VERS: 1.1.1.28.6.2
  #***************

  # Parse CVS header
  my ($revision, $filename, $cvsheader);
  $filename = "";
  while (<CVS_ERR>) {
    last if (/^\*\*\*\*/);
    $revision = $1 if (/^VERS: (.*)$/);

    if (/^Checking out (.*)$/) {
      ($filename = $1) =~ s|^\./+||;
    }
    $cvsheader .= $_;
  }
  close(CVS_ERR);

  if ($filename ne $where) {
    $h->finish();
    fatal("500 Internal Error",
          'Unexpected output from cvs co: <pre>%s</pre> ' .
          '(expected "<code>%s</code>" but got "<code>%s</code>")',
          $cvsheader, $where, $filename);
  }

  # Last checks whether we'll do markup or not.
  my $isbin = $keywordsubstitution && $keywordsubstitution =~ /b/;
  my $mimetype = getMimeType($fullname, $isbin);

  # If we still are not sure whether to do markup or not:
  # if the MIME type is "viewable" or this is not a binary file, do.
  $do_markup = !$isbin || viewable($mimetype) unless defined($do_markup);

  if ($do_markup) {

    # If this is something we'll be linking to in the markup view, we are
    # done with this particular output from "cvs co" and must discard it.
    my $linked = $mimetype =~ m{^image/|application/pdf$}i;
    if ($linked) {
      close(CVS_OUT);
      $h->finish();
    }

    # Here we know the last modified date, but don't know if tags have been
    # added afterwards (those are shown in the markup view): no last-modified.
    cvswebMarkup(\*CVS_OUT, $fullname, $revision, $isbin, $mimetype, $needlog);

    $h->finish() unless $linked;

  } else {
    http_header($want_type || $mimetype, $moddate);
    local $/ = undef;
    print <CVS_OUT>;
    $h->finish();
  }
}


sub cvswebMarkup($$$$$$;$)
{
  my ($filehandle, $fullname, $rev, $isbin, $mimetype, $logged, $mod) = @_;

  (my $pathname = $where) =~ s|((?<=/)Attic/)?[^/]*$||;
  (my $filename = $where) =~ s|^.*/||;

  navigateHeader($scriptwhere, $pathname, $filename, $rev, 'view', $mod);

  print <<EOF;
<hr />
<div class="log-markup">
File:&nbsp;
EOF
  print &clickablePath($where, 1), "<br />\n";

  if ($show_log_in_markup) {
    readLog($fullname) unless $logged; #,$rev);
    printLog($rev, $mimetype, $isbin);
  } else {
    print "Revision: <b>$rev</b><br />\n";
    print 'Tag: ', htmlquote($input{only_with_tag}), "<br />\n"
      if $input{only_with_tag};
  }
  print "</div>\n<hr />";
  my $url = download_url(uri_escape($filename), $rev, $mimetype);

  if ($mimetype =~ m|^image/|i) {
    printf '<img src="%s" alt="%s" /><br />',
      $url . $barequery, htmlquote($filename);
  } elsif (lc($mimetype) eq 'application/pdf') {
    printf '<embed src="%s" width="100%%" height="100%%" /><br />',
      $url . $barequery;
  } else {

    print "<pre>\n";
    my $linenumbers = $input{ln} || 0;

    if (my $enscript_hl = getEnscriptHL($filename)) {
      doEnscript($filehandle, $enscript_hl, $linenumbers);

    } else {
      my $ln  = 0;
      my @buf = ();
      my $ts  = undef;

      if ($preformat_in_markup) {
        # prefetch several lines
        @buf = head($filehandle);
        my %d = scan_directives(@buf);
        $ts = $d{tabstop};
      }

      while (@buf || !eof($filehandle)) {
        $_ = @buf ? shift @buf : <$filehandle>;
        if ($linenumbers) {
          $ln++;
          printf '<a id="l%d" class="src">%5d: </a>', ($ln) x 2;
        }
        print $preformat_in_markup ? spacedHtmlText($_, $ts) : htmlquote($_);
      }
    }

    print "</pre>\n";
  }
  html_footer();
}


sub viewable($)
{
  return shift =~ m{^((text|image)/|application/pdf)}i;
}


###############################
# Show Colored Diff
###############################
sub doDiff($$$$$$)
{
  my ($fullname, $r1, $tr1, $r2, $tr2, $f) = @_;

  if (forbidden($fullname)) {
    fatal('403 Forbidden', 'Access to %s forbidden.', $where);
  }

  my ($rev1, $sym1);
  if ($r1 =~ /([^:]+)(:(.+))?/) {
    $rev1 = $1;
    $sym1 = $3;
  }
  if ($r1 eq 'text') {
    $rev1 = $tr1;
    $sym1 = "";
  }

  my ($rev2, $sym2);
  if ($r2 =~ /([^:]+)(:(.+))?/) {
    $rev2 = $1;
    $sym2 = $3;
  }
  if ($r2 eq 'text') {
    $rev2 = $tr2;
    $sym2 = "";
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

  my $mimetype = getMimeType($fullname);

  #
  #  Check for per-MIME type diff commands.
  #
  my $diffcmd = undef;
  if (my $diffcmds = $DIFF_COMMANDS{lc($mimetype)}) {
    if ($f =~ /^ext(\d*)$/) {
      my $n = $1 || 0;
      $diffcmd = $diffcmds->[$n];
    }
  }
  if ($diffcmd && $diffcmd->{cmd} && $diffcmd->{name}) {

    if ($diffcmd->{args} && ref($diffcmd->{args}) ne 'ARRAY') {
      fatal('500 Internal Error',
            'Configuration error: arguments to external diff tools must ' .
            'be given as array refs.  See "<code>%s</code>" in ' .
            '<code>%%DIFF_COMMANDS</code>.',
            $diffcmd->{name});
    }

    (my $cvsname = $where) =~ s/\.diff$//;

    # Create two temporary files with the two revisions
    my $temp_fn1 = checkout_to_temp($cvsroot, $cvsname, $rev1);
    my $temp_fn2 = checkout_to_temp($cvsroot, $cvsname, $rev2);

    # Execute chosen diff binary.
    local (*DIFF_OUT);
    my @cmd = ($diffcmd->{cmd});
    push(@cmd, @{$diffcmd->{args}}) if $diffcmd->{args};
    push(@cmd, $temp_fn1, $temp_fn2);
    my ($h, $err) = startproc(\@cmd, \"", '>pipe', \*DIFF_OUT);
    if (!$h) {
      unlink($temp_fn1);
      unlink($temp_fn2);
      fatal('500 Internal Error',
            'Diff failure (exit status %s), output: <pre>%s</pre>',
            $? >> 8 || -1, $err);
    }

    http_header($diffcmd->{type} || 'text/plain');
    local $/ = undef;
    print <DIFF_OUT>;
    $h->finish();
    unlink($temp_fn1);
    unlink($temp_fn2);

    exit;
  }

  #
  # Normal CVS diff.
  #

  $f = $DEFAULTVALUE{f} || 'u' if ($f =~ /^ext\d*$/);
  my $difftype = $DIFFTYPES{$f};
  if (!$difftype) {
    fatal("400 Bad arguments", 'Diff format %s not understood', $f);
  }

  my @difftype       = @{$difftype->{opts}};
  my $human_readable = $difftype->{colored};

  # Apply special diff options.  -p and -F are not available with side by side
  # diffs and may cause problems with older (< 2.8) versions of diffutils if
  # used with --side-by-side.
  if ($showfunc && $f !~ /^s/) {
    push(@difftype, '-p');
    while (my ($re1, $re2) = each %funcline_regexp) {
      if ($fullname =~ $re1) {
        push(@difftype, '-F', $re2);
        last;
      }
    }
  }

  if ($human_readable) {
    push(@difftype, '-w')  if $hr_ignwhite;
    push(@difftype, '-kk') if $hr_ignkeysubst;
  }

  my $fh = do { local (*FH); };
  if (!open($fh, "-|")) {    # child
    open(STDERR, ">&STDOUT");    # Redirect stderr to stdout
    openOutputFilter();
    exec($CMD{rcsdiff}, @rcsdiff_options, @difftype, "-r$rev1", "-r$rev2",
         $fullname) or exit -1;
  }

  if ($human_readable) {
    #
    # Human readable diff.
    #
    human_readable_diff($fh, $rev2);
    html_footer();
    gzipclose();
    exit;

  } elsif ($f =~ /^([ucs])c$/) {
    #
    # Enscript colored diff.
    #
    my $hl = 'diff';
    $hl .= $1 if ($1 eq 'u' || $1 eq 's');
    (my $where_nd = $where)       =~ s/\.diff$//;
    (my $pathname = $where_nd)    =~ s|((?<=/)Attic/)?[^/]*$||;
    (my $filename = $where_nd)    =~ s|^.*/||;
    (my $swhere   = $scriptwhere) =~ s|\.diff$||;
    navigateHeader($swhere, $pathname, $filename, $rev2, 'diff');
    printf(<<EOF, $where_nd, $rev1, $rev2);
<h3 style="text-align: center">Diff for /%s between versions %s and %s</h3>
<pre>
EOF
    doEnscript(\$fh, $hl, 0, 'cvsweb_diff');
    print <<EOF;
</pre>
<hr style="width: 100%" />
<form method="get" action="$scriptwhere">
EOF
    printDiffSelectStickyVars();
    print 'Diff format: ';
    printDiffSelect($use_java_script);
    print "<input type=\"submit\" value=\"Show\" />\n</form>\n";
    html_footer();
    gzipclose();
    exit;

  } else {
    #
    # Plain diff.
    #
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
  my ($f1, $f2);
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
sub getDirLogs($$@)
{
  my ($cvsroot, $dirname, @otherFiles) = @_;
  my $tag = $input{only_with_tag};
  my $DirName = catdir($cvsroot, $where);

  my @files = &safeglob("$DirName/*,v");
  push (@files, &safeglob("$DirName/Attic/*,v")) unless $input{hideattic};
  foreach my $file (@otherFiles) {
    push(@files, catfile($DirName, $file));
  }

  # Weed out unreadable files.
  my $i = 0;
  my @unreadable = ();
  while ($i < scalar(@files)) {
    # Note: last modified files from subdirs returned by
    # findLastModifiedSubdirs() come without the ,v suffix so they're not
    # found here, but have already been checked for readability.  *cough*
    if (-r $files[$i] || !-e _) {
      $i++;
    } else {
      push(@unreadable, splice(@files, $i, 1));
    }
  }

  # If there are no files, we're done.
  return @unreadable unless @files;

  my @cmd = ($CMD{rlog});
  # Can't use -r<tag> as '-' is allowed in tagnames,
  # but misinterpreted by rlog.
  push(@cmd, '-r') unless defined($tag);

  my $fh = do { local (*FH); };
  if (!open($fh, '-|')) {                       # Child
    open(STDERR, '>', devnull()) unless $DEBUG; # Ignore rlog's complaints.
    openOutputFilter();
    if ($file_list_len && $file_list_len > 1) {
      while (scalar(@files) > $file_list_len) {  # Process files in chunks.
        system(@cmd, splice(@files, 0, $file_list_len)) == 0 or exit -1;
      }
    }
    exec(@cmd, @files) or exit -1;
  }
  undef @cmd;

  my $state = 'start';
  my ($date, $branchpoint, $branch, $log, @filetags);
  my ($rev, $revision, $revwanted, $filename, $head, $author, $keywordsubst);

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
      $keywordsubst= '';

      #jump to head state
      $state = "head";
    }

    again:

    if ($state eq "head") {

      #$rcsfile = $1 if (/^RCS file: (.+)$/); #not used (yet)

      if (/^Working file: (.+)$/) {
        $filename = $1;
      } elsif (/^head: (.+)$/) {
        $head = $1;
      } elsif (/^branch: (.+)$/) {
        $branch = $1;
      } elsif (/^keyword substitution: (.+)$/) {
        $keywordsubst = $1;
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
      } elsif ($_ =~ LOG_REVSEPR) {
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
          if (defined($symrev{$tag}) || $tag eq "HEAD") {
            $revwanted    = $symrev{$tag eq "HEAD" ? "MAIN" : $tag};
            ($branch      = $revwanted) =~ s/\b0\.//;
            ($branchpoint = $branch)    =~ s/\.?\d+$//;
            $revwanted    = '' if ($revwanted ne $branch);
          } elsif ($tag ne "HEAD") {
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
      if ($_ =~ LOG_REVSEPR || $_ =~ LOG_FILESEPR) {

        # End of a log entry.
        my $revbranch = $rev;
        $revbranch =~ s/\.\d+$//;

        if ($revwanted eq '' && $branch ne '' && $branch eq $revbranch
            || !defined($tag))
        {
          $revwanted = $rev;
        }

        if ($revwanted ne ''
            ? $rev eq $revwanted
            : $branchpoint ne ''
              ? $rev eq $branchpoint
              : 0
            && ($rev eq $head))
        {    # Don't think head is needed here..
          my @finfo = ($rev, $date, $log, $author, $filename, $keywordsubst);
          (my $name = $filename) =~ s%/.*%%;
          $fileinfo{$name} = [@finfo];
          $state = "done" if ($rev eq $revwanted);
        }
        $rev  = '';
        $date = '';
        $log  = '';
      } elsif ($date eq ''
               && m|^date:\s+(\d+)/(\d+)/(\d+)\s+(\d+):(\d+):(\d+);|)
      {
        my $yr    = $1;
        $yr      -= 1900 if ($yr > 100); # Damn 2-digit year routines :-)
        $date     = timegm($6, $5, $4, $3, $2 - 1, $yr);
        ($author) = /author: ([^;]+)/;
        $state    = 'log';
        $log      = '';
        next;
      } elsif ($rev eq '' && /^revision (\d+(?:\.\d+)+).*$/) {
        $rev = $1;    # .*$ eats up the locker(lockers?) info, if any
        next;
      } else {
        $log .= $_;
      }
    }

    if ($_ =~ LOG_FILESEPR) {
      $state = "start";
      next;
    }
  }

  my $linesread = $. || 0;
  close($fh);

  if ($linesread == 0) {
    fatal('500 Internal Error',
          'Failed to spawn GNU rlog on <em>"%s"</em>.<br /><br />Did you set the <b><code>@command_path</code></b> in your configuration file correctly? (Currently: "<code>%s</code>")',
          htmlquote(join(', ', @files)), join(':', @command_path));
  }

  return @unreadable;
}


sub readLog($;$)
{
  my ($fullname, $revision) = @_;
  my ($symnames, $head, $rev, $br, $brp, $branch, $branchrev);

  undef %symrev;
  undef %revsym;
  undef @allrevisions;
  undef %date;
  undef %author;
  undef %state;
  undef %difflines;
  undef %log;
  $keywordsubstitution = '';

  my $fh = do { local (*FH); };
  if (!open($fh, "-|")) {    # child
    openOutputFilter();
    $revision = defined($revision) ? "-r$revision" : '';
    if ($revision =~ /\./) {
      # Normal revision, not a branch/tag name.
      exec($CMD{rlog}, $revision, $fullname) or exit -1;
    } else {
      exec($CMD{rlog}, $fullname) or exit -1;
    }
  }

  my $curbranch = undef;
  while (<$fh>) {
    if ($symnames) {
      if (/^\s+([^:]+):\s+([\d\.]+)/) {
        $symrev{$1} = $2;
        next;
      } else {
        $symnames = 0;
      }
    }
    if (/^head:\s+([\d\.]+)/) {
      $head = $1;
    } elsif (/^branch:\s+([\d\.]+)/) {
      $curbranch = $1;
    } elsif (/^symbolic names/) {
      $symnames = 1;
    } elsif (/^keyword substitution: (.+)$/) {
      $keywordsubstitution = $1;
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
  # revision 9.19       locked by: vassilii;

  logentry:

  while ($_ !~ LOG_FILESEPR) {
    $_ = <$fh>;
    last logentry if (!defined($_));    # EOF
    if (/^revision (\d+(?:\.\d+)+)/) {
      $rev = $1;
      unshift(@allrevisions, $rev);
    } elsif ($_ =~ LOG_FILESEPR || $_ =~ LOG_REVSEPR) {
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
    if (
      m|^date:\s+(\d+)/(\d+)/(\d+)\s+(\d+):(\d+):(\d+);\s+author:\s+(\S+);\s+state:\s+(\S+);\s+(lines:\s+([0-9\s+-]+))?|
      )
    {
      my $yr           = $1;
      $yr             -= 1900 if ($yr > 100); # Damn 2-digit year routines :-)
      $date{$rev}      = timegm($6, $5, $4, $3, $2 - 1, $yr);
      $author{$rev}    = $7;
      $state{$rev}     = $8;
      $difflines{$rev} = $10;
    } else {
      fatal("500 Internal Error", 'Error parsing RCS output: %s', $_);
    }

  line:
    while (<$fh>) {
      next line if (/^branches:\s/);
      last line if ($_ =~ LOG_FILESEPR || $_ =~ LOG_REVSEPR);
      $log{$rev} .= $_;
    }
  }
  close($fh);

  @revorder = reverse sort { revcmp($a, $b) } @allrevisions;

  #
  # HEAD is an artificial tag which is simply the highest tag number on the main
  # branch, unless there is a branch tag in the RCS file in which case it's the
  # highest revision on that branch.  Find it by looking through @revorder; it
  # is the first commit listed on the appropriate branch.
  # This is not neccesary the same revision as marked as head in the RCS file.
  my $headrev = $curbranch || "1";
  ($symrev{MAIN} = $headrev) =~ s/(\d+)$/0.$1/;

  foreach $rev (@revorder) {
    if ($rev =~ /^(\S*)\.\d+$/ && $headrev eq $1) {
      $symrev{HEAD} = $rev;
      last;
    }
  }
  ($symrev{HEAD} = $headrev) =~ s/\.\d+$// unless defined($symrev{HEAD});

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
      $rev = $head;

      my $regex = '^' . quotemeta($branchrev) . '\b';
      $regex = qr/$regex/;

      foreach my $r (@revorder) {
        if ($r =~ $regex) {
          $rev = $branchrev;
          last;
        }
      }
      next if ($rev eq "");

      if ($rev ne $head && $head ne "") {
        $branchpoint{$head} .= ', ' if ($branchpoint{$head});
        $branchpoint{$head} .= $_;
      }
    }
    $revsym{$rev} .= ", " if ($revsym{$rev});
    $revsym{$rev} .= $_;
    $sel .= sprintf("<option value=\"%s:%s\">%s</option>\n",
                    htmlquote($rev), (htmlquote($_)) x 2);
  }

  my ($onlyonbranch, $onlybranchpoint);
  if ($onlyonbranch = $input{only_with_tag}) {
    $onlyonbranch = $symrev{$onlyonbranch};
    if ($onlyonbranch && $onlyonbranch =~ s/\b0\.//) {
      ($onlybranchpoint = $onlyonbranch) =~ s/\.\d+$//;
    } else {
      $onlybranchpoint = $onlyonbranch;
    }

    if (!defined($onlyonbranch) || $onlybranchpoint eq "") {
      fatal("404 Tag not found", 'Tag "<code>%s</code>" is not defined.',
            $input{only_with_tag});
    }
  }

  undef @revisions;

  foreach (@allrevisions) {
    ($br  = $_)  =~ s/\.\d+$//;
    ($brp = $br) =~ s/\.\d+$//;
    next if ($onlyonbranch
             && $br ne $onlyonbranch
             && $_  ne $onlybranchpoint);
    unshift(@revisions, $_);
  }

  if ($logsort eq "date") {

    # Sort the revisions in commit order an secondary sort on revision
    # (secondary sort needed for imported sources, or the first main
    # revision gets before the same revision on the 1.1.1 branch)
    @revdisplayorder =
      sort { $date{$b} <=> $date{$a} || -revcmp($a, $b) } @revisions;
  } elsif ($logsort eq "rev") {

    # Sort the revisions in revision order, highest first
    @revdisplayorder = reverse sort { revcmp($a, $b) } @revisions;
  } else {

    # No sorting. Present in the same order as rlog / cvs log
    @revdisplayorder = @revisions;
  }

  return $curbranch;
}


sub getDiffLinks($$$)
{
  my ($url, $mimetype, $isbin) = @_;

  my @links = ();
  if (!$isbin) { # Offer ordinary diff only for non-binary files.
    push(@links, &link('preferred', $url));
    for my $difftype ($DIFFTYPES{$defaultDiffType}{colored} ? qw(u) : qw(h)) {
      my $f = $difftype eq $defaultDiffType ? '' : $difftype;
      push(@links,
           &link(htmlquote(lc($DIFFTYPES{$difftype}{descr})), "$url;f=$f"));
    }
  }
  if (my $extdiffs = $DIFF_COMMANDS{lc($mimetype)}) {
    for my $i (0 .. scalar(@$extdiffs)-1) {
      my $extdiff = $extdiffs->[$i];
      push(@links, &link(htmlquote($extdiff->{name}), "$url;f=ext$i"))
        if ($extdiff->{cmd} && $extdiff->{name});
    }
  }
  return @links;
}


sub printLog($$$;$$)
{
  # inlogview: 1 if in log view, otherwise in markup view.
  ($_, my $mimetype, my $isbin, my $inlogview, my $isSelected) = @_;
  (my $br  = $_)  =~ s/\.\d+$//;
  (my $brp = $br) =~ s/\.?\d+$//;

  print "<a name=\"rev$_\"></a>";
  if (defined($revsym{$_})) {
    foreach my $sym (split(", ", $revsym{$_})) {
      print '<a name="', htmlquote($sym), '"></a>';
    }
  }
  if ($revsym{$br} && !defined($nameprinted{$br})) {
    foreach my $sym (split(", ", $revsym{$br})) {
      print '<a name="', htmlquote($sym), '"></a>';
    }
    $nameprinted{$br} = 1;
  }

  print "\n Revision <b>$_</b>";
  if (/^1\.1\.1\.\d+$/) {
    print " <i>(vendor branch)</i>";
  }

  (my $filename = $where) =~ s|^.*/||;
  my $fileurl   = uri_escape($filename);
  undef $filename;

  my $isDead = ($state{$_} eq 'dead');
  if (!$isDead) {

    print ': ', download_link($fileurl, $_, 'download', $mimetype);

    my @vlinks = ();
    push(@vlinks, display_link($fileurl, $_, 'text', 'text/plain'))
      unless $isbin;
    push(@vlinks, display_link($fileurl, $_, 'markup', 'text/x-cvsweb-markup'))
      if ($allow_markup && $inlogview && (!$isbin || viewable($mimetype)));
    if (!$isbin && $allow_annotate) {
      push(@vlinks,
           &link('annotated',
                 sprintf('%s?annotate=%s%s', $fileurl, $_, $barequery)));
    }
    print ' - view: ', join(', ', @vlinks) if @vlinks;
    undef @vlinks;

    if (!$isbin && $allow_version_select) {
      print ' - ';
      if ($isSelected) {
        print '<b>[selected&nbsp;for&nbsp;diffs]</b>';
      } else {
        print &link('select&nbsp;for&nbsp;diffs',
                    sprintf('%s?r1=%s%s#rev%s',
                            $fileurl, $_, $barequery, $_));
      }
    }
    print ' - ', graph_link('', 'revision graph')
      if (!$inlogview && $allow_cvsgraph);
  }
  print "<br />\n";

  print '<i>';
  if (defined @mytz) {
    my ($est) = $mytz[(localtime($date{$_}))[8]];
    print scalar localtime($date{$_}), " $est</i> (";
  } else {
    print scalar gmtime($date{$_}), " UTC</i> (";
  }
  print readableTime(time() - $date{$_}, 1), ' ago)';
  print ' by <i>', htmlquote($author{$_}), "</i><br />\n";

  printf("Branches: %s<br />\n", link_tags($revsym{$br})) if $revsym{$br};
  printf("CVS tags: %s<br />\n", link_tags($revsym{$_}))  if $revsym{$_};
  printf("Branch point for: %s<br />\n", link_tags($branchpoint{$_}))
    if $branchpoint{$_};

  # Find the previous revision
  my $prev;
  my @prevrev = split(/\./, $_);
  do {
    if (--$prevrev[$#prevrev] <= 0) {

      # If it was X.Y.Z.1, just make it X.Y
      pop (@prevrev);
      pop (@prevrev);
    }
    $prev = join (".", @prevrev);
  } until (defined($date{$prev}) || $prev eq "");

  if ($isDead) {
    print "<b><i>FILE REMOVED</i></b><br />\n";
  } else {
    my %diffrev = ();
    $diffrev{$_} = 1;
    $diffrev{""} = 1;
    my $diff = 'Diff to:';
    my $printed = 0;

    #
    # Offer diff to previous revision
    if ($prev) {
      $diffrev{$prev} = 1;
      my $url =
        sprintf('%s.diff?r1=%s;r2=%s%s', $fileurl, $prev, $_, $barequery);
      if (my @dlinks = getDiffLinks($url, $mimetype, $isbin)) {
        print $diff, ' previous ', $prev, ': ', join(', ', @dlinks);
        $diff = ';'; $printed = 1;
      }
    }

    #
    # Plus, if it's on a branch, and it's not a vendor branch,
    # offer a diff with the branch point.
    if ($revsym{$brp}
      && !/^1\.1\.1\.\d+$/
      && !defined($diffrev{$brp}))
    {
      my $url =
        sprintf('%s.diff?r1=%s;r2=%s%s', $fileurl, $brp, $_, $barequery);
      if (my @dlinks = getDiffLinks($url, $mimetype, $isbin)) {
        print $diff, ' branchpoint ', $brp, ': ', join(', ', @dlinks);
        $diff = ';'; $printed = 1;
      }
    }

    #
    # Plus, if it's on a branch, and it's not a vendor branch,
    # offer to diff with the next revision of the higher branch.
    # (e.g. change gets committed and then brought
    # over to -stable)
    if (/^\d+\.\d+\.\d+/ && !/^1\.1\.1\.\d+$/) {
      my ($i, $nextmain);

      for ($i = 0; $i < $#revorder && $revorder[$i] ne $_; $i++) {
      }
      my @tmp2 = split(/\./, $_);
      for ($nextmain = ""; $i > 0; $i--) {
        my $next = $revorder[$i - 1];
        my @tmp1 = split(/\./, $next);

        if (@tmp1 < @tmp2) {
          $nextmain = $next;
          last;
        }

        # Only the highest version on a branch should have
        # a diff for the "next MAIN".
        last
          if (@tmp1 - 1 <= @tmp2
          && join (".", @tmp1[0 .. $#tmp1 - 1]) eq
          join (".", @tmp2[0 .. $#tmp1 - 1]));
      }

      if (!defined($diffrev{$nextmain})) {
        $diffrev{$nextmain} = 1;
        my $url = sprintf('%s.diff?r1=%s;r2=%s%s',
          $fileurl, $nextmain, $_, $barequery);
        if (my @dlinks = getDiffLinks($url, $mimetype, $isbin)) {
          print $diff, ' next MAIN ', $nextmain, ': ', join(', ', @dlinks);
          $diff = ';'; $printed = 1;
        }
      }
    }

    # Plus if user has selected only r1, then present a link
    # to make a diff to that revision
    if (defined($input{r1}) && !defined($diffrev{$input{r1}})) {
      $diffrev{$input{r1}} = 1;
      my $url = sprintf('%s.diff?r1=%s;r2=%s%s',
        $fileurl, $input{r1}, $_, $barequery);
      if (my @dlinks = getDiffLinks($url, $mimetype, $isbin)) {
        print $diff, ' selected ', $input{r1}, ': ', join(', ', @dlinks);
        $diff = ';'; $printed = 1;
      }
    }

    print "<br />\n" if $printed;
  }

  if ($prev ne "" && $difflines{$_}) {
    printf "Changes since revision %s: %s lines<br />\n",
      htmlquote($prev), htmlquote($difflines{$_});
  }

  print "<pre class=\"log\">\n";
  print &htmlify($log{$_}, $allow_log_extra);
  print "</pre>\n";
}


#
# Generates the HTML view for CvsGraph.
#
sub doGraphView()
{
  (my $pathname = $where) =~ s|[^/]*$||;
  (my $filename = $where) =~ s|^.*/||;

  navigateHeader($scriptwhere, $pathname, $filename, undef, 'graph');

  my $title = 'Revision graph of ' . htmlquote($pathname . $filename);
  my $mapname = 'CvsGraphMap';

  printf(<<EOF, $title, $mapname, $cvstree, $title);
<h3 style="text-align: center">%s</h3>
<div style="text-align: center"><img border="0" usemap="#%s" src="?cvsroot=%s;graph=1;makeimage=1" alt="%s" />
EOF

  # Remove any pre-existing tag/branch names from branch links.
  (my $notag_query = $barequery) =~ s/;+only_with_tag=.*?(?=;|$)//g;

  my @graph_cmd =
    ($CMD{cvsgraph},
     '-r', $cvsroot,
     '-m', $pathname,
     '-i',
     '-M', $mapname,
     '-x', 'x',
     "-Omap_branch_href=\"href=\\\"./?only_with_tag=%(%t%)$notag_query\\\"\"",
     "-Omap_rev_href=\"href=\\\"?rev=%(%R%)$barequery\\\"\"",
     "-Omap_diff_href=\"href=\\\"%(%F%).diff" .
     "?r1=%(%P%);r2=%(%R%)$barequery\\\"\"",
     );
  push(@graph_cmd, '-c', $cvsgraph_config) if $cvsgraph_config;
  push(@graph_cmd, $filename . ',v');

  local *CVSGRAPH_OUT;
  my ($h, $err) =
    startproc(\@graph_cmd, \"", '>pipe', \*CVSGRAPH_OUT);
  fatal('500 Internal Error', $err) unless $h;

  # Browser compatibility kludge: many browsers do not support client side
  # image maps where the <map> element contains only the id attribute.  Let's
  # add the corresponding name attribute to it on the fly.
  while (<CVSGRAPH_OUT>) {
    s/(<map\s+id="([^"]+)")\s*>/$1 name="$2">/;
    print;
  }

  $h->finish();
  print "</div>\n";

  html_footer();
}


#
# Generates a graph using CvsGraph.
#
sub doGraph()
{
  (my $pathname = $where) =~ s|[^/]*$||;
  (my $filename = $where) =~ s|^.*/||;

  http_header('image/png');

  my @graph_cmd = ($CMD{cvsgraph}, '-r', $cvsroot, '-m', $pathname);
  push(@graph_cmd, '-c', $cvsgraph_config) if $cvsgraph_config;
  push(@graph_cmd, $filename . ',v');

  local *CVSGRAPH_OUT;
  my ($h, $err) =
    startproc(\@graph_cmd, \"", '>pipe', \*CVSGRAPH_OUT);
  fatal('500 Internal Error', $err) unless $h;
  {
    local $/ = undef;
    binmode(\*STDOUT);
    print <CVSGRAPH_OUT>;
  }
  $h->finish();
}


sub doLog($)
{
  my ($fullname) = @_;

  my $curbranch = readLog($fullname);

  html_header("CVS log for $where");

  my $upwhere = $where;
  (my $filename = $where) =~ s|^.*/||;
  my $backurl = "./$query#" . uri_escape($filename);
  if ($where =~ m|^(.*?)((?<=/)Attic/)?[^/]+$|) {
    $upwhere = $1;
    $backurl = ".$backurl" if $2; # skip over Attic
  }

  my $isbin = $keywordsubstitution =~ /b/;
  my $mimetype = getMimeType($filename, $isbin);

  print "<p>\n ";
  print &link($backicon, $backurl), " <b>Up to ",
    &clickablePath($upwhere, 1), "</b>\n</p>\n";
  print "<p>\n ";
  print &link('Request diff between arbitrary revisions', '#diff');
  print ' - ', &graph_link('', 'Display revisions graphically')
    if $allow_cvsgraph;
  if ($cvshistory_url) {
    (my $d = $upwhere) =~ s|/+$||;
    print ' - ', history_link($d, $filename);
  }
  print "\n</p>\n<hr />\n";

  print "<p>\n";

  my $explain = $isbin ? ' (i.e.: CVS considers this a binary file)' : '';
  print "Keyword substitution: $keywordsubstitution$explain<br />\n";
  if ($curbranch) {
    print "Default branch: ", ($revsym{$curbranch} || $curbranch);
  } else {
    print "No default branch";
  }
  print "<br />\n";

  print 'Current tag: ', htmlquote($input{only_with_tag}), "<br />\n"
    if $input{only_with_tag};
  print "</p>\n";

  undef %nameprinted;

  for my $r (@revdisplayorder) {
    print "<hr />\n";
    my $sel = (defined($input{r1}) && $input{r1} eq $r);
    print "<div class=\"diff-selected\">\n" if $sel;
    printLog($r, $mimetype, $isbin, 1, $sel);
    print "</div>\n" if $sel;
  }

  printf(<<EOF, $scriptwhere);
<hr />
<form method="get" action="%s.diff" id="diff_select">
<fieldset>
<legend>Diff request</legend>
<p>
 <a name="diff">
  This form allows you to request diffs between any two revisions of a file.
  You may select a symbolic revision name using the selection box or you may
  type in a numeric name using the type-in text box.
 </a>
</p>
EOF

  foreach (@stickyvars) {
    printf("<input type=\"hidden\" name=\"%s\" value=\"%s\" />\n",
           $_, htmlquote($input{$_}))
      if (defined($input{$_}) &&
          (!defined($DEFAULTVALUE{$_}) || $input{$_} ne $DEFAULTVALUE{$_}));
  }

  print <<EOF;
<table summary="Diff between arbitrary revisions">
<tr>
<td class="opt-label">
<label for="r1" accesskey="1">Diffs between</label>
</td>
<td class="opt-value">
<select id="r1" name="r1">
<option value="text" selected="selected">Use Text Field</option>
EOF
  print $sel, "</select>\n";

  my $diffrev = defined($input{r1}) ?
    $input{r1} : $revdisplayorder[$#revdisplayorder];

  printf(<<EOF, $inputTextSize, $diffrev);
<input type="text" size="%s" name="tr1" value="%s" onchange="this.form.r1.selectedIndex=0" />
</td>
<td></td>
</tr>
<tr>
<td class="opt-label">
<label for="r2" accesskey="2">and</label>
</td>
<td class="opt-value">
<select id="r2" name="r2">
<option value="text" selected="selected">Use Text Field</option>
EOF
  print $sel, "</select>\n";

  $diffrev = defined($input{r2}) ? $input{r2} : $revdisplayorder[0];

  printf(<<EOF, $inputTextSize, $diffrev, $scriptwhere);
<input type="text" size="%s" name="tr2" value="%s" onchange="this.form.r2.selectedIndex=0" />
</td>
<td><input type="submit" value="Get Diffs" accesskey="G" /></td>
</tr>
</table>
</fieldset>
</form>
<form method="get" action="%s">
<fieldset>
<legend>Log view options</legend>
<table summary="Log view options">
<tr>
<td class="opt-label">
<label for="f" accesskey="D">Preferred diff type:</label>
</td>
<td class="opt-value">
EOF
  printDiffSelect($use_java_script);
  print <<EOF;
</td>
<td></td>
</tr>
EOF

  if (@branchnames) {

    printf(<<EOF, $use_java_script ? ' onchange="this.form.submit()"' : '');
<tr>
<td class="opt-label">
<label for="only_with_tag" accesskey="B">View only branch:</label>
</td>
<td class="opt-value">
<a name="branch">
<select id="only_with_tag" name="only_with_tag"%s>
EOF

    my @tmp = ();
    my $selfound = 0;
    foreach (reverse sort @branchnames) {
      my $selected =
        (defined($input{only_with_tag}) && $input{only_with_tag} eq $_);
      $selfound ||= $selected;
      push(@tmp, sprintf('<option%s>%s</option>',
                         $selected ? ' selected="selected"' : '',
                         htmlquote($_)));
    }
    printf("<option value=\"\"%s>Show all branches</option>\n",
           $selfound ? '' : ' selected="selected"');
    print join("\n", @tmp);

    print <<EOF
</select>
</a>
</td>
<td></td>
</tr>
EOF
  }

  print <<EOF;
<tr>
<td class="opt-label">
<label for="logsort" accesskey="L">Sort log by:</label>
</td>
<td>
EOF
  printLogSortSelect($use_java_script);
  print <<EOF;
</td>
<td><input type="submit" value="Set" accesskey="S" /></td>
</tr>
</table>
EOF
  foreach (@stickyvars) {
    next if ($_ eq "f");
    next if ($_ eq "only_with_tag");
    next if ($_ eq "logsort");
    printf("<input type=\"hidden\" name=\"$_\" value=\"%s\" />\n",
           htmlquote($input{$_}))
      if (defined($input{$_})
          && (!defined($DEFAULTVALUE{$_}) || $input{$_} ne $DEFAULTVALUE{$_}));
  }
  print "</fieldset>\n</form>\n";
  html_footer();
}


sub flush_diff_rows($$$$)
{
  my ($leftColRef, $rightColRef, $leftRow, $rightRow) = @_;

  return unless defined($state);

  if ($state eq "PreChangeRemove") {    # we just got remove-lines before
    for (my $j = 0; $j < $leftRow; $j++) {
      printf(<<EOF, spacedHtmlText(@$leftColRef[$j]));
<tr>
 <td class="diff diff-removed">&nbsp;%s</td>
 <td class="diff diff-empty">&nbsp;</td>
</tr>
EOF
    }
  } elsif ($state eq "PreChange") {     # state eq "PreChange"
                                        # we got removes with subsequent adds
    if (HAS_EDIFF) {
      # construct the suffix tree
      my $left_diff = join("\n", @$leftColRef[0..$leftRow-1]);
      my $right_diff = join("\n", @$rightColRef[0..$rightRow-1]);
      my $diff_str = String::Ediff::ediff($left_diff, $right_diff);

      my @diff_str = split(/ /, $diff_str);
      my $INFINITY = 10000000;
      push(@diff_str, ($INFINITY) x 8);
      my ($idx, $b1, $e1, $lb1, $le1, $b2, $e2, $lb2, $le2) =
        (0, @diff_str[0..7]);
      my ($l_cul, $r_cul) = (0, 0);
      my ($ldx, $rdx) = (0, 0);
      my (@left_html, @right_html);
      for (my $j = 0; $j < $leftRow; $j++) {
        my $line_len = length(@$leftColRef[$j]);
        my $line = @$leftColRef[$j];
        $l_cul += length($line) + 1; # includes "\n"
        my $l_culx = $l_cul - 1; # not includes "\n"
        if ($j < $lb1) {
          $line = spacedHtmlText($line);
          push(@left_html, "<td class=\"diff diff-changed\">$line</td>");
        } elsif ($lb1 == $j) {
          my $html_line;
          while ($lb1 == $j) {
            my $begin_char = $l_culx - $b1;

            $line =~ /^(.*)(.{$begin_char})$/;
            $html_line .= spacedHtmlText($1) .
              '</span><span class="diff diff-unchanged">';
            $line = $2;
            last if ($j != $le1);

            my $end_char = $l_culx - $e1;
            $line =~ /^(.*)(.{$end_char})$/;
            $html_line .= spacedHtmlText($1) .
              '</span><span class="diff diff-changed">';
            $line = $2;

            $idx++;
            my ($tb1, $te1, $tlb1, $tle1, $tb2, $te2, $tlb2, $tle2) =
              ($b1, $e1, $lb1, $le1, $b2, $e2, $lb2, $le2);
            ($b1, $e1, $lb1, $le1, $b2, $e2, $lb2, $le2) =
              @diff_str[$idx*8..($idx+1)*8-1];
            $lb1 = $INFINITY if ($lb1 < 0);
            $lb2 = $INFINITY if ($lb2 < 0);
            $le1 = $INFINITY if ($le1 < 0);
            $le2 = $INFINITY if ($le2 < 0);
            if ($te1 > $b1) {
              ($b1, $lb1) = ($te1, $tle1);
            }
            if ($te2 > $b2) {
              ($b2, $lb2) = ($te2, $tle2);
            }
          }
          push(@left_html,
               sprintf('<td><span class="diff diff-changed">%s%s</span></td>',
                       $html_line, spacedHtmlText($line)));
        } elsif ($le1 == $j) {
          my $html_line;
          while ($le1 == $j) {
            my $end_char = $l_culx - $e1;
            $line =~ /^(.*)(.{$end_char})$/;
            $html_line .= spacedHtmlText($1) .
              '</span><span class="diff diff-changed">';
            $line = $2;

            $idx++;
            my ($tb1, $te1, $tlb1, $tle1, $tb2, $te2, $tlb2, $tle2) =
              ($b1, $e1, $lb1, $le1, $b2, $e2, $lb2, $le2);
            ($b1, $e1, $lb1, $le1, $b2, $e2, $lb2, $le2) =
              @diff_str[$idx*8..($idx+1)*8-1];
            $lb1 = $INFINITY if ($lb1 < 0);
            $lb2 = $INFINITY if ($lb2 < 0);
            $le1 = $INFINITY if ($le1 < 0);
            $le2 = $INFINITY if ($le2 < 0);
            if ($te1 > $b1) {
              ($b1, $lb1) = ($te1, $tle1);
            }
            if ($te2 > $b2) {
              ($b2, $lb2) = ($te2, $tle2);
            }

            last if ($lb1 != $j);

            my $begin_char = $l_culx - $b1;

            $line =~ /^(.*)(.{$begin_char})$/;
            $html_line .= spacedHtmlText($1) .
              '</span><span class="diff diff-unchanged">';
            $line = $2;
          }
          push(@left_html,
              sprintf('<td><span class="diff diff-unchanged">%s%s</span></td>',
                      $html_line, spacedHtmlText($line)));
        } else {
          $line = spacedHtmlText($line);
          push(@left_html, "<td class=\"diff diff-unchanged\">$line</td>");
        }
      }
      ($idx, $b1, $e1, $lb1, $le1, $b2, $e2, $lb2, $le2) =
        (0, @diff_str[0..7]);
      $lb1 = $INFINITY if ($lb1 < 0);
      $lb2 = $INFINITY if ($lb2 < 0);
      $le1 = $INFINITY if ($le1 < 0);
      $le2 = $INFINITY if ($le2 < 0);
      for (my $j = 0; $j < $rightRow; $j++) {
        my $line_len = length(@$rightColRef[$j]);
        my $line = @$rightColRef[$j];
        $r_cul += length($line) + 1; # includes "\n"
        my $r_culx = $r_cul - 1; # not includes "\n"
        if ($j < $lb2) {
          $line = spacedHtmlText($line);
          push(@right_html, "<td class=\"diff diff-changed\">$line</td>");
        } elsif ($lb2 == $j) {
          my $html_line;
          while ($lb2 == $j) {
            my $begin_char = $r_culx - $b2;

            $line =~ /^(.*)(.{$begin_char})$/;
            $html_line .= spacedHtmlText($1) .
              '</span><span class="diff diff-unchanged">';
            $line = $2;

            last if ($j != $le2);

            my $end_char = $r_culx - $e2;
            $line =~ /^(.*)(.{$end_char})$/;
            $html_line .= spacedHtmlText($1) .
              '</span><span class="diff diff-changed">';
            $line = $2;

            $idx++;
            my ($tb1, $te1, $tlb1, $tle1, $tb2, $te2, $tlb2, $tle2) =
              ($b1, $e1, $lb1, $le1, $b2, $e2, $lb2, $le2);
            ($b1, $e1, $lb1, $le1, $b2, $e2, $lb2, $le2) =
              @diff_str[$idx*8..($idx+1)*8-1];
            $lb1 = $INFINITY if ($lb1 < 0);
            $lb2 = $INFINITY if ($lb2 < 0);
            $le1 = $INFINITY if ($le1 < 0);
            $le2 = $INFINITY if ($le2 < 0);
            if ($te1 > $b1) {
              ($b1, $lb1) = ($te1, $tle1);
            }
            if ($te2 > $b2) {
              ($b2, $lb2) = ($te2, $tle2);
            }
          }
          push(@right_html,
               sprintf('<td><span class="diff diff-changed">%s%s</span></td>',
                       $html_line, spacedHtmlText($line)));
        } elsif ($le2 == $j) {
          my $html_line;
          while ($le2 == $j) {
            my $end_char = $r_culx - $e2;
            $line =~ /^(.*)(.{$end_char})$/;
            $html_line .= spacedHtmlText($1) .
              '</span><span class="diff diff-changed">';
            $line = $2;

            $idx++;
            my ($tb1, $te1, $tlb1, $tle1, $tb2, $te2, $tlb2, $tle2) =
              ($b1, $e1, $lb1, $le1, $b2, $e2, $lb2, $le2);
            ($b1, $e1, $lb1, $le1, $b2, $e2, $lb2, $le2) =
              @diff_str[$idx*8..($idx+1)*8-1];
            $lb1 = $INFINITY if ($lb1 < 0);
            $lb2 = $INFINITY if ($lb2 < 0);
            $le1 = $INFINITY if ($le1 < 0);
            $le2 = $INFINITY if ($le2 < 0);
            if ($te1 > $b1) {
              ($b1, $lb1) = ($te1, $tle1);
            }
            if ($te2 > $b2) {
              ($b2, $lb2) = ($te2, $tle2);
            }

            last if ($lb2 != $j);

            my $begin_char = $r_culx - $b2;
            $line =~ /^(.*)(.{$begin_char})$/;
            $html_line .= spacedHtmlText($1) .
              '</span><span class="diff diff-unchanged">';
            $line = $2;
          }
          push(@right_html,
               sprintf('<td nowrap="nowrap"><span class="diff diff-unchanged"'.
                       '>%s%s</span></td>',
                       $html_line, spacedHtmlText($line)));
        } else {
          $line = spacedHtmlText ($line);
          push @right_html, "<td class=\"diff diff-unchanged\">$line</td>";
        }
      }
      for (my $j = 0; $j < $leftRow || $j < $rightRow ; $j++) { # dump out both cols
        print  '<tr>';
        if ($j < $leftRow) {
          print $left_html[$j];
        } else {
          print '<td class="diff diff-changed-missing">&nbsp;</td>';
        }
        if ($j < $rightRow) {
          print $right_html[$j];
        } else {
          print '<td class="diff diff-changed-missing">&nbsp;</td>';
        }
        print "</tr>\n";
      }
    } else {
      for (my $j = 0; $j < $leftRow || $j < $rightRow; $j++) { # dump both cols
        print "<tr>\n";
        if ($j < $leftRow) {
          print '<td class="diff diff-changed">&nbsp;' .
            spacedHtmlText(@$leftColRef[$j]) . '</td>';
        } else {
          print '<td class="diff diff-changed-missing">&nbsp;</td>';
        }
        print "\n";

        if ($j < $rightRow) {
          print '<td class="diff diff-changed">&nbsp;' .
            spacedHtmlText(@$rightColRef[$j]) . '</td>';
        } else {
          print '<td class="diff diff-changed-missing">&nbsp;</td>';
        }
        print "\n</tr>\n";
      }
    }
  }
}


#
# Generates "human readable", HTMLified diffs.
#
sub human_readable_diff($$)
{
  my ($fh, $rev) = @_;

  (my $where_nd       = $where)       =~ s|\.diff$||;
  (my $filename       = $where_nd)    =~ s|^.*/||;
  (my $pathname       = $where_nd)    =~ s|((?<=/)Attic/)?[^/]*$||;
  (my $scriptwhere_nd = $scriptwhere) =~ s|\.diff$||;

  navigateHeader($scriptwhere_nd, $pathname, $filename, $rev, 'diff');

  # Read header to pick up read revision and date, if possible.

  my ($r1d, $r1r, $r2d, $r2r);
  while (<$fh>) {
    ($r1d, $r1r) = /\t(.*)\t(.*)$/ if (/^--- /);
    ($r2d, $r2r) = /\t(.*)\t(.*)$/ if (/^\+\+\+ /);
    last if (/^\+\+\+ /);
  }

  my ($rev1, $date1);
  if (defined($r1r) && $r1r =~ /^(\d+\.)+\d+$/) {
    $rev1  = $r1r;
    $date1 = $r1d;
  }
  my ($rev2, $date2);
  if (defined($r2r) && $r2r =~ /^(\d+\.)+\d+$/) {
    $rev2  = $r2r;
    $date2 = $r2d;
  }
  $rev1  = $input{r1}      unless defined($rev1);
  $rev1  = $input{tr1}     if (defined($rev1) && $rev1 eq 'text');
  $rev1  = 'unknown-left'  unless defined($rev1);
  $rev2  = $input{r2}      unless defined($rev2);
  $rev2  = $input{tr2}     if (defined($rev2) && $rev2 eq 'text');
  $rev2  = 'unknown-right' unless defined($rev2);
  $date1 = defined($date1) ? ', ' . htmlquote($date1) : '';
  $date2 = defined($date2) ? ', ' . htmlquote($date2) : '';

  my $link = uri_escape($filename) . ($query ? "$query;" : '?');

  # Using <table style=\"border: none\" here breaks NS 4.x badly...
  print <<EOF;
<h3 style="text-align: center">Diff for /$where_nd between versions $rev1 and $rev2</h3>
<table border="0" cellspacing="0" cellpadding="0" width="100%" summary="Diff output">
<tr style="background-color: #ffffff">
<th style="text-align: center; vertical-align: top" width="50%">
<a href="${link}rev=$rev1">version $rev1</a>$date1
</th>
<th style="text-align: center; vertical-align: top" width="50%">
<a href="${link}rev=$rev2">version $rev2</a>$date2
</th>
</tr>
EOF

  # Process diff text
  # prefetch several lines
  my @buf = head($fh);
  my %d = scan_directives(@buf);

  my $leftRow  = 0;
  my $rightRow = 0;
  my ($difftxt, @rightCol, @leftCol, $oldline, $newline, $funname);

  $link .= 'content-type=text%2Fx-cvsweb-markup;';
  $link .= 'ln=1;' unless ($link =~ /\?.*\bln=1\b/);

  while (@buf || !eof($fh)) {
    $difftxt = @buf ? shift @buf : <$fh>;

    if ($difftxt =~ /^@@/) {
      ($oldline, $newline, $funname) =
        $difftxt =~ /@@ \-([0-9]+).*\+([0-9]+).*@@(.*)/;
      $funname = htmlquote($funname);
      $funname =~ s/\s/&nbsp;/go;
      $funname &&= "&nbsp;<span style=\"font-size: smaller\">$funname</span>";
      my $ol = $oldline || 1;
      my $nl = $newline || 1;

      print <<EOF;
<tr>
<td width="50%" class="diff-heading">
 <b><a href="${link}rev=$rev1#l$ol">Line&nbsp;$oldline</a></b>$funname
</td>
<td width="50%" class="diff-heading">
 <b><a href="${link}rev=$rev2#l$nl">Line&nbsp;$newline</a></b>$funname
</td>
</tr>
EOF

      $state    = "dump";
      $leftRow  = 0;
      $rightRow = 0;
    } else {
      my ($diffcode, $rest) = $difftxt =~ /^([-+ ])(.*)/;
      $diffcode = '' unless defined($diffcode);
      $_ = $rest;

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
        {    # 'change' never begins with '+': just dump out value
          $_ = spacedHtmlText($rest, $d{tabstop});
          printf(<<EOF, $_);
<tr>
 <td class="diff diff-empty">&nbsp;</td>
 <td class="diff diff-added">&nbsp;%s</td>
</tr>
EOF
        } else {    # we got minus before
          $state = "PreChange";
          $rightCol[$rightRow++] = $_;
        }
      } elsif ($diffcode eq '-') {
        $state = "PreChangeRemove";
        $leftCol[$leftRow++] = $_;
      } else {    # empty diffcode
        flush_diff_rows \@leftCol, \@rightCol, $leftRow, $rightRow;
        $_ = spacedHtmlText($rest, $d{tabstop});
        printf(<<EOF, $_, $_);
<tr>
 <td class="diff diff-same">&nbsp;%s</td>
 <td class="diff diff-same">&nbsp;%s</td>
</tr>
EOF
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
    print <<EOF;
<tr>
 <td colspan="2">&nbsp;</td>
</tr>
<tr class="diff diff-empty">
 <td colspan="2" align="center"><b>- No viewable change -</b></td>
</tr>
EOF
  }

  printf(<<EOF, $scriptwhere);
</table>
<hr style="width: 100%%" />
<form method="get" action="%s">
<div style="float: left">
<label for="f">Diff format:<br />
EOF
  printDiffSelectStickyVars();
  printDiffSelect($use_java_script);
  printf(<<EOF, $rev1, $rev2);
</label>
<input type="submit" value="Show" />
</div>
<table style="float: right; border: thin outset" cellspacing="0" cellpadding="1" title="Legend" summary="Legend">
 <tr>
  <td align="center" class="diff diff-removed">Removed from v.%s</td>
  <td class="diff diff-empty">&nbsp;</td>
 </tr><tr class="diff diff-changed">
  <td align="center" colspan="2">changed lines</td>
 </tr><tr>
  <td class="diff diff-empty">&nbsp;</td>
  <td align="center" class="diff diff-added">Added in v.%s</td>
 </tr>
</table>
</form>
<br clear="all" />
EOF
}


sub doEnscript($$$;$)
{
  my ($filehandle, $highlight, $linenumbers, $lang) = @_;
  $lang ||= 'cvsweb';

  my @cmd = ($CMD{enscript},
             @enscript_options,
             '-q', "--language=$lang", '-o', '-', "--highlight=$highlight");

  local *ENSCRIPT_OUT;
  my ($h, $err) =
    startproc(\@cmd, $filehandle, '>pipe', \*ENSCRIPT_OUT);
  fatal('500 Internal Error', $err) unless $h;

  # We could short-circuit and have enscript output directly to STDOUT above,
  # but that doesn't work with mod_perl (at least some 1.99 versions).
  if ($linenumbers) {
    my $ln = 0;
    while (<ENSCRIPT_OUT>) {
      printf '<a id="l%d" class="src">%5d: </a>', (++$ln) x 2;
      print $_;
    }
  } else {
    local $/ = undef;
    print <ENSCRIPT_OUT>;
  }
  $h->finish();
}


#
# The passed in $path and $filename should not be URI escaped, and $swhere
# *should* be.
#
sub navigateHeader($$$$$;$)
{
  my ($swhere, $path, $filename, $rev, $title, $moddate) = @_;
  $swhere = "" if ($swhere eq $scriptwhere);
  $swhere = './' . uri_escape($filename) if ($swhere eq "");

  my $qfile = htmlquote($filename);
  my $qpath = htmlquote($path);
  my $trev  = $rev ? " - " . htmlquote($rev) : '';

  http_header('text/html', $moddate);

  (my $header = &cgi_style::html_header($title, 0)) =~ s,\A.*<head>,<head>\n$HTML_META,s;
  $header .= $CSS .
'<body class="src">
 <table class="navigate-header" width="100%" summary="Navigation">
  <tr>
   <td>';
  print $header;

  my $frag = '';
  if ($rev) {
    $frag  = '#';
    $frag .= 'rev' if ($rev =~ /\./);  # Normal revision: prefix with "rev".
    $frag .= $rev;                     # Append revision/branch/tag.
  }
  my $backurl = "$swhere$query$frag";

  print &link($backicon, $backurl);
  printf '<b>Return to %s CVS log', &link($qfile, $backurl);
  print "</b> $fileicon</td>";

  printf(<<EOF, $diricon, &clickablePath($path, 1));
  <td style="text-align: right">%s <b>Up to %s</b></td>
 </tr>
</table>
EOF
}


sub plural_write($$)
{
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
sub readableTime($$)
{
  my ($secs, $long) = @_;

  # This function works correctly for time >= 2 seconds.
  return 'very little time' if ($secs < 2);

  my %desc = (
              1        => 'second',
              60       => 'minute',
              3600     => 'hour',
              86400    => 'day',
              604800   => 'week',
              2628000  => 'month',
              31536000 => 'year'
             );

  my @breaks = sort { $a <=> $b } keys %desc;
  my $i = 0;

  while ($i <= $#breaks && $secs >= 2 * $breaks[$i]) {
    $i++;
  }
  $i--;
  my $break  = $breaks[$i];
  my $retval = plural_write(int($secs / $break), $desc{$break});

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


#
# Returns a htmlified path where each directory is a link for faster
# navigation.  $clickLast controls whether the basename
# (last directory/file) is a link as well.  The passed in $pathname should
# *not* be URI escaped.
#
sub clickablePath($$)
{
  my ($pathname, $clickLast) = @_;

  my $root = '[' . htmlquote($CVSROOTdescr{$cvstree} || $cvstree) . ']';

  # This should never happen (see chooseCVSRoot()), but let's be sure...
  return $root if ($pathname eq '/');

  my $retval =
    ' ' . &link($root, sprintf('%s/%s#dirlist', $scriptname, $query));
  my $wherepath = '';
  my ($lastslash) = $pathname =~ m|/$|;

  foreach (split(m|/|, $pathname)) {
    $retval .= ' / ';
    $wherepath .= "/$_";
    my $last = "$wherepath/" eq "/$pathname" || $wherepath eq "/$pathname";

    if ($clickLast || !$last) {
      $retval .= &link(htmlquote($_),
                       join ('',
                             $scriptname, uri_escape_path($wherepath),
                             (!$last || $lastslash ? '/' : ''), $query,
                             (!$last || $lastslash ? "#dirlist" : "")));
    } else {    # do not make a link to the current dir
      $retval .= htmlquote($_);
    }
  }
  return $retval;
}


sub chooseCVSRoot()
{
  print "<form method=\"get\" action=\"$scriptwhere\">\n<p>\n";
  if (2 <= @CVSROOT) {
    foreach my $k (keys %input) {
      printf("<input type=\"hidden\" name=\"%s\" value=\"%s\" />\n",
             htmlquote($k), htmlquote($input{$k}))
        if ($input{$k} && $k ne 'cvsroot');
    }

    printf(<<EOF, $use_java_script ? ' onchange="this.form.submit()"' : '');
<label for="cvsroot" accesskey="C">CVS Root:
<select id="cvsroot" name="cvsroot"%s>
EOF

    foreach my $k (@CVSROOT) {
      printf("<option value=\"%s\"%s>%s</option>\n",
             htmlquote($k),
             ($k eq $cvstree) ? ' selected="selected"' : '',
             htmlquote($CVSROOTdescr{$k} || $k));
    }
    print '</select></label>';
  } else {

    # no choice -- but we need the form to select module/path,
    # at least for Netscape
    printf "CVS Root: <b>[%s]</b>",
      htmlquote($CVSROOTdescr{$cvstree} || $cvstree);
  }

  print <<EOF;
<label for="mpath" accesskey="M">
Module path or alias:
<input type="text" id="mpath" name="path" value="" size="15" />
</label>
<input type="submit" value="Go" accesskey="O" />
</p>
</form>
EOF
}


sub chooseMirror()
{
  # This code comes from the original BSD-cvsweb
  # and may not be useful for your site; If you don't
  # set %MIRRORS this won't show up, anyway.
  scalar(%MIRRORS) or return;

  # Should perhaps exclude the current site somehow...
  print "\n<p>\nThis CVSweb is mirrored in\n";

  my @tmp = map(&link(htmlquote($_), $MIRRORS{$_}), sort keys %MIRRORS);
  my $tmp = pop (@tmp);

  if (scalar(@tmp)) {
    print join (', ', @tmp), ' and ';
  }

  print "$tmp.\n</p>\n";
}


sub fileSortCmp()
{
  (my $af = $a) =~ s/,v$//;
  (my $bf = $b) =~ s/,v$//;
  my ($rev1, $date1, $log1, $author1, $filename1) = @{$fileinfo{$af}}
    if (defined($fileinfo{$af}));
  my ($rev2, $date2, $log2, $author2, $filename2) = @{$fileinfo{$bf}}
    if (defined($fileinfo{$bf}));

  my $comp = 0;
  if (defined($filename1) && defined($filename2) &&
      $af eq $filename1   && $bf eq $filename2)
  {

    # Two files
    $comp = -revcmp($rev1, $rev2)             if ($byrev  && $rev1  && $rev2);
    $comp = ($date2   <=> $date1)             if ($bydate && $date1 && $date2);
    if ($input{ignorecase}) {
      $comp = (uc($log1)    cmp uc($log2))    if ($bylog && $log1 && $log2);
      $comp = (uc($author1) cmp uc($author2)) if ($byauthor &&
                                                  $author1 && $author2);
    } else {
      $comp = ($log1    cmp $log2)            if ($bylog && $log1 && $log2);
      $comp = ($author1 cmp $author2)         if ($byauthor &&
                                                  $author1 && $author2);
    }
  }

  if ($comp == 0) {

    # Directories first, then files under version control,
    # then other, "rogue" files.
    # Sort by filename if no other criteria available.

    my $ad = (
      (-d "$fullname/$a")
      ? 'D'
      : (defined($fileinfo{$af}) ? 'F' : 'R')
    );
    my $bd = (
      (-d "$fullname/$b")
      ? 'D'
      : (defined($fileinfo{$bf}) ? 'F' : 'R')
    );
    (my $c = $a) =~ s|.*/||;
    (my $d = $b) =~ s|.*/||;

    my ($l, $r) = ("$ad$c", "$bd$d");
    $comp = $input{ignorecase} ? (uc($l) cmp uc($r)) : ($l cmp $r);

    # Parent dir is always first, then Attic.
    if ($comp != 0) {
      if ($l eq 'D..') {
        $comp = -1;
      } elsif ($r eq 'D..') {
        $comp = 1;
      } elsif ($l eq 'DAttic') {
        $comp = -1;
      } elsif ($r eq 'DAttic') {
        $comp = 1;
      }
    }
  }
  return $comp;
}

#
# Returns a URL to download the selected revision.
# Expects the passed in URL to be URI escaped, relative, and without a query
# string.
#
sub download_url($$;$)
{
  my ($url, $revision, $mimetype) = @_;
  my @dots = $revision =~ /\./g;
  $revision =~ s/\b0\.(?=\d+$)// if (scalar(@dots) & 1);

  if (!defined($mimetype) || $mimetype !~ CVSWEBMARKUP) {
    my $path = $where;
    $path =~ s|[^/]+$||;
    $url = "$scriptname/$CheckoutMagic/$path$url";
  }
  $url .= '?rev=' . uri_escape($revision);
  $url .= ';content-type=' . uri_escape($mimetype) if $mimetype;

  return $url;
}

#
# Returns a link to download the selected revision.
# Expects the passed in URL to be URI escaped, relative,
# and without a query string.
#
sub download_link($$$;$)
{
  my ($url, $revision, $textlink, $mimetype) = @_;
  return sprintf('<a href="%s" class="download-link">%s</a>',
                 download_url($url, $revision, $mimetype) . $barequery,
                 htmlquote($textlink));
}

#
# Returns a URL to display the selected revision.
# Expects the passed in URL to be URI escaped, and without a query string.
#
sub display_url($$;$)
{
  my ($url, $revision, $mimetype) = @_;
  $url .= '?rev=' . uri_escape($revision);
  $url .= ';content-type=' . uri_escape($mimetype) if $mimetype;
  return $url;
}

#
# Returns a link to display the selected revision.
# Expects the passed in URL to be URI escaped, and without a query string.
#
sub display_link($$;$$)
{
  my ($url, $revision, $textlink, $mtype) = @_;
  $textlink = $revision unless defined($textlink);
  return sprintf('<a href="%s" class="display-link">%s</a>',
                 display_url($url, $revision, $mtype) . $barequery,
                 htmlquote($textlink));
}

#
# Expects the passed in URL to be URI escaped, and without a query string.
# The passed in link text should be already HTML escaped as appropriate.
#
sub graph_link($;$)
{
  my ($url, $text) = @_;
  $text ||= $graphicon;
  return sprintf('<a href="%s?graph=1%s">%s</a>', $url, $barequery, $text);
}

#
# Returns a link to CVSHistory for the given directory and filename.
#
sub history_link($$;$)
{
  my ($dir, $file, $text) = @_;
  $dir  ||= '';
  $file ||= '';
  $text ||= 'History';
  return &link($text,
               sprintf('%s?cvsroot=%s;dsearch=%s;fsearch=%s;limit=1',
                       $cvshistory_url, uri_escape($input{cvsroot} || ''),
                       uri_escape($dir), uri_escape($file)));
}

# Returns a Query string with the
# specified parameter toggled
sub toggleQuery($;$)
{
  my ($toggle, $value) = @_;

  my %vars = %input;

  if (defined($value)) {
    $vars{$toggle} = $value;
  } else {
    $vars{$toggle} = $vars{$toggle} ? 0 : 1;
  }

  # Build a new query of non-default paramenters
  my $newquery = "";
  foreach my $var (@stickyvars) {
    my ($value)   = defined($vars{$var})         ? $vars{$var}         : "";
    my ($default) = defined($DEFAULTVALUE{$var}) ? $DEFAULTVALUE{$var} : "";

    if ($value ne $default) {
      $newquery .= ';' if ($newquery ne "");
      $newquery .= uri_escape($var) . '=' . uri_escape($value);
    }
  }

  if ($newquery) {
    return '?' . $newquery;
  }
  return "";
}

sub htmlquote($)
{
  local ($_) = @_;
  # Special Characters; RFC 1866
  s/&/&amp;/g;
  s/\"/&quot;/g;
  s/</&lt;/g;
  s/>/&gt;/g;
  return $_;
}

sub htmlunquote($)
{
  local ($_) = @_;
  # Special Characters; RFC 1866
  s/&quot;/\"/g;
  s/&lt;/</g;
  s/&gt;/>/g;
  s/&amp;/&/g;
  return $_;
}

sub uri_escape_path($)
{
  return join('/', map(uri_escape($_), split(m|/+|, shift, -1)));
}

sub http_header(;$$)
{
  my ($content_type, $moddate) = @_;
  $content_type ||= 'text/html';

  $content_type .= "; charset=$charset"
    if ($charset && $content_type =~ m,^text/,);

  # Note that in the following, we explicitly join() and concatenate the
  # headers instead of printing them as an array.  This is because some
  # systems, eg. early versions of mod_perl 2 don't quite get it if the
  # last \r\n\r\n isn't included in the last "payload" header print().

  my @headers = ();
  # TODO: ctime(3) from scalar gmtime() isn't HTTP compliant, see HTTP::Date.
  push(@headers, 'Last-Modified: ' . scalar gmtime($moddate) . ' GMT')
    if $moddate;
  push(@headers, 'Content-Type: ' . $content_type);

  if ($allow_compress && $maycompress) {
    if (HAS_ZLIB
        || (defined($CMD{gzip}) && open(GZIP, "| $CMD{gzip} -1 -c")))
    {

      push(@headers, 'Content-Encoding: gzip');
      push(@headers, 'Vary: Accept-Encoding');     # RFC 2616, 14.44
      print join("\r\n", @headers) . "\r\n\r\n";

      $| = 1;
      $| = 0;                                      # Flush header output.

      tie(*GZIP, __PACKAGE__, \*STDOUT) if HAS_ZLIB;
      select(GZIP);
      $gzip_open = 1;

    } else {

      print join("\r\n", @headers) . "\r\n\r\n";
      printf
        '<span style="font-size: smaller">Unable to find gzip binary in the <b>$command_path</b> (<code>%s</code>) to compress output</span><br />',
          htmlquote(join(':', @command_path));
    }

  } else {
    print join("\r\n", @headers) . "\r\n\r\n";
  }
}


sub html_header($;$)
{
  my ($title, $moddate) = @_;
  $title  = htmlquote($title);
  my $css = $CSS || '';
  http_header('text/html', $moddate);

  (my $header = &cgi_style::html_header($title, 0)) =~ s,\A.*<head>,<head>\n$HTML_META,s;
  $header .= $css;
  print $header;
}

sub html_footer()
{
  print &cgi_style::html_footer;
}

sub link_tags($)
{
  my ($tags) = @_;

  (my $filename = $where) =~ s|^.*/||;
  my $fileurl = './' . uri_escape($filename);

  my $ret = "";
  foreach my $sym (split(", ", $tags)) {
    $ret .= ",\n" if ($ret ne "");
    $ret .= &link(htmlquote($sym),
                  $fileurl . toggleQuery('only_with_tag', $sym));
  }
  return $ret;
}


#
# See if a file/dir is listed in the config file's @ForbiddenFiles list.
# Takes a full file system path or one relative to $cvsroot, and strips the
# trailing ",v" if present, then compares.  Returns 1 if forbidden, else 0.
#
sub forbidden($)
{
  (my $path = canonpath(shift)) =~ s/,v$//;
  $path =~ s|^$cvsroot/+||;
  for my $forbidden_re (@ForbiddenFiles) {
    return 1 if ($path =~ $forbidden_re);
  }
  return 0;
}


#
# Starts a process using IPC::Run.  All arguments are passed to
# IPC::Run::start() as-is.  Returns an array ($harness, $error) where
# $harness is from IPC::Run if start() succeeds, undef otherwise.  In case
# of an error, $error contains the error message.
#
sub startproc(@)
{
  my $h = my $err = undef;
  eval {
    local $SIG{__DIE__};
    $h = IPC::Run::start(@_) or die("return code: $?");
  };
  if ($@) {
    $h->finish() if $h;
    $h = undef;
    $err = "'@{$_[0]}' failed: $@";
  }
  return ($h, $err);
}

#
# Runs a process using IPC::Run.  All arguments are passed to
# IPC::Run::run() as-is.  Returns an array ($exitcode, $errormsg).
#
sub runproc(@)
{
  eval {
    local $SIG{__DIE__};
    IPC::Run::run(@_);
  };
  my $exitcode = $? >> 8;
  my $errormsg  = undef;
  if ($@) {
    $exitcode ||= -1;
    $errormsg = "'@{$_[0]}' failed: $@";
  }
  return ($exitcode, $errormsg);
}

#
# Check out a file to a temporary file.
#
sub checkout_to_temp($$$)
{
  my ($cvsroot, $cvsname, $rev) = @_;

  # Pipe given cvs file into a temporary place.
  my ($temp_fh, $temp_fn) = tempfile('.cvsweb.XXXXXXXX', DIR => tmpdir());

  my @cmd = ($CMD{cvs}, @cvs_options, '-Qd', $cvsroot,
             'co', '-p', "-r$rev", $cvsname);

  local (*DIFF_OUT);
  my ($h, $err) = startproc(\@cmd, \"", '>pipe', \*DIFF_OUT);
  if ($h) {
    local $/ = undef;
    print $temp_fh <DIFF_OUT>;
    $h->finish();
    close($temp_fh);
  } else {
    close($temp_fh);
    unlink($temp_fn);
    fatal('500 Internal Error',
          'Checkout failure (exit status %s), output: <pre>%s</pre>',
          $? >> 8 || -1, $err);
  }

  return $temp_fn;
}

#
# Close the GZIP handle, and remove the tie.
#
sub gzipclose
{
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

sub TIEHANDLE
{
  my ($class, $out) = @_;
  my ($d) = Compress::Zlib::deflateInit(
    -Level      => Compress::Zlib::Z_BEST_COMPRESSION(),
    -WindowBits => -Compress::Zlib::MAX_WBITS()
    )
    or return undef;
  my ($o) = { handle => $out,
              dh     => $d,
              crc    => 0,
              len    => 0,
            };
  my ($header) = pack("c10",
                      MAGIC1, MAGIC2, Compress::Zlib::Z_DEFLATED(),
                      0, 0, 0, 0, 0, 0, OSCODE);
  print {$o->{handle}} $header;
  return bless($o, $class);
}

sub PRINT
{
  my ($o)   = shift;
  my ($buf) = join (defined($,) ? $, : "", @_);
  my ($len) = length($buf);
  my ($compressed, $status) = $o->{dh}->deflate($buf);
  print {$o->{handle}} $compressed if defined($compressed);
  $o->{crc} = Compress::Zlib::crc32($buf, $o->{crc});
  $o->{len} += $len;
  return $len;
}

sub PRINTF
{
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

sub WRITE
{
  my ($o, $buf, $len, $off) = @_;
  my ($compressed, $status) = $o->{dh}->deflate(substr($buf, 0, $len));
  print {$o->{handle}} $compressed if defined($compressed);
  $o->{crc} = Compress::Zlib::crc32(substr($buf, 0, $len), $o->{crc});
  $o->{len} += $len;
  return $len;
}

sub CLOSE
{
  my ($o) = @_;
  return if !defined($o->{dh});
  my ($buf) = $o->{dh}->flush();
  $buf .= pack("V V", $o->{crc}, $o->{len});
  print {$o->{handle}} $buf;
  undef $o->{dh};
}

sub DESTROY
{
  my ($o) = @_;
  CLOSE($o);
}

# Local variables:
# indent-tabs-mode: nil
# cperl-indent-level: 2
# End:

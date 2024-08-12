# This module is free software; you can redistribute it and/or modify it under the
# same terms as Perl itself. See https://metacpan.org/pod/perlartistic
#
# MyCgiSimple.pm - striped down version of CGI::Simple;

package MyCgiSimple;

sub charset {
    return 'utf-8';
}

sub param {
    my ( $self, $param, @p ) = @_;
    unless ( defined $param ) {    # return list of all params
        my @params = $self->{'.parameters'} ? @{ $self->{'.parameters'} } : ();
        return @params;
    }
    unless (@p) {                  # return values for $param
        return () unless exists $self->{$param};
        return wantarray ? @{ $self->{$param} } : $self->{$param}->[0];
    }
    if ( $param =~ m/^-name$/i and @p == 1 ) {
        return () unless exists $self->{ $p[0] };
        return wantarray ? @{ $self->{ $p[0] } } : $self->{ $p[0] }->[0];
    }

    # set values using -name=>'foo',-value=>'bar' syntax.
    # also allows for $q->param( 'foo', 'some', 'new', 'values' ) syntax
    ( $param, undef, @p ) = @p
      if $param =~ m/^-name$/i;    # undef represents -value token
    $self->_add_param( $param, ( ref $p[0] eq 'ARRAY' ? $p[0] : [@p] ),
        'overwrite' );
    return wantarray ? @{ $self->{$param} } : $self->{$param}->[0];
}

sub new {
    my ( $class, $init ) = @_;
    $class = ref($class) || $class;
    my $self = {};
    bless $self, $class;

    $self->_initialize_globals;
    $self->_store_globals;
    $self->_initialize($init);

    return $self;
}

sub path_info {
    my ( $self, $info ) = @_;
    if ( defined $info ) {
        $info = "/$info" if $info !~ m|^/|;
        $self->{'.path_info'} = $info;
    }
    elsif ( !defined( $self->{'.path_info'} ) ) {
        $self->{'.path_info'} =
          defined( $ENV{'PATH_INFO'} ) ? $ENV{'PATH_INFO'} : '';

        # hack to fix broken path info in IIS source CGI.pm
        $self->{'.path_info'} =~ s/^\Q$ENV{'SCRIPT_NAME'}\E//
          if defined( $ENV{'SERVER_SOFTWARE'} )
          && $ENV{'SERVER_SOFTWARE'} =~ /IIS/;
    }
    return $self->{'.path_info'};
}

sub _initialize {
    my ( $self, $init ) = @_;

    if ( !defined $init ) {

        # initialize from QUERY_STRING, STDIN or @ARGV
        $self->_read_parse();
    }
    elsif ( ( ref $init ) =~ m/HASH/i ) {

        # initialize from param hash
        for my $param ( keys %{$init} ) {
            $self->_add_param( $param, $init->{$param} );
        }
    }

    # chromatic's blessed GLOB patch
    # elsif ( (ref $init) =~ m/GLOB/i ) { # initialize from a file
    elsif ( UNIVERSAL::isa( $init, 'GLOB' ) ) {    # initialize from a file
        $self->_init_from_file($init);
    }
    elsif ( ( ref $init ) eq 'CGI::Simple' ) {

        # initialize from a CGI::Simple object
        require Data::Dumper;

        # avoid problems with strict when Data::Dumper returns $VAR1
        my $VAR1;
        my $clone = eval( Data::Dumper::Dumper($init) );
        if ($@) {
            $self->cgi_error("Can't clone CGI::Simple object: $@");
        }
        else {
            $_[0] = $clone;
        }
    }
    else {
        $self->_parse_params($init);    # initialize from a query string
    }
}

sub _initialize_globals {

    # set this to 1 to use CGI.pm default global settings
    $USE_CGI_PM_DEFAULTS = 0
      unless defined $USE_CGI_PM_DEFAULTS;

    # see if user wants old CGI.pm defaults
    if ($USE_CGI_PM_DEFAULTS) {
        _use_cgi_pm_global_settings();
        return;
    }

    # no file uploads by default, set to 0 to enable uploads
    $DISABLE_UPLOADS = 1
      unless defined $DISABLE_UPLOADS;

    # use a post max of 100K, set to -1 for no limits
    $POST_MAX = 102_400
      unless defined $POST_MAX;

    # set to 1 to not include undefined params parsed from query string
    $NO_UNDEF_PARAMS = 0
      unless defined $NO_UNDEF_PARAMS;

    # separate the name=value pairs with ; rather than &
    $USE_PARAM_SEMICOLONS = 0
      unless defined $USE_PARAM_SEMICOLONS;

    # return everything as utf-8
    $PARAM_UTF8 ||= 0;
    $PARAM_UTF8 and require Encode;

    # only print headers once
    $HEADERS_ONCE = 0
      unless defined $HEADERS_ONCE;

    # Set this to 1 to enable NPH scripts
    $NPH = 0
      unless defined $NPH;

    # 0 => no debug, 1 => from @ARGV,  2 => from STDIN
    $DEBUG = 0
      unless defined $DEBUG;

    # filter out null bytes in param - value pairs
    $NO_NULL = 1
      unless defined $NO_NULL;

    # set behavior when cgi_err() called -1 => silent, 0 => carp, 1 => croak
    $FATAL = -1
      unless defined $FATAL;
}

# this is called by new, we will never directly reference the globals again
sub _store_globals {
    my $self = shift;

    $self->{'.globals'}->{'DISABLE_UPLOADS'}      = $DISABLE_UPLOADS;
    $self->{'.globals'}->{'POST_MAX'}             = $POST_MAX;
    $self->{'.globals'}->{'NO_UNDEF_PARAMS'}      = $NO_UNDEF_PARAMS;
    $self->{'.globals'}->{'USE_PARAM_SEMICOLONS'} = $USE_PARAM_SEMICOLONS;
    $self->{'.globals'}->{'HEADERS_ONCE'}         = $HEADERS_ONCE;
    $self->{'.globals'}->{'NPH'}                  = $NPH;
    $self->{'.globals'}->{'DEBUG'}                = $DEBUG;
    $self->{'.globals'}->{'NO_NULL'}              = $NO_NULL;
    $self->{'.globals'}->{'FATAL'}                = $FATAL;
    $self->{'.globals'}->{'USE_CGI_PM_DEFAULTS'}  = $USE_CGI_PM_DEFAULTS;
    $self->{'.globals'}->{'PARAM_UTF8'}           = $PARAM_UTF8;
}

sub _read_parse {
    my $self   = shift;
    my $data   = '';
    my $type   = $ENV{'CONTENT_TYPE'} || 'No CONTENT_TYPE received';
    my $length = $ENV{'CONTENT_LENGTH'} || 0;
    my $method = $ENV{'REQUEST_METHOD'} || 'No REQUEST_METHOD received';

    # first check POST_MAX Steve Purkis pointed out the previous bug
    if (    ( $method eq 'POST' or $method eq "PUT" )
        and $self->{'.globals'}->{'POST_MAX'} != -1
        and $length > $self->{'.globals'}->{'POST_MAX'} )
    {
        $self->cgi_error(
"413 Request entity too large: $length bytes on STDIN exceeds \$POST_MAX!"
        );

        # silently discard data ??? better to just close the socket ???
        while ( $length > 0 ) {
            last unless _internal_read( $self, my $buffer );
            $length -= length($buffer);
        }

        return;
    }

    if ( $length and $type =~ m|^multipart/form-data|i ) {
        my $got_length = $self->_parse_multipart;
        if ( $length != $got_length ) {
            $self->cgi_error(
"500 Bad read on multipart/form-data! wanted $length, got $got_length"
            );
        }

        return;
    }
    elsif ( $method eq 'POST' or $method eq 'PUT' ) {
        if ($length) {

            # we may not get all the data we want with a single read on large
            # POSTs as it may not be here yet! Credit Jason Luther for patch
            # CGI.pm < 2.99 suffers from same bug
            _internal_read( $self, $data, $length );
            while ( length($data) < $length ) {
                last unless _internal_read( $self, my $buffer );
                $data .= $buffer;
            }

            unless ( $length == length $data ) {
                $self->cgi_error( "500 Bad read on POST! wanted $length, got "
                      . length($data) );
                return;
            }

            if ( $type !~ m|^application/x-www-form-urlencoded| ) {
                $self->_add_param( $method . "DATA", $data );
            }
            else {
                $self->_parse_params($data);
            }
        }
    }
    elsif ( $method eq 'GET' or $method eq 'HEAD' ) {
        $data =
            $self->{'.mod_perl'}
          ? $self->_mod_perl_request()->args()
          : $ENV{'QUERY_STRING'}
          || $ENV{'REDIRECT_QUERY_STRING'}
          || '';
        $self->_parse_params($data);
    }
    else {
        unless ($self->{'.globals'}->{'DEBUG'}
            and $data = $self->read_from_cmdline() )
        {
            $self->cgi_error("400 Unknown method $method");
            return;
        }

        unless ($data) {

    # I liked this reporting but CGI.pm does not behave like this so
    # out it goes......
    # $self->cgi_error("400 No data received via method: $method, type: $type");
            return;
        }

        $self->_parse_params($data);
    }
}

sub cgi_error {
    my ( $self, $err ) = @_;
    if ($err) {
        require Carp;
        $self->{'.cgi_error'} = $err;
            $self->{'.globals'}->{'FATAL'} == 1 ? croak $err
          : $self->{'.globals'}->{'FATAL'} == 0 ? carp $err
          :                                       return $err;
    }
    return $self->{'.cgi_error'};
}

# This internal routine creates date strings suitable for use in
# cookies and HTTP headers.  (They differ, unfortunately.)
# Thanks to Mark Fisher for this.
sub expires {
    my ( $time, $format ) = @_;
    $format ||= 'http';

    my (@MON)  = qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;
    my (@WDAY) = qw/Sun Mon Tue Wed Thu Fri Sat/;

    # pass through preformatted dates for the sake of expire_calc()
    $time = expire_calc($time);
    return $time unless $time =~ /^\d+$/;

    # make HTTP/cookie date string from GMT'ed time
    # (cookies use '-' as date separator, HTTP uses ' ')
    my ($sc) = ' ';
    $sc = '-' if $format eq "cookie";
    my ( $sec, $min, $hour, $mday, $mon, $year, $wday ) = gmtime($time);
    $year += 1900;
    return sprintf( "%s, %02d$sc%s$sc%04d %02d:%02d:%02d GMT",
        $WDAY[$wday], $mday, $MON[$mon], $year, $hour, $min, $sec );
}

# This internal routine creates an expires time exactly some number of
# hours from the current time.  It incorporates modifications from
# Mark Fisher.
sub expire_calc {
    my ($time) = @_;
    my (%mult) = (
        's' => 1,
        'm' => 60,
        'h' => 60 * 60,
        'd' => 60 * 60 * 24,
        'M' => 60 * 60 * 24 * 30,
        'y' => 60 * 60 * 24 * 365
    );

    # format for time can be in any of the forms...
    # "now" -- expire immediately
    # "+180s" -- in 180 seconds
    # "+2m" -- in 2 minutes
    # "+12h" -- in 12 hours
    # "+1d"  -- in 1 day
    # "+3M"  -- in 3 months
    # "+2y"  -- in 2 years
    # "-3m"  -- 3 minutes ago(!)
    # If you don't supply one of these forms, we assume you are
    # specifying the date yourself
    my ($offset);
    if ( !$time || ( lc($time) eq 'now' ) ) {
        $offset = 0;
    }
    elsif ( $time =~ /^\d+/ ) {
        return $time;
    }
    elsif ( $time =~ /^([+-]?(?:\d+|\d*\.\d*))([mhdMy]?)/ ) {
        $offset = ( $mult{$2} || 1 ) * $1;
    }
    else {
        return $time;
    }
    return ( time + $offset );
}

sub header {
    my $self = shift;
    my %args = @_;

    my $type    = $args{-type};
    my $charset = $args{-charset};
    my $expires = $args{-expires};

    push( @header, "Expires: " . expires( $expires, 'http' ) )
      if $expires;
    push( @header, "Date: " . expires( 0, 'http' ) ) if $expires;

    if ( $type && $charset ) {
        $type .= '; charset=' . $charset;
    }
    push @header, "Content-Type: $type" if $type;

    return join( "\n", @header ), "\n\n";
}

sub _parse_params {
    my ( $self, $data ) = @_;
    return () unless defined $data;
    unless ( $data =~ /[&=;]/ ) {

        #$self->{'keywords'} = [ $self->_parse_keywordlist( $data ) ];
        $self->{'keywords'} = [];
        return;
    }
    my @pairs = split /[&;]/, $data;
    for my $pair (@pairs) {
        my ( $param, $value ) = split /=/, $pair, 2;
        next unless defined $param;
        $value = '' unless defined $value;
        $self->_add_param( $self->url_decode($param),
            $self->url_decode($value) );
    }
}

# use correct encoding conversion to handle non ASCII char sets.
# we import and install the complex routines only if we have to.
BEGIN {

    sub url_decode {
        my ( $self, $decode ) = @_;
        return () unless defined $decode;
        $decode =~ tr/+/ /;
        $decode =~ s/%([a-fA-F0-9]{2})/ pack "C", hex $1 /eg;
        return $decode;
    }

    sub url_encode {
        my ( $self, $encode ) = @_;
        return () unless defined $encode;
        $encode =~ s/([^A-Za-z0-9\-_.!~*'() ])/ uc sprintf "%%%02x",ord $1 /eg;
        $encode =~ tr/ /+/;
        return $encode;
    }

}

sub _add_param {
    my ( $self, $param, $value, $overwrite ) = @_;
    return () unless defined $param and defined $value;
    $param =~ tr/\000//d if $self->{'.globals'}->{'NO_NULL'};
    @{ $self->{$param} } = () if $overwrite;
    @{ $self->{$param} } = () unless exists $self->{$param};
    my @values = ref $value ? @{$value} : ($value);
    for my $value (@values) {
        next
          if $value eq ''
          and $self->{'.globals'}->{'NO_UNDEF_PARAMS'};
        $value =~ tr/\000//d if $self->{'.globals'}->{'NO_NULL'};
        $value = Encode::decode( utf8 => $value )
          if $self->{'.globals'}->{PARAM_UTF8};
        push @{ $self->{$param} }, $value;
        unless ( $self->{'.fieldnames'}->{$param} ) {
            push @{ $self->{'.parameters'} }, $param;
            $self->{'.fieldnames'}->{$param}++;
        }
    }
    return scalar @values;    # for compatibility with CGI.pm request.t
}

# from CGI::Simple 1.115
sub script_name { $ENV{'SCRIPT_NAME'} || $0 || '' }
sub server_name { $ENV{'SERVER_NAME'} || 'localhost' }

1;

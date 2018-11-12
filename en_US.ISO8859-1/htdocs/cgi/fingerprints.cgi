#!/usr/bin/perl -T
#
# Display current HTTPS/SSL/TLS certificate fingerprints.
# Should be replaced with something better.
#
# $FreeBSD$

require "./cgi-lib.pl";
require "./cgi-style.pl";
$ENV{PATH} = '/bin:/usr/bin';

# There is an internal post-renew propagation window of about 5-10 minutes.
# However, the script is expensive so we leverage the cache.  The problem
# is that people could come here immediately after a fingerprint mismatch
# so we have to be quick to update.
print "Cache-control: public; max-age=120\n";	# 2 minutes
print &short_html_header("FreeBSD HTTPS/SSL/TLS Server Certificate Fingerprints");

print qq{<h1>FreeBSD HTTPS/SSL/TLS Server Certificate Fingerprints</h1>\n};
print qq{<p>The FreeBSD Project makes use of <a href="https://letsencrypt.org">Let's Encrypt</a> certificates for many of its HTTPS/SSL/TLS services.  These certificates are automatically updated every 60 days.  The current certificate fingerprints of significant services are listed below.</p>\n};

# Note: These are all case sensitive.  Use lower case to match the file names.
&Fingerprint('svn.freebsd.org');
&Fingerprint('download.freebsd.org');
&Fingerprint('pkg.freebsd.org');

print qq{<p>These fingerprints may be helpful in situations where automatic verification is not available.</p>\n};
print &html_footer;
exit 0;

sub Fingerprint
{
    my ($domain) = @_;

    my $message;
    my $sha1, $sha256;
    if ( -e "/etc/clusteradm/acme-certs/$domain.crt" ) {
	$sha1 = `/usr/bin/openssl x509 -fingerprint -noout -sha1 -in /etc/clusteradm/acme-certs/$domain.crt`;
	$sha256 = `/usr/bin/openssl x509 -fingerprint -noout -sha256 -in /etc/clusteradm/acme-certs/$domain.crt`;
	chomp($sha1);
	chomp($sha256);
	$sha1 =~ s/^.*=//;
	$sha256 =~ s/^.*=//;
    } else {
	$sha1 = 'Error';
	$sha256 = 'Error';
    }

    $message = qq{<p>The fingerprints of the current <b>$domain</b> certificate are:</p>\n};
    $message .= qq{<div class="informaltable"><table border="1"><colgroup><col /><col /></colgroup>};
    $message .= qq{<thead><tr><th>Hash</th><th>Fingerprint</th></tr></thead><tbody>};
    $message .= qq{<tr><td>SHA1</td><td><code class="literal">$sha1</code></td></tr>};
    $message .= qq{<tr><td>SHA256</td><td><code class="literal">$sha256</code></td></tr>};
    $message .= qq{</tbody></table></div>\n};

    print $message;
}

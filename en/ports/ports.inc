<!-- $FreeBSD: www/en/ports/ports.inc,v 1.41 1999/09/14 08:21:51 asami Exp $ -->
<p>The FreeBSD Ports and Packages Collection offers a simple way for
users and administrators to install applications.  The ports
collection has been <a
href="http://www.freebsd.org/%7Easami/papers/growth.gif">growing at a
tremendous rate</a>.

<p>Each ``port'' listed here
contains any patches necessary to make the original application source
code compile and run on FreeBSD.  Installing an application is as
simple as downloading the port, unpacking it and typing <tt>make</tt>
in the port directory.  For even greater covenience, you can simply
install the <a href="ftp://ftp.freebsd.org/pub/FreeBSD/branches/-current/ports.tar.gz">
entire ports hierarchy</a> at installation time (or use
<a href="../handbook/synching.html#CVSUP">CVSup</a> to track it on
an ongoing basis) and have thousands of applications right at your
fingertips.

Each port's <tt>Makefile</tt> automatically fetches the
application source code, either from a local disk, CDROM or via ftp,
unpacks it on your system, applies the patches, and compiles.  If
all went well, a simple <tt>make install</tt> will install the
application and register it with the package system.</p>

<p>For most ports, a precompiled <tt>package</tt> also exists, saving
the user the work of having to compile anything at all.  Each port
contains a link to its corresponding package and you may either simply
download that file and then run the <strong>pkg_add</strong> command
on it or you can simply grab the link location and hand it straight
to <strong>pkg_add</strong> since it's capable of accepting FTP URLs as
well as filenames.</p>

<p>For more information about using ports, see <a
href="../handbook/ports.html">The ports collection</a>.  For
information about creating new ports, see <a
href="../handbook/porting.html">Porting applications</a>.  Both are
part of the <a href="../handbook/">FreeBSD Handbook</a>.</p>

<p>The ports listed on these web pages are continually being updated.
The current ports tree officially supports only FreeBSD-current and
FreeBSD-stable.
Consequently, you may need to update a few files on your FreeBSD system 
to make use of ports developed after your version of FreeBSD was released.
Please install one of the following depending on the release you are
running.  Also, if you are running FreeBSD-stable or FreeBSD-current
that is more than a few days old, you are recommended to install an
appropriate upgrade kit as well; the ports system is changing very
fast at times.

<dl>
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/221upgrade.tgz">2.2.1
to 2.2-stable upgrade kit</a>
<dd>For users of 2.2.1-release or
2.2-stable between 2.2.1-release and 2.2.2-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/222upgrade.tgz">2.2.2
to 2.2-stable upgrade kit</a>
<dd>For users of 2.2.2-release or
2.2-stable between 2.2.2-release and 2.2.5-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/225upgrade.tgz">2.2.5
to 2.2-stable upgrade kit</a>
<dd>For users of 2.2.5-release or
2.2-stable between 2.2.5-release and 2.2.6-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-2.2-stable/Latest/227upgrade.tgz">2.2.7
to 2.2-stable upgrade kit</a>
<dd>For users of 2.2.6-release, 2.2.7-release, 2.2.8-release or
2.2-stable after 2.2.6-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-3-stable/Latest/30upgrade.tgz">3.0
to 3-stable upgrade kit</a>
<dd>For users of 3.0-release or 3.0-stable after 3.0-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-3-stable/Latest/31upgrade.tgz">3.1
to 3-stable upgrade kit</a>
<dd>For users of 3.1-release or 3.1-stable after 3.1-release
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-3-stable/Latest/32upgrade.tgz">3.2
to 3-stable upgrade kit</a>
<dd>For users of 3.2-release or 3.2-stable after 3.2-release
</dl>

<p>These
are FreeBSD packages; please use <strong>pkg_add</strong> to install them.  That
should enable you to use all the ports listed here.  Note that it will
only change just enough files to enable ports/packages to be used; for
a full upgrade to 3-stable, please refer to the <a
href="../handbook/synching.html">synchronizing your source tree</a>
section of the handbook.  A full upgrade is recommended, especially if
you are still using anything earlier than 2.2.7-release.  Also, the
2.2.X line is now officially unsupported by ports-current; you are `on
your own' if you wish to use the ports listed here, as opposed to the
ones that were included in the release, on your 2.2.X system.</p>

<p>Many of the ports require the X Window System to compile and run.
We compile and test our ports on <a
href="http://www.xfree86.org/">XFree86</a>. Their current release is
3.3.5.  Some ports may not work with older releases.</p>

<p>For more information about new, changed or removed ports/packages,
or if you wish to search for a specific application to see if it's
available as a port/package, please see the 
<a href="http://www.freebsd.org/cgi/ports.cgi">FreeBSD Ports Changes</a>
page.</p>

<FORM METHOD="GET" ACTION="http://www.freebsd.org/cgi/ports.cgi">
Search for:
<INPUT NAME="query" VALUE="">
<SELECT NAME="stype">
<OPTION VALUE="all">All</OPTION>
<OPTION VALUE="name">Package Name</OPTION>
<OPTION VALUE="text">Description</OPTION>
</SELECT>
<INPUT TYPE="submit" VALUE="Submit">
</FORM>


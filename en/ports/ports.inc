<!-- $FreeBSD: www/en/ports/ports.inc,v 1.53 2001/01/20 23:03:36 will Exp $ -->
<p>The FreeBSD Ports and Packages Collection offers a simple way for
users and administrators to install applications.  The ports
collection has been <a
href="http://www.freebsd.org/%7Easami/papers/growth.gif">growing at a
tremendous rate</a>.
</p>

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


<p>For more information about using ports, see <a
href="../handbook/ports.html">The ports collection</a>, a
section of the <a href="../handbook/">FreeBSD Handbook</a>.  For
information about creating new ports, see <a
href="../porters-handbook/">Porting applications</a>.</p> 

<hr>

<H1 ALIGN="LEFT"><FONT COLOR="#660000">Upgrade kits</FONT></H1>

<p>
The ports listed on these web pages are continually being updated.
It is recommended that you refresh the entire collection together, as
many ports depend on other parts of the tree.  If that is not
possible, at least make sure you get the latest make macro files in
<tt>ports/Mk</tt>.  (If you are using <strong>cvsup</strong>, this
means you need <tt>ports-base</tt> in your cvsupfile.)  If you still
see errors even with the latest <tt>bsd.port.mk</tt> and friends,
please fetch the entire collection.
</p>

<p>
The current ports tree officially supports only FreeBSD-current and
FreeBSD-stable.

Consequently, you may need to update a few files on your FreeBSD system 
to make use of ports developed after your version of FreeBSD was released.
Please install one of the following depending on the release you are
running.  If your system is newer than any of the packages listed below,
you do not need an upgrade package.  If your system is older than 4.0-RELEASE,
or is running any branch before 4.0, your only reasonable choice for using
ports-current is to upgrade to some point along the 4.x branch.
</p>

<dl>
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-4-stable/Latest/40upgrade.tgz">4.0
to 4-STABLE upgrade kit</a>
<dd>For users of 4.0-RELEASE or 4.x-STABLE before June 4, 2000
<dt><a
href="ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-4-stable/Latest/41upgrade.tgz">4.1
to 4-STABLE upgrade kit</a>
<dd>For users of 4.1-RELEASE or 4.x-STABLE before January 8, 2001
</dl>

<p>
These are FreeBSD packages; please use <strong>pkg_add</strong> to install
them.  That should enable you to use all the ports listed here.  It is important
to note that 4.0-RELEASE counts as "4.x-STABLE before January 8, 2001", i.e.
if you are running 4.0-RELEASE or 4.x-STABLE before June 4, 2000, you will need
both the "4.0 to 4-STABLE upgrade kit" and the "4.1 to 4-STABLE upgrade kit".  Note
that it will only change just enough files to enable ports/packages to be used;
for a full upgrade to -STABLE, please refer to the <a
href="../handbook/synching.html">synchronizing your source tree</a>
section of the handbook.

The 3.x branch is fast approaching obsolescence as far as ports-current is
concerned, and support for the branch will probably be dropped entirely as
soon as 4.3-RELEASE is rolled.

The 2.2.x branch is officially unsupported by ports-current.  While the
ports tree as distributed with previous releases will probably work well
these are also unsupported by the ports team, because time is already
stretched thin enough supporting ports-current.
</p>

<p>Many of the ports require the X Window System to compile and run.
We compile and test our ports on <a
href="http://www.xfree86.org/">XFree86</a>. Their current release is
3.3.6.  Some ports may not work with older releases.</p>


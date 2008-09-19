<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Summer Projects">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.developers "INCLUDE">
<!ENTITY % developers SYSTEM "../developers.sgml"> %developers;
]>

<!-- $FreeBSD: www/en/projects/summerofcode.xsl,v 1.14 2008/04/22 09:07:09 murray Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:param name="ideas.xml" select="'ideas/ideas.xml'" />

  <xsl:output type="html" encoding="&xml.encoding;"/>

  <xsl:template match="ideas">
    <html>
      &header1;
      <body>

	<div id="CONTAINERWRAP">
	  <div id="CONTAINER">
	    &header2;

	    <div id="CONTENT">
              <div id="SIDEWRAP">
                &nav;
              </div> <!-- SIDEWRAP -->

	      <div id="CONTENTWRAP">
		&header3;

<p>The FreeBSD Project is pleased to participate as a mentoring
  organization in the <a
  href="http://code.google.com/summerofcode.html">Google Summer of
  Code</a> 2008.  This program funds students to contribute to an open
  source project over the summer break.  We have had over 70 successful
  students working on FreeBSD as part of this program in <a
  href="&base;/projects/summerofcode-2005.html">2005</a>, <a
  href="&base;/projects/summerofcode-2006.html">2006</a>, <a
  href="&base;/projects/summerofcode-2007.html">2007</a>. and <a
  href="&base;/projects/summerofcode-2008.html">2008</a>.</p>

<ul>
  <li><a href="#benefits">Benefits of Participating</a></li>
  <li><a href="#current">Current Student Projects</a></li>
  <li><a href="#students">Past Student Projects</a></li>
  <li><a href="#ideas">Example Proposal Ideas</a></li>
  <li><a href="#mentors">Possible Mentors</a></li>
  <li><a href="#infrastructure">Infrastructure Provided to Students</a></li>
  <li><a href="#faq">Frequently Asked Questions</a></li>
</ul>

<a name="benefits"></a>
<h2>Benefit of Participating</h2>

<p>Google Summer of Code is an exciting opportunity for students to
  "intern" with an open source project for a summer.  The FreeBSD
  Project, as one of the most successful and oldest open source projects,
  is an excellent place to do this internship.  Founded in 1993, the
  project now consists of several hundred "committers" and tens of
  thousands of contributors.  FreeBSD is the foundation for many
  commercial products, including Apple's Mac OS X, NetApp's OnTap/GX,
  Juniper's JunOS, as well countless other products, and is widely used
  in the Internet Service Provider and corporate IT worlds.  Many of
  these sponsors participate daily in the FreeBSD community, and students
  have the opportunity to develop software ideas in an exciting
  environment with many real world applications, and under the mentorship
  of experienced developers.</p>

<p>After the summer ends, many of our students are sponsored by Google or
  the FreeBSD Foundation to attend operating systems and open source
  conferences to present on their work, and a significant number go on to
  become FreeBSD developers.  It's also a great job networking
  opportunity!</p>
 
<a name="current"></a>
<h2>Current Student Projects</h2>

<p>We've recently <a
  href="&base;/projects/summerofcode-2008.html">announced</a> the
  successful students from the Summer of Code 2008.</p>

<a name="students"></a>
<h2>Past Student Projects</h2>

<p>For a complete list of student projects from previous years,
visit:</p>
<ul>
  <li><a href="&base;/projects/summerofcode-2008.html">Summer of Code 2008 FreeBSD
  Projects Summary</a></li>
  <li><a href="&base;/projects/summerofcode-2007.html">Summer of Code 2007 FreeBSD
  Projects Summary</a></li>
  <li><a href="&base;/projects/summerofcode-2006.html">Summer of Code 2006 FreeBSD
  Projects Summary</a></li>
  <li><a href="&base;/projects/summerofcode-2005.html">Summer of Code 2005 FreeBSD
  Projects Summary</a></li>
</ul>

<p>See also our wiki pages for student projects [<a
href="http://wiki.freebsd.org/moin.cgi/SummerOfCode2008">2008</a>,
<a
href="http://wiki.freebsd.org/moin.cgi/SummerOfCode2007">2007</a>,
<a
href="http://wiki.freebsd.org/moin.cgi/SummerOfCode2006">2006</a>, and 
<a
href="http://wiki.freebsd.org/moin.cgi/SummerOfCode2005">2005</a>].</p>

<a name="ideas"></a>
<h2>Example Proposal Ideas</h2>

  <p>The application period for this year has closed, but students and
    interested developers can always find interesting work that needs
    to be done on the <a
    href="&base;/projects/ideas/index.html">FreeBSD Project Ideas</a>
    list.</p>

  <p>For additional ideas about upcoming development projects in
    FreeBSD, take a look at recent <a
    href="&base;/news/status">Developer Status Reports</a>.</p>

<a name="mentors"></a>
<h2>Mentors</h2>
 
<p>A number of FreeBSD committers are willing to mentor students.  A
  good place to start is the 'Technical contacts' listed with the
  example projects on the <a
  href="&base;/projects/ideas/index.html">Ideas page</a>.</p>

<a name="infrastructure"></a>
<h2>Infrastructure Provided to Students</h2>

<p>In previous years, the FreeBSD Project provided access to the FreeBSD
  Perforce revision control infrastructure in order to facilitate
  student collaboration, provide public access and archiving for the
  on-going student projects, and to help mentors and the community
  monitor on-going work.  It is expected that students participating
  in future programs will be offered the same facilities.  Students
  will also be asked to maintain wiki pages on their on-going
  projects.  In the past, e-mail, IRC, and instant messaging have
  proven popular among students and mentors, and students
  participating in the FreeBSD summer program are encouraged to use
  these and other electronic communication mechanisms to become active
  in the community.</p>

<a name="faq"></a>
<h2>Frequently Asked Questions</h2>

<ul>
  <li><p><strong>I wasn't selected for funding by Google as part of the Google Summer of Code, can I still participate?</strong></p>

    <p>Yes!  By all means.  Each year we have many more talented
      student applications that there are available places and we are
      very happy when students choose to get involved with FreeBSD.
      Please mail soc-mentors@FreeBSD.org about how to proceed with
      your project.</p></li>

  <li><p><strong>What projects were completed successfully by students
    last summer?</strong></p>

    <p>Please see the <a href="summerofcode-2008.html">2008 FreeBSD
      Summer of Code</a> page, as well as older project pages from <a
      href="summerofcode-2007.html">2007</a>, <a
      href="summerofcode-2006.html">2006</a>, and <a
      href="summerofcode-2005.html">2005</a> for a list of the
      completed projects from previous years.</p></li>

</ul>

	      </div> <!-- CONTENTWRAP -->
	      <br class="clearboth" />
	    </div> <!-- CONTENT -->

            <div id="FOOTER">
               &copyright;<br />
               &date;
            </div> <!-- FOOTER -->
        </div> <!-- CONTAINER -->
   </div> <!-- CONTAINERWRAP -->

      </body>
</html>
  </xsl:template>
</xsl:stylesheet>

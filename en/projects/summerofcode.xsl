<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Summer Projects">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.developers "INCLUDE">
<!ENTITY % developers SYSTEM "../developers.sgml"> %developers;
]>

<!-- $FreeBSD: www/en/projects/summerofcode.xsl,v 1.8 2007/09/17 20:22:56 murray Exp $ -->

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
  source project over the summer break.  We have had over 50 successful
  students working on FreeBSD as part of this program in <a
  href="&base;/summerofcode-2005.html">2005</a>, <a
  href="&base;/summerofcode-2006.html">2006</a>, and <a
  href="&base;/summerofcode-2007.html">2007</a>.</p>

<ul>
  <li><a href="#students">Past Student Projects</a></li>
  <li><a href="#ideas">Example Proposal Ideas</a></li>
  <li><a href="#mentors">Possible Mentors</a></li>
  <li><a href="#proposals">Proposal Guidelines</a></li>
  <li><a href="#infrastructure">Infrastructure Provided to Students</a></li>
  <li><a href="#faq">Frequently Asked Questions</a></li>
</ul>
 
<a name="students"></a>
<h2>Past Student Projects</h2>

<p>For a complete list of student projects from previous years,
visit:</p>
<ul>
  <li><a href="&base;/projects/summerofcode-2007.html">Summer of Code 2007 FreeBSD
  Projects Summary</a></li>
  <li><a href="&base;/projects/summerofcode-2006.html">Summer of Code 2006 FreeBSD
  Projects Summary</a></li>
  <li><a href="&base;/projects/summerofcode-2005.html">Summer of Code 2005 FreeBSD
  Projects Summary</a></li>
</ul>

<p>See also our wiki pages for student projects [<a
href="http://wiki.freebsd.org/moin.cgi/SummerOfCode2007">2007</a>,
<a
href="http://wiki.freebsd.org/moin.cgi/SummerOfCode2006">2006</a>, and 
<a
href="http://wiki.freebsd.org/moin.cgi/SummerOfCode2005">2005</a>].</p>

<a name="ideas"></a>
<h2>Example Proposal Ideas</h2>

  <p>The following example project ideas are a subset of the general
    <a href="&base;/projects/ideas/index.html">FreeBSD Project
    Ideas</a> list that we think are the most suitable for Summer of
    Code projects.</p>

  <xsl:for-each select="document($ideas.xml)//descendant::category[child::idea[@class='soc']]">
    <h3><xsl:value-of select="title"/></h3>

    <ul>
      <xsl:for-each select="idea[@class='soc']">
      <li><xsl:element name="a">
        <xsl:attribute name="href">
	./ideas/index.html#p-<xsl:value-of select="@id" />
        </xsl:attribute>
        <xsl:value-of select="title" />
        </xsl:element>
      </li>
      </xsl:for-each>
    </ul>
  </xsl:for-each>
 
  <p>For additional ideas about upcoming development projects in
    FreeBSD, take a look at recent <a
    href="&base;/news/status">Developer Status Reports</a>.</p>

<a name="mentors"></a>
<h2>Mentors</h2>
 
<p>A number of FreeBSD committers are willing to mentor students this
  year.  A good place to start is the 'Technical contacts' listed with
  the example projects on the <a
  href="&base;/projects/ideas/index.html">Ideas page</a>.  In addition
  to those specific projects, the following mentors are willing to
  work with students in any of the broad areas listed below.</p>

<p><em>Coming soon.</em></p>

<a name="proposals"></a>
<h2>Proposal Guidelines</h2>

<p>Students are responsible for writing a proposal and submitting it
  to Google before the application deadline.  The following outline
  was adapted from the Perl Foundation <a
  href="http://www.perlfoundation.org/gc/grants/proposals.html">open
  source proposal HOWTO</a>.  A strong proposal will include:</p>

  <ul>
    <li><strong>Name</strong></li>

    <li><strong>Email</strong></li>

    <li><strong>Project Title</strong></li>

    <li><strong>Possible Mentor</strong> <em>(optional)</em></li>

    <li><strong>Benefits to the FreeBSD Community</strong> - a good
      project will not just be fun to work on, but also generally
      useful to others.</li>

    <li><strong>Deliverables</strong> - It is very important to list
  quantifiable results here e.g. 
      <ul>
        <li>"Improve X modules in ways Y and Z."</li>
        <li>"Write 3 new man pages for the new interfaces."</li>
        <li>"Improve test coverage by writing X more unit/regression
        tests."</li>
        <li>"Improve performance in FOO by X%."</li>
      </ul>
    </li>

    <li><strong>Project Schedule</strong> - How long will the project
      take? When can you begin work?</li>

    <li><strong>Availability</strong> - How many hours per week can
      you spend working on this?  What other obligations do you have
      this summer?</li>

    <li><strong>Bio</strong> - Who are you? What makes you the best
      person to work on this project?</li>
  </ul>

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
  <li><p><strong>Am I eligible?</strong></p>

    <p>Please see the Google Summer of Code 2008 <a
      href="http://code.google.com/opensource/gsoc/2008/faqs.html#0.1_eligibility">FAQ</a>
      for all questions about eligibility.</p></li>

  <li><p><strong>Where can I find more information about being a
      student or mentor in this program?</strong></p>

    <p>Please see the program wiki <a
      href="http://code.google.com/p/google-summer-of-code/">here</a>.</p></li>

  <li><p><strong>When does the application period begin?</strong></p>

    <p>March 24, 2008.</p></li>

  <li><p><strong>When does the application period end?</strong></p>

    <p>March 31, 2008 5:00PM PDT (April 1 0:00 UTC).  Note, however
      that you should apply several days before the deadline in case
      your potential mentor wants to clarify anything in your
      application or offer additional guidance.</p></li>

  <li><p><strong>Where do I send my proposal?</strong></p>

    <p>Proposals must be sent directly to Google when the application
      period begins.</p></li>

  <li><p><strong>What projects were completed successfully by students
    last summer?</strong></p>

    <p>Please see the <a href="summerofcode-2007.html">2007 FreeBSD
      Summer of Code</a> page, as well as older project pages from <a
      href="summerofcode-2006.html">2006</a> and <a
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

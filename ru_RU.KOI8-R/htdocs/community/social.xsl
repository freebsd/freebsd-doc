<?xml version="1.0" encoding="KOI8-R" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "���������� ���� FreeBSD">
<!ENTITY email "freebsd-www">
<!ENTITY % navinclude.community "INCLUDE">
]>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$

     Original revision: 1.6
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:output method="xml" encoding="&xml.encoding;"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

  <xsl:template match="events">
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

	      <p>&os; ������������ � ��������� ���������� �����.</p>

	      <ul>

	        <li>������ ������������� �������� ����� 30,000
	        ���������� ��� ������� ������ '<a
	        href="http://del.icio.us/tag/freebsd">freebsd</a>'
	        �� <a href="http://del.icio.us">del.icio.us</a>.</li>

		<li>������ ���������� �� ������ ����� �������������,
		����������� � ��������� �������� ������ '<a
		href="http://flickr.com/search/?z=t&amp;ss=2&amp;w=all&amp;q=freebsd&amp;m=text">freebsd</a>'
		�� <a href="http://www.flickr.com">flickr</a>.</li>

		<li>����� ������������ � �����������,
		����������� � ������������, ��������� � <a
		href="http://www.youtube.com/results?search_query=freebsd&amp;search_type=&amp;aq=f">FreeBSD</a>,
		�� <a href="http://www.youtube.com">YouTube</a>. � ���������, ��� �� �������� ����� <a href="http://www.youtube.com/bsdconferences">BSD Conferences</a>, ���������� ����� 1 ���� ������� �����������, ��������� �� ����������� ������������ FreeBSD.</li>

		<li><a
		href="http://www.facebook.com/home.php#/group.php?gid=2204657214">
		������ ������������� FreeBSD</a> �� <a
		href="http://www.facebook.com">Facebook</a> � <a href="http://www.linkedin.com/groups?gid=47628">������ FreeBSD</a> �� <a href="http://www.linkedin.com">LinkedIn</a>.</li>

		<li>�� ������ ������� �� <a
		href="http://twitter.com/freebsdannounce">@freebsdannounce</a>,
		<a
		href="http://twitter.com/freebsdblogs">@freebsdblogs</a>,
		<a href="http://twitter.com/freebsd">@freebsd</a> ���
		<a href="http://twitter.com/bsdevents">@bsdevents</a>
		�� <a href="http://twitter.com">Twitter</a>.</li>

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

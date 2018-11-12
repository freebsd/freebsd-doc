<?xml version="1.0" encoding="euc-jp"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd">
<!-- $FreeBSD$ -->
<!-- The FreeBSD Japanese Documentation Project -->
<!-- Original revision: r39141 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/share/sgml/libcommon.xsl"/>

  <!-- default format for date string -->
  <xsl:param name="param-l10n-date-format-YMD"
             select="'%Y ǯ %M %D ��'" />
  <xsl:param name="param-l10n-date-format-YM"
             select="'%Y ǯ %M'" />
  <xsl:param name="param-l10n-date-format-MD"
             select="'%M %D ��'" />

  <!-- template: "html-usergroups-list-regions"
       list all regions in a usergroup database -->

  <xsl:key name="html-usergroups-regions-key" match="entry" use="../../@name" />
  <xsl:key name="html-usergroups-id-key" match="entry" use="@id" />

  <xsl:template name="html-usergroups-map">
    <xsl:param name="mapurl" select="'none'" />

    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="$mapurl" />
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template name="html-usergroups-list-regions">
    <xsl:param name="usergroups.xml" select="'usergroups.xml'" />

    <ul>
      <xsl:for-each select="document($usergroups.xml)//continent">
      <xsl:sort select="format-number(count(country/entry), '000')"
      		order="descending"/>

	<xsl:variable name="id" select="
	  translate(@name,
	  ' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ',
	  '--abcdefghijklmnopqrstuvwxyz')" />

	<li>
	  <p><xsl:element name="a">
	      <xsl:attribute name="href">
		<xsl:value-of select="concat('#', $id)" />
	      </xsl:attribute>

	      <xsl:call-template name="transtable-lookup">
		<xsl:with-param name="word-group" select="'continents'" />
		<xsl:with-param name="word" select="@name" />
	      </xsl:call-template>
	    </xsl:element>
	    ( <xsl:value-of select="count(country/entry)" /> �桼�����롼��)</p>
	</li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <!-- template: "html-usergroups-list-header"
       print header part of usergroup listing (l10n) -->

  <xsl:template name="html-usergroups-list-header">
    <p>FreeBSD �Ϲ����Ȥ��Ƥ��ꡢ������ˤ�������Υ桼�����롼�פ�����ޤ���</p>
    <p>���Υꥹ�Ȥ˺ܤäƤ��ʤ��桼�����롼�פ�¸�ΤǤ����顢
      ���ҡ�<a href="http://www.freebsd.org/ja/send-pr.html">�㳲���</a
	> �� www ���ƥ����Ȥäưʲ��ξ�����Τ餻����������</p>
    <ol>
      <li>�桼�����롼�פΥ����֥����Ȥ� URL</li>
      <li>ˬ��Ԥȥ����֥����Ȥδ����Τ���ˡ�ô���Ԥ�Ϣ����Υ᡼�륢�ɥ쥹</li>
      <li>�桼�����롼�פδ�ñ�� (�������) �Ҳ�ʸ</li>
    </ol>

    <p>���� HTML �����Ǥ��ꤤ���ޤ���
      FreeBSD �Υݥꥷ�����顢
      ��ȯ�ʥ桼�����롼�פγ�ư�θ����Ϲ��ޤ������ȤǤ���
      �᤯�˥桼�����롼�פ��ʤ���С����� <a
	href="http://bsd.meetup.com/">http://bsd.meetup.com/</a>
      ��Ȥäƶ��ˤ��붽̣����äƤ���Ŀͤ򸫤Ĥ���
      �桼�����롼�פ��äƤ���������</p>

    <h3>�ϰ�</h3>
  </xsl:template>

  <!-- template: "html-news-list-newsflash-preface" -->
  <xsl:template name="html-news-list-newsflash-preface">
    <img src="&enbase;/gifs/news.jpg" align="right" border="0" width="193"
      height="144" alt="FreeBSD News"/>

    <p>FreeBSD �ϵ�®��ȯŸ��³���륪�ڥ졼�ƥ��󥰥����ƥ�ʤΤǡ�
      �ǿ��ο���ˤĤ��ƹԤ��Τ����ݤˤʤ��������ޤ���͡�
      �����̤ˤʤ뤿��ˡ����Υڡ��������Ū�˥����å�����褦�ˤ��ޤ��礦���ޤ���
      <a href="http://lists.freebsd.org/mailman/listinfo/freebsd-announce">freebsd-announce
	�᡼��󥰥ꥹ��</a> �� <a href="&base;/news/rss.xml">RSS �ե�����</a>
      ����ɤ������Ȥ������⤤�뤫�⤷��ޤ���͡�</p>

    <p>���줾��Υץ������Ȥκǿ�����ϡ����γƥ����֥ڡ�����������������</p>

    <ul>
      <li><a href="&base;/java/newsflash.html">&java; on FreeBSD</a></li>
      <li><a href="http://freebsd.kde.org/">KDE on FreeBSD</a></li>
      <li><a href="&enbase;/gnome/newsflash.html">GNOME on FreeBSD</a></li>
    </ul>

    <p>�����ߡ������ƾ���Υ�꡼���ξܺ٤ˤĤ��Ƥϡ�
      <a href="&base;/releases/index.html">��꡼������</a>
      �Υڡ�����������������</p>

    <p>FreeBSD �������ƥ�����䥻�����ƥ�����ΰ����ˤĤ��Ƥϡ�
      <a href="&base;/security/">�������ƥ�����</a>
      �Υڡ�����������������</p>
  </xsl:template>

  <!-- template: "html-news-list-newsflash-homelink" -->
  <xsl:template name="html-news-list-newsflash-homelink">
    <a href="&base;/news/news.html">�˥塼���ڡ���</a>
  </xsl:template>

  <xsl:template name="html-news-make-olditems-list">
    <p>���Υ˥塼��:
      <a href="&enbase;/news/2009/index.html">2009</a>,
      <a href="&enbase;/news/2008/index.html">2008</a>,
      <a href="&enbase;/news/2007/index.html">2007</a>,
      <a href="&enbase;/news/2006/index.html">2006</a>,
      <a href="&enbase;/news/2005/index.html">2005</a>,
      <a href="&enbase;/news/2004/index.html">2004</a>,
      <a href="&enbase;/news/2003/index.html">2003</a>,
      <a href="&enbase;/news/2002/index.html">2002</a>,
      <a href="2001/index.html">2001</a>,
      <a href="&enbase;/news/2000/index.html">2000</a>,
      <a href="&enbase;/news/1999/index.html">1999</a>,
      <a href="&enbase;/news/1998/index.html">1998</a>,
      <a href="1997/index.html">1997</a>,
      <a href="1996/index.html">1996</a>,
      <a href="&enbase;/news/1993/index.html">1993</a></p>
  </xsl:template>

  <!-- template: "html-news-list-press-preface" -->
  <xsl:template name="html-news-list-press-preface">
    <p>�����˺ܤäƤ��ʤ� FreeBSD �˴�Ϣ�����˥塼��������¸���ʤ顢
      �桹�������˺ܤ�����褦�˾ܺ٤�
      <a href="mailto:www@freebsd.org">www@FreeBSD.org</a> �ޤ�
      (�Ѹ��) ���äƤ���������</p>
  </xsl:template>

  <!-- template: "html-press-make-olditems-list" -->
  <xsl:template name="html-press-make-olditems-list">
    <p>���Υ˥塼������:
      <a href="&enbase;/news/2009/press.html">2009</a>,
      <a href="&enbase;/news/2008/press.html">2008</a>,
      <a href="&enbase;/news/2007/press.html">2007</a>,
      <a href="&enbase;/news/2006/press.html">2006</a>,
      <a href="&enbase;/news/2005/press.html">2005</a>,
      <a href="&enbase;/news/2004/press.html">2004</a>,
      <a href="&enbase;/news/2003/press.html">2003</a>,
      <a href="&enbase;/news/2002/press.html">2002</a>,
      <a href="&base;/news/2001/press.html">2001</a>,
      <a href="&enbase;/news/2000/press.html">2000</a>,
      <a href="&enbase;/news/1999/press.html">1999</a>,
      <a href="&enbase;/news/1998/press.html">1998-1996</a></p>
  </xsl:template>

  <!-- for l10n -->
  <xsl:template name="html-news-month-headings">
    <xsl:param name="year" />
    <xsl:param name="month" />

    <xsl:value-of select="concat($year, ' ǯ ', $month)" />
  </xsl:template>

  <xsl:template name="html-events-list-preface">
    <p>�����˺ܤäƤ��ʤ� FreeBSD �˴�Ϣ�������٥�Ȥ䡢
      FreeBSD �桼������̣���������ʥ��٥�Ȥ�¸���ʤ顢
      �桹�������˺ܤ�����褦�˾ܺ٤�
      <a href="mailto:www@freebsd.org">www@FreeBSD.org</a> �ޤ�
      (�Ѹ��) ���äƤ���������</p>

    <p>iCalendar �������б������������塼��������եȥ�������ȤäƤ���ʤ顢
      �����˺ܤäƤ��뤹�٤ƤΥ��٥�Ȥ򽸤᤿
      <a href="&base;/events/events.ics">FreeBSD ���٥�ȥ�����</a>
      �����ѤǤ��ޤ���</p>
  </xsl:template>

  <xsl:template name="html-events-map">
    <xsl:param name="mapurl" select="'none'" />

    <p>���� FreeBSD �˴�Ϣ�������٥�Ȥ򳫺Ť������ϰ�ϡ�
      �ʲ����Ͽޤˤ����ư��ֿ����ɤ��Ƥ��ޤ���
      ���� FreeBSD �˴�Ϣ�������٥�Ȥ򳫺Ť�����ϲ����䥪��󥸿����ɤ��Ƥ��ޤ���
      ���Ť������ɤ�줿�ϰ�ۤɲ���¿���Υ��٥�Ȥ򳫺Ť��Ƥ��ޤ���</p>

    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="$mapurl" />
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template name="html-events-list-upcoming-heading">
    <h2 id="upcoming">���߳����桢�ޤ��Ϻ��峫��ͽ��Υ��٥��</h2>
  </xsl:template>

  <xsl:template name="html-events-list-past-heading">
    <h2 id="past">���Υ��٥��</h2>
  </xsl:template>

  <!-- Generate a date interval. -->
  <!-- Sample: 27 November, 2002 - 29 December, 2003 -->
  <xsl:template name="gen-date-interval">
    <xsl:param name="startdate"/>
    <xsl:param name="enddate"/>

    <xsl:value-of select="startdate/year"/>
    <xsl:text> ǯ </xsl:text>
    <xsl:value-of select="startdate/month"/>
    <xsl:text> �� </xsl:text>
    <xsl:value-of select="startdate/day"/>

    <xsl:if test="number(startdate/month) != number(enddate/month) or
		  number(startdate/day) != number(enddate/day) or
		  number(startdate/year) != number(enddate/year)">

      <xsl:if test="number(startdate/month) != number(enddate/month) or
		    number(startdate/year) != number(enddate/year)">
	<xsl:text> ��</xsl:text>
      </xsl:if>

      <xsl:text> - </xsl:text>

      <xsl:if test="number(startdate/year) != number(enddate/year)">
	<xsl:value-of select="enddate/year"/>
	<xsl:text> ǯ </xsl:text>
      </xsl:if>

      <xsl:if test="number(startdate/month) != number(enddate/month) or
		    number(startdate/year) != number(enddate/year)">
	<xsl:value-of select="enddate/month"/>
	<xsl:text> ��</xsl:text>
      </xsl:if>

      <xsl:if test="number(startdate/day) != number(enddate/day) or
		    number(startdate/month) != number(enddate/month) or
		    number(startdate/year) != number(enddate/year)">
	<xsl:text> </xsl:text>
	<xsl:value-of select="enddate/day"/>
	<xsl:text> ��</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:if test="number(startdate/month) = number(enddate/month) and
		  number(startdate/day) = number(enddate/day) and
		  number(startdate/year) = number(enddate/year)">
      <xsl:text> ��</xsl:text>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="EUC-JP" ?>

<!-- $FreeBSD: www/ja/news/newsflash.xsl,v 1.7 2002/05/19 18:10:49 hrs Exp $ -->
<!-- Original revision: 1.8 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS">

  <xsl:import href="../includes.xsl"/>
  <xsl:import href="includes.xsl"/>


  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="enbase" select="'../..'"/>
  <xsl:variable name="title" select="'FreeBSD News Flash'"/>
  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>
  
  <xsl:output type="html" encoding="EUC-JP"/>

  <xsl:template match="news">
    <html>
      
      <xsl:copy-of select="$header1"/>

      <body xsl:use-attribute-sets="att.body">

	<xsl:copy-of select="$header2"/>

	<!-- Notice how entity references in SGML become variable references
	     in the stylesheet, and that the syntax for referring to variables
	     inside an attribute is "{$variable}".

	     This is just dis-similar enough to Perl and the shell that you
	     end up writing ${variable} all the time, and then scratch your 
	     head wondering why the stylesheet isn't working.-->

	<!-- Also notice that because this is now XML and not SGML, empty
             elements, like IMG, must have a trailing "/" just inside the 
   	     closing angle bracket, like this " ... />" -->
	<img src="{$base}/../gifs/news.jpg" align="right" border="0" width="193"
	     height="144" alt="FreeBSD News"/>

	<p>FreeBSD は急速に発展を続けるオペレーティングシステムなので、
	  最新の進歩について行くのが面倒になる時がありますよね。
	  情報通になるために、このページを定期的にチェックするようにしましょう。
	  <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/eresources.html#ERESOURCES-MAIL">
	    freebsd-announce メーリングリスト</a>を購読するとよいかも知れません。</p>

        <p>それぞれのプロジェクトの最新情報は、次の各ウェブページをご覧ください。</p>

        <ul>
          <li><a href="{$base}/ja/java/newsflash.html"><xsl:value-of select="$java"/> on FreeBSD</a></li>
          <li><a href="http://freebsd.kde.org/">KDE on FreeBSD</a></li>
          <li><a href="{$base}/ja/gnome/newsflash.html">GNOME on FreeBSD</a></li>
        </ul>

	<p>過去、現在、そして将来のリリースの詳細については、
	  <strong><a href="{$base}/releases/index.html">リリース情報</a>
	  </strong>
	  のページをご覧ください。</p>
	
	<p>FreeBSD セキュリティ勧告については、<a href="{$base}/security/#adv">
	  セキュリティ情報</a> のページをご覧ください。</p>
	
	<xsl:apply-templates select="descendant::month"/>
	
	<p>Older announcements:
	  <a href="../../2001/index.html">2001</a>,
	  <a href="2000/index.html">2000</a>,
	  <a href="1999/index.html">1999</a>,
	  <a href="1998/index.html">1998</a>,
	  <a href="1997/index.html">1997</a>,
	  <a href="1996/index.html">1996</a></p>
	
	<xsl:copy-of select="$newshome"/>
	<xsl:copy-of select="$footer"/>
      </body>
    </html>
  </xsl:template>

  <!-- Everything that follows are templates for the rest of the content -->
  
  <xsl:template match="month">
    <h1><xsl:value-of select="ancestor::year/name"/>
      <xsl:text>年 </xsl:text>
      <xsl:value-of select="name"/> 月</h1>

    <ul>
      <xsl:apply-templates select="descendant::day"/>
    </ul>
  </xsl:template>

  <xsl:template match="day">
    <xsl:apply-templates select="event"/>
  </xsl:template>

  <xsl:template match="event">
    <li><p><a>
	  <xsl:attribute name="name">
	    <xsl:call-template name="generate-event-anchor"/>
	  </xsl:attribute>
	</a>

	<b><xsl:value-of select="format-number(number(ancestor::year/name),'0000')"/>/<xsl:value-of select="format-number(number(ancestor::month/name),'00')"/>/<xsl:value-of select="format-number(number(ancestor::day/name),'00')"/>:</b><xsl:text> </xsl:text>
	<xsl:apply-templates select="p"/>
	</p>

    </li>
  </xsl:template>

  <xsl:template match="date"/>    <!-- Deliberately left blank -->

  <!-- When the href attribute contains a '$base', expand it to the current
       value of the $base variable. -->

  <!-- All your $base are belong to us.  Ho ho ho -->
  <xsl:template match="a">
    <a><xsl:attribute name="href">
	<xsl:choose>
	  <xsl:when test="contains(@href, '$base')">
	    <xsl:value-of select="concat(substring-before(@href, '$base'), $base, substring-after(@href, '$base'))"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@href"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
</xsl:stylesheet>

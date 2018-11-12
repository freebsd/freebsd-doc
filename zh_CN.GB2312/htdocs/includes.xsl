<?xml version="1.0" encoding="GB2312" ?>

<!-- $FreeBSD$ -->

<!-- The FreeBSD Simplified Chinese Documentation Project -->
<!-- Original revision: 1.20 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../share/sgml/includes.xsl" />

  <xsl:variable name="url.doc.langcode" select="'zh_CN.GB2312'" />

  <!-- Language-specific definitions should be put below this line -->
  <!-- default format for date string -->
  <xsl:param name="param-l10n-date-format-YMD"
             select="'%Y �� %M %D ��'" />
  <xsl:param name="param-l10n-date-format-YM"
             select="'%Y �� %M'" />
  <xsl:param name="param-l10n-date-format-MD"
             select="'%M %D ��'" />

  <!-- From FreeBSD: www/share/sgml/includes.header.xsl,v 1.19 2006/07/23 13:27:16 joel -->
  <xsl:variable name="i.daemon">
    <img src="{$enbase}/gifs/daemon.gif" alt="" align="left" width="80" height="76"/>
  </xsl:variable>

  <xsl:variable name="i.new">
    <img src="{$enbase}/gifs/new.gif" alt="[New!]" width="28" height="11"/>
  </xsl:variable>

  <xsl:variable name="copyright">
    <a href="{$base}/copyright/">��Ȩ��Ϣ</a> | &#169; 1995-2006 The FreeBSD Project.  ��������Ȩ����
  </xsl:variable>

  <xsl:variable name="home">
    <a href="{$base}/index.html"><img src="{$enbase}/gifs/home.gif" alt="FreeBSD ��ҳ" border="0" align="right" width="101" height="33"/></a>
  </xsl:variable>

  <xsl:variable name="header1">
    <head><title><xsl:value-of select="$title"/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=GB2312" />
    <meta name="MSSmartTagsPreventParsing" content="TRUE" />
    <link rel="shortcut icon" href="{$enbase}/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="{$enbase}/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" media="screen" href="{$base}/layout/css/fixed.css" type="text/css" title="Normal Text" />
    <link rel="alternate stylesheet" media="screen" href="{$base}/layout/css/fixed_large.css" type="text/css" title="Large Text" />
    <script type="text/javascript" src="{$enbase}/layout/js/styleswitcher.js"></script>
    </head>    
  </xsl:variable>

  <xsl:variable name="header2">
            <span class="txtoffscreen"><a href="#CONTENT" title="����վ�㵼����" accesskey="1">����վ�㵼����</a> (1)</span>
            <xsl:text> </xsl:text> 
            <span class="txtoffscreen"><a href="#CONTENTWRAP" title="������Ŀ������" accesskey="2">������Ŀ������</a> (2)</span>
            <div id="HEADERCONTAINER">
      
              <div id="HEADER">
      	      <h2 class="blockhide">Header And Logo</h2>
                <div id="HEADERLOGOLEFT">
                  <a href="{$base}" title="FreeBSD"><img src="{$enbase}/layout/images/logo-red.png" width="457" height="75" alt="FreeBSD" /></a>
                </div> <!-- HEADERLOGOLEFT -->
                <div id="HEADERLOGORIGHT">
      			<h2 class="blockhide">Peripheral Links</h2>
      			  <div id="SEARCHNAV">
      				<ul id="SEARCHNAVLIST">
      				  <li>
      					Text Size: <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Normal Text'); return false;" title="Normal Text Size">����</a> / <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Large Text'); return false;" title="Large Text Size">����</a>
      				  </li>
      				  <li>
      					<a href="{$enbase}/donations/" title="����">����</a>
      				  </li>
      				  <li class="last-child">
      					<a href="{$enbase}/mailto.html" title="����">����</a>
      				  </li>
      				</ul>
      			  </div> <!-- SEARCHNAV -->
      			<div id="SEARCH">
      			  <form action="{$cgibase}/search.cgi" method="get">
      				<div>
      			      <h2 class="blockhide"><label for="WORDS">����</label></h2>
      				  <input type="hidden" name="max" value="25" /> <input type="hidden" name="source" value="www" /><input id="WORDS" name="words" type="text" size="20" maxlength="255" onfocus="if( this.value==this.defaultValue ) this.value='';" value="����" />&#160;<input id="SUBMIT" name="submit" type="submit" value="����" />
      				</div>
      			  </form>
      			</div> <!-- SEARCH -->
                </div> <!-- HEADERLOGORIGHT -->
      
              </div> <!-- HEADER -->
      
        	<h2 class="blockhide">Site Navigation</h2>
              <div id="TOPNAV">
                <ul id="TOPNAVLIST">
		  <li>
			<a href="{$base}/" title="��ҳ">��ҳ</a>
		  </li>
		  <li>
			<a href="{$base}/about.html" title="����">����</a>
		  </li>
		  <li>
			<a href="{$base}/where.html" title="��� FreeBSD">��� FreeBSD</a>
		  </li>
		  <li>
			<a href="{$base}/docs.html" title="�ĵ�">�ĵ�</a>
		  </li>
		  <li>
			<a href="{$base}/community.html" title="����">����</a>
		  </li>
		  <li>
			<a href="{$enbase}/projects/index.html" title="����">����</a>
		  </li>
		  <li>
			<a href="{$base}/support.html" title="֧��">֧��</a>
		  </li>
		</ul>
              </div> <!-- TOPNAV -->
            </div> <!-- HEADERCONTAINER -->
  </xsl:variable>

  <xsl:variable name="sidenav">
	<div id="SIDEWRAP">
	
	<div id="SIDENAV">
	<h2 class="blockhide">Section Navigation</h2>
	
	<xsl:if test="$section = 'about'" >
		<ul>
		<li><a href="{$base}/about.html">����</a></li>
		<li><a href="{$base}/features.html">����</a></li>
		<li><a href="{$base}/applications.html">Ӧ�ó���</a></li>
		<li><a href="{$base}/internet.html">������</a></li>
		<li><a href="{$base}/advocacy/">�ٽ���Ŀ</a></li>
		<li><a href="{$enbase}/marketing/">�г�</a></li>
		<li><a href="{$base}/news/newsflash.html">����</a></li>
		<li><a href="{$enbase}/events/events.html">���ڻ</a></li>
		<li><a href="{$base}/news/press.html">ý�屨��</a></li>
		<li><a href="{$base}/art.html">��ͼ</a></li>
		<li><a href="{$base}/donations/">����</a></li>
		<li><a href="{$base}/copyright/">������֪</a></li>
		</ul>
    	</xsl:if>
    	
    	<xsl:if test="$section = 'community'" >
		<ul>
		<li><a href="{$base}/community.html">����</a></li>
		<li><a href="{$enbase}/community/mailinglists.html">�ʼ��б�</a></li>
		<li><a href="{$enbase}/community/irc.html">IRC</a></li>
		<li><a href="{$enbase}/community/newsgroups.html">������</a></li>
		<li><a href="{$enbase}/usergroups.html">�û���</a></li>
		<li><a href="{$enbase}/community/webresources.html">Web ��Դ</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'developers'" >
		<ul>
		<li><a href="{$base}/projects/index.html">����</a></li>
		<li><a href="{$enbase}/doc/zh_CN.GB2312/books/developers-handbook">�����ֲ�</a></li>
		<li><a href="{$enbase}/doc/zh_CN.GB2312/books/porters-handbook">Porter �ֲ�</a></li>
		<li><a href="{$base}/developers/cvs.html">CVS �����</a></li>
		<li><a href="{$base}/releng/index.html">��������</a></li>
		<li><a href="{$base}/platforms/">ƽ̨</a>
			<ul>
				<li><a href="{$base}/platforms/alpha.html">alpha</a></li>
				<li><a href="{$base}/platforms/amd64.html">amd64</a></li>
				<li><a href="{$base}/platforms/arm.html">ARM</a></li>
				<li><a href="{$base}/platforms/i386.html">i386</a></li>
				<li><a href="{$base}/platforms/ia64/index.html">ia64</a></li>
				<li><a href="{$base}/platforms/mips.html">MIPS</a></li>
				<li><a href="{$base}/platforms/pc98.html">pc98</a></li>
				<li><a href="{$base}/platforms/ppc.html">ppc</a></li>
				<li><a href="{$base}/platforms/sparc.html">sparc64</a></li>
				<li><a href="{$base}/platforms/xbox.html">xbox</a></li>
			</ul>
		</li>
		<li><a href="{$enbase}/projects/ideas/">��Ŀ��Ա��ļ (Ӣ��)</a></li>
		<li><a href="{$enbase}/doc/zh_CN.GB2312/articles/contributing/index.html">Ϊ FreeBSD �ṩ����</a></li>
		</ul>
    	</xsl:if>

	<xsl:if test="$section = 'docs'" >
		<ul>
		<li><a href="{$base}/docs.html">�ĵ�</a></li>
		<li><a href="{$enbase}/doc/zh_CN.GB2312/books/faq/">FAQ</a></li>
		<li><a href="{$enbase}/doc/zh_CN.GB2312/books/handbook/">ʹ���ֲ�</a></li>
		<li><a href="{$cgibase}/man.cgi">�����ֲ�</a></li>
		<li><a href="{$enbase}/docs/books.html">����ͼ�������</a></li>
		<li><a href="{$enbase}/publish.html">������</a></li>
		<li><a href="{$enbase}/docs/webresources.html">Web ��Դ</a></li>
		<li><a href="{$enbase}/projects/newbies.html">������·</a></li>
		<li><a href="{$enbase}/docproj/">FreeBSD �ĵ��ƻ�</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'download'" >
		<ul>
		<li><a href="{$base}/where.html">��� FreeBSD</a></li>
		<li><a href="{$base}/releases/">���а���Ϣ</a>
			<ul>
				<li><a href="{$enbase}/{$u.rel.announce}">�������ð棺 <xsl:value-of select="$rel.current"/></a></li>
				<li><a href="{$enbase}/{$u.rel2.announce}">�������ð� (��ʽ)�� <xsl:value-of select="$rel2.current"/></a></li>
				<li><a href="{$enbase}/snapshots/">���հ汾</a></li>
				<xsl:if test="$beta.testing != '0'">
				  <li><a href="{$base}/where.html">�������İ汾 <xsl:value-of
				    select="concat($betarel.current, '-', $betarel.vers)"/></a>
				  </li>
				</xsl:if>
				<xsl:if test="$beta2.testing != '0'">
				  <li><a href="{$base}/where.html">�������İ汾 <xsl:value-of
				    select="concat($betarel2.current, '-', $betarel2.vers)"/></a>
				  </li>
				</xsl:if>
			</ul>
		</li>
		<li><a href="{$enbase}/ports/">��ֲ��Ӧ�ó��� (ports)</a></li>
		</ul>
	</xsl:if>
    	
    	<xsl:if test="$section = 'support'" >
		<ul>
		<li><a href="{$base}/support.html">֧��</a></li>
		<li><a href="{$enbase}/commercial/">��ҵ֧��</a>
			<ul>
				<li><a href="{$enbase}/commercial/software_bycat.html">���</a></li>
				<li><a href="{$enbase}/commercial/hardware.html">Ӳ��</a></li>
				<li><a href="{$enbase}/commercial/consult_bycat.html">��ѯ</a></li>
				<li><a href="{$enbase}/commercial/isp.html">Internet ����</a></li>
				<li><a href="{$enbase}/commercial/misc.html">����</a></li>
			</ul>
		</li>
		<li><a href="{$base}/security/">��ȫ��Ϣ</a></li>
		<li><a href="{$enbase}/support/bugreports.html">Bug ����</a>
			<ul>
				<li><a href="{$enbase}/send-pr.html">�ύ���ⱨ��</a></li>
			</ul>
		</li>
		<li><a href="{$base}/support/webresources.html">Web ��Դ</a></li>
		</ul>
    	</xsl:if>
	
	</div> <!-- SIDENAV -->
	
	</div> <!-- SIDEWRAP -->
  </xsl:variable>

</xsl:stylesheet>

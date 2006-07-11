<?xml version="1.0" encoding="GB2312" ?>

<!-- $FreeBSD: www/zh_CN/includes.xsl,v 1.1.1002.19 2006/06/26 05:13:33 delphij Exp $ -->

<!-- The FreeBSD Simplified Chinese Documentation Project -->
<!-- Original revision: 1.20 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="../share/sgml/includes.xsl" />

  <xsl:variable name="url.doc.langcode" select="'zh_CN.GB2312'" />

  <!-- Language-specific definitions should be put below this line -->
  <!-- default format for date string -->
  <xsl:param name="param-l10n-date-format-YMD"
             select="'%Y 年 %M %D 日'" />
  <xsl:param name="param-l10n-date-format-YM"
             select="'%Y 年 %M'" />
  <xsl:param name="param-l10n-date-format-MD"
             select="'%M %D 日'" />

  <!-- From FreeBSD: www/share/sgml/includes.header.xsl,v 1.18 2006/05/09 07:30:29 kuriyama -->
  <xsl:variable name="i.daemon">
    <img src="{$enbase}/gifs/daemon.gif" alt="" align="left" width="80" height="76"/>
  </xsl:variable>

  <xsl:variable name="i.new">
    <img src="{$enbase}/gifs/new.gif" alt="[New!]" width="28" height="11"/>
  </xsl:variable>

  <xsl:variable name="copyright">
    <a href="{$base}/copyright/">版权信息</a> | &#169; 1995-2006 The FreeBSD Project.  保留所有权利。
  </xsl:variable>

  <xsl:variable name="home">
    <a href="{$base}/index.html"><img src="{$enbase}/gifs/home.gif" alt="FreeBSD 主页" border="0" align="right" width="101" height="33"/></a>
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
            <span class="txtoffscreen"><a href="#CONTENT" title="跳过站点导航栏" accesskey="1">跳过站点导航栏</a> (1)</span>
            <xsl:text> </xsl:text> 
            <span class="txtoffscreen"><a href="#CONTENTWRAP" title="跳过栏目导航栏" accesskey="2">跳过栏目导航栏</a> (2)</span>
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
      					Text Size: <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Normal Text'); return false;" title="Normal Text Size">正常</a> / <a href="#" onkeypress="return false;" onclick="setActiveStyleSheet('Large Text'); return false;" title="Large Text Size">大字</a>
      				  </li>
      				  <li>
      					<a href="{$enbase}/donations/" title="捐赠">捐赠</a>
      				  </li>
      				  <li class="last-child">
      					<a href="{$enbase}/mailto.html" title="联络">联络</a>
      				  </li>
      				</ul>
      			  </div> <!-- SEARCHNAV -->
      			<div id="SEARCH">
      			  <form action="{$cgibase}/search.cgi" method="get">
      				<div>
      			      <h2 class="blockhide"><label for="WORDS">搜索</label></h2>
      				  <input type="hidden" name="max" value="25" /> <input type="hidden" name="source" value="www" /><input id="WORDS" name="words" type="text" size="20" maxlength="255" onfocus="if( this.value==this.defaultValue ) this.value='';" value="搜索" />&#160;<input id="SUBMIT" name="submit" type="submit" value="搜索" />
      				</div>
      			  </form>
      			</div> <!-- SEARCH -->
                </div> <!-- HEADERLOGORIGHT -->
      
              </div> <!-- HEADER -->
      
        	<h2 class="blockhide">Site Navigation</h2>
              <div id="TOPNAV">
                <ul id="TOPNAVLIST">
		  <li>
			<a href="{$base}/" title="首页">首页</a>
		  </li>
		  <li>
			<a href="{$base}/about.html" title="关于">关于</a>
		  </li>
		  <li>
			<a href="{$base}/where.html" title="获得 FreeBSD">获得 FreeBSD</a>
		  </li>
		  <li>
			<a href="{$base}/docs.html" title="文档">文档</a>
		  </li>
		  <li>
			<a href="{$base}/community.html" title="社区">社区</a>
		  </li>
		  <li>
			<a href="{$enbase}/projects/index.html" title="开发">开发</a>
		  </li>
		  <li>
			<a href="{$base}/support.html" title="支持">支持</a>
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
		<li><a href="{$base}/about.html">关于</a></li>
		<li><a href="{$base}/features.html">特性</a></li>
		<li><a href="{$base}/applications.html">应用程序</a></li>
		<li><a href="{$base}/internet.html">互联网</a></li>
		<li><a href="{$base}/advocacy/">促进项目</a></li>
		<li><a href="{$enbase}/marketing/">市场</a></li>
		<li><a href="{$base}/news/newsflash.html">新闻</a></li>
		<li><a href="{$enbase}/events/events.html">近期活动</a></li>
		<li><a href="{$base}/news/press.html">媒体报道</a></li>
		<li><a href="{$base}/art.html">插图</a></li>
		<li><a href="{$base}/donations/">捐赠</a></li>
		<li><a href="{$base}/copyright/">法律须知</a></li>
		</ul>
    	</xsl:if>
    	
    	<xsl:if test="$section = 'community'" >
		<ul>
		<li><a href="{$base}/community.html">社区</a></li>
		<li><a href="{$enbase}/community/mailinglists.html">邮件列表</a></li>
		<li><a href="{$enbase}/community/irc.html">IRC</a></li>
		<li><a href="{$enbase}/community/newsgroups.html">新闻组</a></li>
		<li><a href="{$enbase}/usergroups.html">用户组</a></li>
		<li><a href="{$enbase}/community/webresources.html">Web 资源</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'developers'" >
		<ul>
		<li><a href="{$base}/projects/index.html">开发</a></li>
		<li><a href="{$enbase}/doc/zh_CN.GB2312/books/developers-handbook">开发手册</a></li>
		<li><a href="{$enbase}/doc/zh_CN.GB2312/books/porters-handbook">Porter 手册</a></li>
		<li><a href="{$base}/developers/cvs.html">CVS 代码库</a></li>
		<li><a href="{$base}/releng/index.html">交付工程</a></li>
		<li><a href="{$base}/platforms/">平台</a>
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
		<li><a href="{$enbase}/doc/zh_CN.GB2312/articles/contributing/index.html">为 FreeBSD 提供帮助</a></li>
		</ul>
    	</xsl:if>

	<xsl:if test="$section = 'docs'" >
		<ul>
		<li><a href="{$base}/docs.html">文档</a></li>
		<li><a href="{$enbase}/doc/zh_CN.GB2312/books/faq/">FAQ</a></li>
		<li><a href="{$enbase}/doc/zh_CN.GB2312/books/handbook/">使用手册</a></li>
		<li><a href="{$enbase}/docs/man.html">联机手册</a>
			<ul>
				<li><a href="{$cgibase}/man.cgi">在线查看联机手册</a></li>
			</ul>
		</li>
		<li><a href="{$enbase}/docs/books.html">在线图书和文章</a></li>
		<li><a href="{$enbase}/publish.html">出版物</a></li>
		<li><a href="{$enbase}/docs/webresources.html">Web 资源</a></li>
		<li><a href="{$enbase}/projects/newbies.html">新手上路</a></li>
		<li><a href="{$enbase}/docproj/">FreeBSD 文档计划</a></li>
		</ul>
	</xsl:if>

	<xsl:if test="$section = 'download'" >
		<ul>
		<li><a href="{$base}/where.html">获得 FreeBSD</a></li>
		<li><a href="{$base}/releases/">发行版信息</a>
			<ul>
				<li><a href="{$enbase}/{$u.rel.announce}">生产适用版： <xsl:value-of select="$rel.current"/></a></li>
				<li><a href="{$enbase}/{$u.rel2.announce}">生产适用版 (旧式)： <xsl:value-of select="$rel2.current"/></a></li>
				<li><a href="{$enbase}/snapshots/">快照版本</a></li>
				<xsl:if test="$beta.testing != '0'">
				  <li><a href="{$base}/where.html">将发布的版本 <xsl:value-of
				    select="concat($betarel.current, '-', $betarel.vers)"/></a>
				  </li>
				</xsl:if>
				<xsl:if test="$beta2.testing != '0'">
				  <li><a href="{$base}/where.html">将发布的版本 <xsl:value-of
				    select="concat($betarel2.current, '-', $betarel2.vers)"/></a>
				  </li>
				</xsl:if>
			</ul>
		</li>
		<li><a href="{$enbase}/ports/">移植的应用程序 (ports)</a></li>
		</ul>
	</xsl:if>
    	
    	<xsl:if test="$section = 'support'" >
		<ul>
		<li><a href="{$base}/support.html">支持</a></li>
		<li><a href="{$enbase}/commercial/">商业支持</a>
			<ul>
				<li><a href="{$enbase}/commercial/software_bycat.html">软件</a></li>
				<li><a href="{$enbase}/commercial/hardware.html">硬件</a></li>
				<li><a href="{$enbase}/commercial/consult_bycat.html">咨询</a></li>
				<li><a href="{$enbase}/commercial/isp.html">Internet 服务</a></li>
				<li><a href="{$enbase}/commercial/misc.html">其它</a></li>
			</ul>
		</li>
		<li><a href="{$base}/security/">安全信息</a></li>
		<li><a href="{$enbase}/support/bugreports.html">Bug 报告</a>
			<ul>
				<li><a href="{$enbase}/send-pr.html">提交问题报告</a></li>
			</ul>
		</li>
		<li><a href="{$base}/support/webresources.html">Web 资源</a></li>
		</ul>
    	</xsl:if>
	
	</div> <!-- SIDENAV -->
	
	</div> <!-- SIDEWRAP -->
  </xsl:variable>

</xsl:stylesheet>

<?xml version="1.0" encoding="KOI8-R" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/www/ru/index.xsl,v 1.33 2004/04/08 07:08:51 den Exp $

     Original revision: 1.96
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'..'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:variable name="title" select="'Проект FreeBSD'"/>

  <!-- these params should be externally bound. The values
       here are not used actually -->
  <xsl:param name="advisories.xml" select="'none'"/>
  <xsl:param name="mirrors.xml" select="'none'"/>
  <xsl:param name="news.press.xml" select="'none'"/>
  <xsl:param name="news.project.xml" select="'none'"/>

  <xsl:output type="html" encoding="koi8-r"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title><xsl:value-of select="$title"/></title>
  
	<meta name="description" content="Проект FreeBSD"/>

	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Gallery,
          Release, Application, Software, Handbook, FAQ, Tutorials, Bugs, 
	  CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix,
	  Поддержка, Галерея, Релиз, Приложение, Программы, Руководство,
	  Учебники, Ошибки, Новости, Коммерческие Поставщики,
	  домашняя страница"/>

        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>

        <link rel="icon" href="/favicon.ico" type="image/x-icon"/>
      </head>

      <body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#840084"
	alink="#0000FF">

	<table border="0" cellspacing="0" cellpadding="0" width="100%">
	  <tr>
	    <td><a href="http://www.FreeBSD.org/ru/index.html">
              <img src="../gifs/freebsd_1.gif" height="94" width="306"
              alt="FreeBSD: The Power to Serve" border="0"/></a></td>

	    <td align="right" valign="bottom">
	      <form action="http://www.FreeBSD.org/cgi/mirror.cgi"
                method="get">

	        <br/>

		<font color="#990000"><b>Выберите ближайший к вам сервер:</b></font>

		<br/>

		<select name="goto">
		  <!--  Only list TRUE mirrors here! Native language pages 
		        which are not mirrored should be listed in
		        support.sgml.  -->

		  <xsl:call-template name="html-index-mirrors-options-list">
		    <xsl:with-param name="mirrors.xml" select="$mirrors.xml" />
		  </xsl:call-template>
		</select>
		
		<input type="submit" value=" Перейти "/>
		
		<br/>
		
		<font color="#990000"><b>Язык: </b></font> 
		<a href="{$base}/de/index.html" title="Немецкий">[de]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$base}/index.html" title="Английский">[en]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$base}/es/index.html" title="Испанский">[es]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$base}/fr/index.html" title="Французский">[fr]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$base}/it/index.html" title="Итальянский">[it]</a>
		<xsl:text>&#160;</xsl:text>
		<a href="{$base}/ja/index.html" title="Японский">[ja]</a>
		<xsl:text>&#160;</xsl:text>
		<span title="Русский">[ru]</span>
	      </form>
	    </td>
	  </tr>
	</table>

	<br/>

	<hr size="1" noshade="noshade"/>

	<!-- Main layout table -->
	<table border="0" cellspacing="0" cellpadding="2">
	  <tr>
	    <td valign="top">
	      <table border="0" cellspacing="0" cellpadding="1"
		     bgcolor="#000000" width="100%">
		<tr>
		  <td>
		    <table cellpadding="4" cellspacing="0" border="0"
			   bgcolor="#ffcc66" width="100%">
		      <tr>
			<td>
			  <xsl:call-template name="html-index-navigation-link-list">
			    <xsl:with-param name="navigation.xml" select="$navigation.xml"/>
			  </xsl:call-template>

			  <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
			    <small>Поиск:<br/>
			      <input type="text" name="words" size="10"/>
			      <input type="hidden" name="max" value="25"/>
			      <input type="hidden" name="source" value="www"/>
			      <input type="submit" value="Искать"/></small>
			  </form>
			</td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>
	    </td>

	    <td></td>

	    <!-- Колонка основного текста -->

	    <td align="left" valign="top" rowspan="2">
	      <h2><font color="#990000">Что такое FreeBSD?</font></h2>

	      <p>FreeBSD - это мощная операционная система для компьютеров
                архитектур, совместимых с x86, AMD64, Alpha, IA-64, PC-98 и
                UltraSPARC&#174;.  Она основана на BSD, версии
                <xsl:value-of select="$unix"/>, созданной в Калифорнийском
                Университете в Беркли.  Она разрабатывается и поддерживается <a
		href="{$base}/doc/en_US.ISO8859-1/articles/contributors/index.html">
                большой командой разработчиков</a>.  Поддержка <a
		href="platforms/index.html">других платформ</a>
		находится на разных стадиях разработки.</p>

	      <h2><font color="#990000">Выдающиеся возможности</font></h2>

	      <p>Исключительный набор сетевых возможностей, высокая
		производительность, средства обеспечения безопасности и
		совместимости с другими ОС - вот те современные <a
		href="features.html">возможности</a> FreeBSD, которые
		зачастую всё ещё отсутствуют в других, даже лучших коммерческих,
		операционных системах.</p>

	      <h2><font color="#990000">Мощное решение для Internet</font></h2>
	      
	      <p>FreeBSD является идеальной платформой для построения
		<a href="internet.html">Internet или Intranet</a>.
		Эта система предоставляет надёжные даже при самой интенсивной
		нагрузке сетевые службы, и эффективное управление памятью,
		что позволяет обеспечивать приемлемое время отклика для
		сотен и даже тысяч одновременно работающих пользовательских
		задач.  Посетите нашу
		<a href="gallery/gallery.html">галерею</a>, чтобы увидеть
		примеры использования FreeBSD.</p>
	    
	      <h2><font color="#990000">Огромное количество
                приложений</font></h2>

	      <p>Качество FreeBSD вкупе с современным дешёвым и
                производительным аппаратным обеспечением ПК делают эту систему
                очень экономичной альтернативой коммерческим рабочим станциям
                <xsl:value-of select="$unix"/>.  Она прекрасно подходит для
                большого количества <a
		href="applications.html">приложений</a> как в качестве
		сервера, так и рабочей станции.</p>
	    
	      <h2><font color="#990000">Простота установки</font></h2>

	      <p>FreeBSD может быть установлена с различных носителей, включая
                CD-ROM, DVD-ROM, дискеты, магнитную ленту, раздел MS-DOS&#174;,
                либо, если у вас есть подключение к сети, можно установить её
                <i>непосредственно</i> через FTP или NFS.  Всё, что вам нужно
                для этого - несколько чистых дискет ёмкостью 1.44 Мбайта и <a
                href="{$base}/doc/ru_RU.KOI8-R/books/handbook/install.html">
                эти указания</a>.</p>

	      <h2><font color="#990000">FreeBSD распространяется
		<i>свободно</i></font></h2>
	    
	      <a href="copyright/daemon.html"><img
                src="{$base}/gifs/dae_up3.gif" alt="" height="81" width="72" 
		align="right" border="0"/></a>

	      <p>Хотя вы можете подумать, что операционная система с такими
		возможностями продаётся по высокой цене, FreeBSD
		распространяется <a href="copyright/index.html">бесплатно</a>
                и поставляется со всеми исходными текстами. Если вам захочется
		её попробовать, обратитесь к <a
		href="{$base}/doc/ru_RU.KOI8-R/books/handbook/mirrors.html">
		следующей информации</a>.</p>

	      <h2><font color="#990000">Как принять участие</font></h2>

	      <p>Принять участие в проекте очень просто. Всё, что вам нужно
		сделать - это найти часть FreeBSD, которую, по вашему мнению,
		можно усовершенствовать, сделать (внимательно и аккуратно)
		соответствующие изменения и отправить их в адрес проекта либо с
		помощью утилиты send-pr, либо непосредственно коммиттеру, если
		вы его знаете. Эта работа может представлять собой что угодно,
		от документации до исходных текстов. Подробнее об этом можно
		прочитать <a
		href="{$base}/doc/en_US.ISO8859-1/articles/contributing/index.html">
                здесь.</a></p>

	      <p>Даже если Вы не программист, есть другие способы помочь
		FreeBSD в развитии. The <a
		href="http://www.FreeBSDFoundation.org">FreeBSD Foundation</a>
		- это неприбыльная
		организация, для которой все пожертвования и денежная помощь
		не облагаются налогами.  Для более подробной информации
		пишите <a href="mailto:bod@FreeBSDFoundation.org">
                bod@FreeBSDFoundation.org</a> или: The FreeBSD Foundation,
		7321 Brockway Dr.  Boulder, CO 80303.  USA</p>

              <p>Компания Silicon Breeze производит и распространяет
                металлические фигурки Даемона BSD, и жертвует 15% прибыли
                в пользу FreeBSD Foundation.  Полную информацию об этом и о
                том, как заказать Даемона BSD, можно получить на <a
                href="http://www.linuxjewellery.com/beastie/">этой
                страничке.</a></p>
	    </td>

	    <td></td>

	    <!-- Right-most column -->
	    <td valign="top">
	      <!-- News / release info table -->
	      <table border="0" cellspacing="0" cellpadding="1"
		     bgcolor="#000000" width="100%">
		<tr>
		  <td>
		    <table cellpadding="4" cellspacing="0" border="0"
			   bgcolor="#ffcc66" width="100%">
		      <tr>
			<td valign="top"><p>
			      <a href="{$u.rel.early}">
			      <font size="+1" color="#990000"><b>Новый технологический релиз:
			    <xsl:value-of select="$rel.current"/></b></font></a><br/>

			    <small>&#183; <a href="{$u.rel.announce}">Анонс</a><br/>
			      &#183; <a href="{$base}/doc/ru_RU.KOI8-R/books/handbook/install.html">Руководство по установке</a><br/>
			      &#183; <a href="{$u.rel.notes}">Информация о Релизе</a><br/>
			      &#183; <a href="{$u.rel.hardware}">Поддерживаемое Оборудование</a><br/>
                              &#183; <a href="{$u.rel.errata}">Обнаруженные Проблемы</a><br/>
                              &#183; <a href="{$u.rel.early}">Руководство для новичков</a></small></p>

			<p>
			      <a href="{$u.rel2.announce}">
			      <font size="+1" color="#990000"><b>Продуктивный релиз:
			    <xsl:value-of select="$rel2.current"/></b></font></a><br/>

                            <small>&#183; <a href="{$u.rel2.announce}">Анонс</a><br/>
                              &#183; <a href="{$base}/doc/ru_RU.KOI8-R/books/handbook/install.html">Руководство по установке</a><br/>
                              &#183; <a href="{$u.rel2.notes}">Информация о релизе</a><br/>
                              &#183; <a href="{$u.rel2.hardware}">Информация об оборудовании</a><br/>
                              &#183; <a href="{$u.rel2.errata}">Известные проблемы</a></small></p>

			  <p><font size="+1" color="#990000"><b>Новости Проекта</b></font><br/>
			    <font size="-1">
			      Последние изменения: 
			      <xsl:call-template name="html-index-news-project-items-lastmodified">
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			      </xsl:call-template>
			      <br/>

			      <xsl:call-template name="html-index-news-project-items">
				<xsl:with-param name="news.project.xml" select="$news.project.xml" />
			      </xsl:call-template>

			      <a href="news/newsflash.html">Далее...</a>
			    </font></p>
			  
			  <p><font size="+1" color="#990000"><b>FreeBSD в Прессе</b></font><br/>

			    <font size="-1">
			      Последние изменения: 
			      <xsl:call-template name="html-index-news-press-items-lastmodified">
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			      </xsl:call-template>

			      <br/>

			      <xsl:call-template name="html-index-news-press-items">
				<xsl:with-param name="news.press.xml" select="$news.press.xml" />
			      </xsl:call-template>

			      <a href="news/press.html">Далее...</a>
                            </font>
                          </p>

                         <p><font size="+1" color="#990000"><b>Бюллетени безопасности</b></font><br/>

                           <font size="-1">
                             Последнее обновление:
			      <xsl:call-template name="html-index-advisories-items-lastmodified">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
			      </xsl:call-template>

			      <br/>

			      <xsl:call-template name="html-index-advisories-items">
				<xsl:with-param name="advisories.xml" select="$advisories.xml" />
			      </xsl:call-template>

                             <a href="security/">Дополнительно...</a>
			    </font>
			  </p>
			</td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>

	      <p>&#xa0;</p>

	      <table border="0" cellspacing="0" cellpadding="1"
		     bgcolor="#000000" width="100%">
		<tr>
		  <td>
		    <table cellpadding="4" cellspacing="0" border="0"
			   bgcolor="#FFFFFF" width="100%"><tr>
			<td>Чтобы узнать больше о FreeBSD посетите нашу
			  галерею <a href="publish.html">публикаций</a>,
			  посвящённых FreeBSD или <a
			  href="news/press.html">FreeBSD в Прессе</a>, а также
			  побродите по этому сайту!</td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>
	    </td>
	  </tr>
	</table>

	<hr noshade="noshade" size="1" />

	<table width="100%" border="0" cellspacing="0" cellpadding="3">
	  <tr>
	    <td><a href="http://www.freebsdmall.com/"><img
			   src="../gifs/mall_title_medium.gif" alt="[FreeBSD Mall]"
			   height="65" width="165" border="0"/></a></td>
	    
	    <td><a href="http://www.ugu.com/"><img src="../gifs/ugu_icon.gif"
			   alt="[Мы спонсируем Unix Guru Universe]" 
			   height="64" width="76"
			   border="0"/></a></td>
	  
	    <td><a href="http://www.daemonnews.org/"><img src="../gifs/darbylogo.gif"
		alt="[Daemon News]" height="45" width="130"
		border="0"/></a></td>
	  
	    <td><a href="copyright/daemon.html"><img
			     src="{$base}/gifs/powerlogo.gif" 
			     alt="[Powered by FreeBSD]"
			     height="64" 
			     width="160" 
			     border="0"/></a></td>
	  </tr>
	</table>

	<table width="100%" cellpadding="0" border="0" cellspacing="0">
	  <tr>
	    <td align="left" 
		valign="top"><small><a href="mailto.html">Пишите 
		  нам</a><br/>
		<xsl:value-of select="$date"/></small></td>

	    <td align="right" 
		valign="top"><small><a href="copyright/index.html">Legal</a> &#169; 1995-2004
		The FreeBSD Project.<br/>
		Все права защищены.</small></td>
	  </tr>
	</table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

<!-- 
     Local Variables:
     mode: xml
     sgml-indent-data: t
     sgml-omittag: nil
     sgml-always-quote-attributes: t
     End:
-->

<?xml version="1.0" encoding="KOI8-R" ?>

<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/www/ru/index.xsl,v 1.17 2003/09/20 18:53:31 andy Exp $

     Original revision: 1.70
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:import href="includes.xsl"/>
  <xsl:import href="news/includes.xsl"/>

  <xsl:variable name="base" select="'.'"/>
  <xsl:variable name="date" select="'$FreeBSD$'"/>
  <xsl:variable name="title" select="'Проект FreeBSD'"/>

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
		  <!--  Only list TRUE mirrrors here! Native language pages 
		        which are not mirrored should be listed in
		        support.sgml.  -->

                  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">IPv6 (6Bone) Япония</option>
                  <option value="http://www2.at.FreeBSD.org/">IPv6 Австрия</option>
                  <option value="http://www2.de.FreeBSD.org">IPv6 Германия</option>
                  <option value="http://www.dk.FreeBSD.org/">IPv6 Дания</option>
                  <option value="http://www2.no.FreeBSD.org/">IPv6 Норвегия</option>
                  <option value="http://www4.us.FreeBSD.org/">IPv6 США/1</option>
                  <option value="http://www5.us.FreeBSD.org/">IPv6 США/2</option>
		  <option value="http://www.au.FreeBSD.org/">Австралия/1</option>
                  <option value="http://www2.au.FreeBSD.org/">Австралия/2</option>
                  <option value="http://www.at.FreeBSD.org/">Австрия/1</option>
                  <option value="http://www2.at.FreeBSD.org/">Австрия/2</option>
                  <option value="http://www.ar.FreeBSD.org/">Аргентина</option>
		  <option value="http://freebsd.unixtech.be/">Бельгия</option>
		  <option value="http://www.bg.FreeBSD.org/">Болгария</option>
		  <option value="http://www.br.FreeBSD.org/www.freebsd.org/">Бразилия/1</option>
		  <option value="http://www2.br.FreeBSD.org/www.freebsd.org/">Бразилия/2</option>
		  <option value="http://www3.br.FreeBSD.org/">Бразилия/3</option>
		  <option value="http://www.uk.FreeBSD.org/">Великобритания/1</option>
		  <option value="http://www2.uk.FreeBSD.org/">Великобритания/2</option>
		  <option value="http://www3.uk.FreeBSD.org/">Великобритания/3</option>
                  <option value="http://www4.uk.FreeBSD.org/">Великобритания/4</option>
                  <option value="http://www.hu.FreeBSD.org/">Венгрия/1</option>
                  <option value="http://www2.hu.FreeBSD.org/">Венгрия/2</option>
		  <option value="http://www.de.FreeBSD.org/">Германия/1</option>
		  <option value="http://www1.de.FreeBSD.org/">Германия/2</option>
		  <option value="http://www2.de.FreeBSD.org/">Германия/3</option>
                  <option value="http://www.hk.FreeBSD.org/">Гонконг</option>
		  <option value="http://www.gr.FreeBSD.org/">Греция/1</option>
                  <option value="http://www.FreeBSD.gr/">Греция/2</option>
                  <option value="http://www.dk.FreeBSD.org/">Дания/1</option>
                  <option value="http://www3.dk.FreeBSD.org/">Дания/2</option>
                  <option value="http://www.ie.FreeBSD.org/">Ирландия/2</option>
                  <option value="http://www2.ie.FreeBSD.org/">Ирландия</option>
		  <option value="http://www.is.FreeBSD.org/">Исландия/1</option>
                  <option value="http://www.es.FreeBSD.org/">Испания/1</option>
                  <option value="http://www2.es.FreeBSD.org/">Испания/2</option>
                  <option value="http://www3.es.FreeBSD.org/">Испания/3</option>
		  <option value="http://www.it.FreeBSD.org/">Италия/1</option>
		  <option value="http://www.gufi.org/mirrors/www.freebsd.org/data/">Италия/2</option>
		  <option value="http://www.ca.FreeBSD.org/">Канада/1</option>
                  <option value="http://www2.ca.FreeBSD.org/">Канада/2</option>
		  <option value="http://www.cn.FreeBSD.org/">Китай</option>
		  <option value="http://www.kr.FreeBSD.org/">Корея/1</option>
		  <option value="http://www2.kr.FreeBSD.org/">Корея/2</option>
                  <option value="http://www3.kr.FreeBSD.org/">Корея/3</option>
		  <option value="http://www.lv.FreeBSD.org/">Латвия</option>
                  <option value="http://www.lt.FreeBSD.org/">Литва</option>
		  <option value="http://www.nl.FreeBSD.org/">Нидерланды/1</option>
		  <option value="http://www2.nl.FreeBSD.org/">Нидерланды/2</option>
		  <option value="http://www.nz.FreeBSD.org/">Новая Зеландия</option>
		  <option value="http://www.no.FreeBSD.org/">Норвегия/1</option>
                  <option value="http://www2.no.FreeBSD.org/">Норвегия/2</option>
		  <option value="http://www.pl.FreeBSD.org/">Польша/1</option>
		  <option value="http://www2.pl.FreeBSD.org/">Польша/2</option>
		  <option value="http://www2.pt.FreeBSD.org/">Португалия/1</option>
                  <option value="http://www4.pt.FreeBSD.org/">Португалия/1</option>
		  <option value="http://www.ru.FreeBSD.org/">Россия/1</option>
		  <option value="http://www2.ru.FreeBSD.org/">Россия/2</option>
		  <option value="http://www3.ru.FreeBSD.org/">Россия/3</option>
		  <option value="http://www4.ru.FreeBSD.org/">Россия/4</option>
		  <option value="http://www.ro.FreeBSD.org/">Румыния/1</option>
                  <option value="http://www2.ro.FreeBSD.org/">Румыния/2</option>
                  <option value="http://www3.ro.FreeBSD.org/">Румыния/3</option>
                  <option value="http://www.sm.FreeBSD.org/">Сан-Марино</option>
                  <option value="http://www2.sg.FreeBSD.org/">Сингапур</option>
		  <option value="http://www.sk.FreeBSD.org/">Словакия/1</option>
                  <option value="http://www2.sk.FreeBSD.org/">Словакия/2</option>
		  <option value="http://www.si.FreeBSD.org/">Словения/1</option>
                  <option value="http://www2.si.FreeBSD.org/">Словения/2</option
>
		  <option value="http://www.FreeBSD.org/">США/1</option>
                  <option value="http://www4.FreeBSD.org/">США/2</option>
                  <option value="http://www5.FreeBSD.org/">США/3</option>
		  <option value="http://www.tw.FreeBSD.org/">Тайвань/1</option>
                  <option value="http://www2.tw.FreeBSD.org/">Тайвань/2</option>
                  <option value="http://www3.tw.FreeBSD.org/">Тайвань/3</option>
                  <option value="http://www4.tw.FreeBSD.org/">Тайвань/4</option>
                  <option value="http://www.tr.FreeBSD.org/">Турция/1</option>
                  <option value="http://www2.tr.FreeBSD.org/">Турция/2</option>
                  <option value="http://www.enderunix.org/freebsd/">Турция/3</option>
		  <option value="http://www.ua.FreeBSD.org/">Украина/1</option>
		  <option value="http://www2.ua.FreeBSD.org/">Украина/2</option> 
                  <option value="http://www5.ua.FreeBSD.org/">Украина/3</option>
		  <option value="http://www4.ua.FreeBSD.org/">Украина/Крым</option> 
                  <option value="http://www.FreeBSD.org.ph/">Филиппины</option>
		  <option value="http://www.fi.FreeBSD.org/">Финляндия/1</option>
                  <option value="http://www2.fi.FreeBSD.org/">Финляндия/2</option>
		  <option value="http://www.fr.FreeBSD.org/">Франция</option>
		  <option value="http://www.se.FreeBSD.org/">Швеция/1</option>
                  <option value="http://www2.se.FreeBSD.org/">Швеция/2</option>
		  <option value="http://www.ch.FreeBSD.org/">Швейцария/1</option>
                  <option value="http://www2.ch.FreeBSD.org/">Швейцария/2</option>
		  <option value="http://www.ee.FreeBSD.org/">Эстония</option>
		  <option value="http://www.za.FreeBSD.org/">Южная Африка/1</option>
		  <option value="http://www2.za.FreeBSD.org/">Южная Африка/2</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">Япония</option>
		</select>
		
		<input type="submit" value=" Перейти "/>
		
		<br/>
		
		<font color="#990000"><b>Язык: </b></font> 
		<a href="../index.html">Английский</a>, 
		<a href="../es/index.html">Испанский</a>, 
                <a href="../it/index.html">Итальянский</a>,
                <a href="../ja/index.html">Японский</a>,
		<a href="support.html#web">другие</a>
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
			  <p><font size="+1" color="#990000"><b>Новости</b></font>


			    <small><br/>
			      &#183; <a href="news/newsflash.html">Анонсы</a><br/>
			      &#183; <a href="news/press.html">Пресса</a><br/>
			      &#183; <a href="news/index.html">Дополнительно ...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Программы</b></font>
			    <small><br/>
			      &#183; <a href="../doc/en_US.ISO8859-1/books/handbook/mirrors.html">Где взять систему</a><br/>
			      &#183; <a href="releases/index.html">Релизы</a><br/>
			      &#183; <a href="{$base}/ports/index.html">Приложения</a><br/>
			    </small></p>
	    
			  <p><font size="+1" color="#990000"><b>Документация</b></font>
		
			    <small><br/>
			      &#183; <a href="projects/newbies.html">Для новичков</a><br/>
                              &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/index.html">Руководство</a><br/>
                              &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/faq/index.html">FAQ</a><br/>
                              &#183; <a href="http://www.FreeBSD.org/cgi/man.cgi">Страницы справочной системы</a><br/>
			      &#183; <a href="{$base}/docproj/index.html">Проект Документирования</a><br/>
			      &#183; <a href="docs.html">Дополнительно..</a><br/>
			    </small></p>
			  
			  <p><font size="+1" color="#990000"><b>Поддержка</b></font>
	      
			    <small><br/>
			      &#183; <a href="{$base}/support.html#mailing-list">Списки рассылки</a><br/>
			      &#183; <a href="{$base}/support.html#newsgroups">Телеконференции</a><br/>
			      &#183; <a href="{$base}/support.html#user">Группы пользователей</a><br/>
			      &#183; <a href="{$base}/support.html#web">Ресурсы Internet</a><br/>
			      &#183; <a href="security/index.html">Безопасность</a><br/>
			      &#183; <a href="{$base}/support.html">Дополнительно..</a>
			    </small></p>

                          <p><font size="+1" color="#990000"><b>Сообщения об ошибках</b></font>
                            <small><br/>
                              &#183; <a href="send-pr.html">Посылка сообщений об ошибке</a><br/>
                              &#183; <a href="http://www.FreeBSD.org/cgi/query-pr-summary.cgi">Просмотр открытых проблем</a><br/>
                              &#183; <a href="http://www.FreeBSD.org/cgi/query-pr.cgi">Поиск по номеру ошибки</a><br/>
                              &#183; <a href="{$base}/support.html#gnats">Дополнительно..</a><br/>
                            </small></p>

			  <p><font size="+1" color="#990000"><b>Разработка</b></font>
			    <small><br/>
			      &#183; <a href="projects/index.html">Проекты</a><br/>
                              &#183; <a href="releng/index.html">Выпуск релизов</a><br/>
			      &#183; <a href="{$base}/support.html#cvs">Дерево CVS</a><br/>
			    </small></p>
	      
			  <p><font size="+1" color="#990000"><b>Производители</b></font>
			    
			    <small><br/>
			      &#183; <a href="../commercial/software_bycat.html">Программы</a><br/>
			      &#183; <a href="../commercial/hardware.html">Аппаратура</a><br/>
			      &#183; <a href="../commercial/consulting_bycat.html">Консалтинг</a><br/>
			      &#183; <a href="../commercial/misc.html">Разное</a><br/>
                            </small></p>

                          <p><font size="+1" color="#990000"><b>Пожертвования</b></font>
                            <small><br/>
                              &#183; <a href="{$base}/donations/index.html">Контактная информация</a><br/>
                              &#183; <a href="{$base}/donations/donors.html">Имеющиеся пожертвования</a><br/>
                              &#183; <a href="{$base}/donations/wantlist.html">Список требуемого</a><br/>
			    </small></p>
	      
			  <p><font size="+1" color="#990000"><b>Этот сервер</b></font>
		
			    <small><br/>
			      &#183; <a href="{$base}/search/index-site.html">Карта сервера</a><br/>
			      &#183; <a href="{$base}/search/search.html">Поиск</a><br/>
			      &#183; <a href="internal/index.html">Дополнительно ...</a><br/>
			    </small></p>
	      
			  <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
			    <small>Поиск:<br/>
			      <input type="text" name="words" size="10"/>
			      <input type="hidden" name="max" value="25"/>
			      <input type="hidden" name="source" value="www"/>
			      <input type="submit" value="Go"/></small>
			  </form></td>
		      </tr>
		    </table>
		  </td>
		</tr>
	      </table>
	    </td>
	    
	    <td></td>
	    
	    <!-- Main body column -->

	    <td align="left" valign="top" rowspan="2">
	      <h2><font color="#990000">Что такое FreeBSD?</font></h2>

	      <p>FreeBSD - это мощная операционная система для компьютеров
                архитектур, совместимых с x86, DEC Alpha,
                IA-64, PC-98 и UltraSPARC&#174;.  Она основана на BSD, версии
                <xsl:value-of select="$unix"/>, разработанной в Университете
                Калифорнии, Беркли.  Она разрабатывается и поддерживается <a
		href="../doc/en_US.ISO8859-1/articles/contributors/index.html">
                большой командой разработчиков</a>.  Поддержка <a
		href="{$base}/platforms/index.html">других платформ</a>
		находится на разных стадиях разработки.</p>

	      <h2><font color="#990000">Выдающиеся возможности</font></h2>

	      <p>Исключительный набор сетевых возможностей, высокая
		производительность, средства обеспечения безопасности и
		совместимости с другими ОС - вот те современные <a
		href="{$base}/features.html">возможности</a> FreeBSD, которые
		зачастую всё ещё отсутствуют в других, даже лучших коммерческих,
		операционных системах.</p>

	      <h2><font color="#990000">Мощное решение для Internet</font></h2>
	      
	      <p>FreeBSD является идеальной платформой для построения
		<a href="{$base}/internet.html">Internet или Intranet</a>.
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
		href="{$base}/applications.html">приложений</a> как в качестве
		сервера, так и рабочей станции.</p>
	    
	      <h2><font color="#990000">Простота установки</font></h2>

	      <p>FreeBSD может быть установлена с различных носителей, включая
                CD-ROM, DVD-ROM, дискеты, магнитную ленту, раздел MS-DOS&#174;,
                либо, если у вас есть подключение к сети, можно установить
		её <i>непосредственно</i> через FTP или NFS.  Всё, что вам
                нужно иметь для этого - это пара чистых дискет объёмом 1.44МБ
                и <a href="../doc/en_US.ISO8859-1/books/handbook/install.html">
                эти указания</a>.</p>

	      <h2><font color="#990000">FreeBSD распространяется
		<i>свободно</i></font></h2>
	    
	      <a href="copyright/daemon.html"><img
                                                   src="../../gifs/dae_up3.gif" 
						   alt=""
						   height="81" width="72" 
						   align="right" 
						   border="0"/></a>

	      <p>Хотя вы можете предположить, что операционная система с такими
		возможностями продаётся по высокой цене, FreeBSD
		распространяется <a
		href="{$base}/copyright/index.html">бесплатно</a> и
		поставляется со всеми исходными текстами. Если вам захочется
		её попробовать, обратитесь к <a
		href="../doc/en_US.ISO8859-1/books/handbook/mirrors.html">
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
		href="../doc/en_US.ISO8859-1/articles/contributing/index.html">
                здесь.</a></p>

	      <p>Даже если Вы не программист, есть другие способы помочь
		FreeBSD в развитии. The FreeBSD Foundation - это неприбыльная
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
			<td valign="top"><p><font size="+1" color="#990000"><b>Новый технологический релиз:
			    <xsl:value-of select="$rel.current"/></b></font><br/>

			    <small>&#183; <a href="{$u.rel.announce}">Анонс</a><br/>
			      &#183; <a href="../doc/en_US.ISO8859-1/books/handbook/install.html">Руководство по установке</a><br/>
			      &#183; <a href="{$u.rel.notes}">Информация о Релизе</a><br/>
			      &#183; <a href="{$u.rel.hardware}">Поддерживаемое Оборудование</a><br/>
                              &#183; <a href="{$u.rel.errata}">Обнаруженные Проблемы</a><br/>
                              &#183; <a href="{$u.rel.early}">Руководство для новичков</a></small></p>

                          <p><font size="+1" color="#990000"><b>Продуктивный релиз:
                            <xsl:value-of select="$rel2.current"/></b></font><br/>

                            <small>&#183; <a href="{$u.rel2.announce}">Анонс</a><br/>
                              &#183; <a href="{$base}/doc/en_US.ISO8859-1/books/handbook/install.html">Руководство по установке</a><br/>
                              &#183; <a href="{$u.rel2.notes}">Информация о релизе</a><br/>
                              &#183; <a href="{$u.rel2.hardware}">Информация об оборудовании</a><br/>
                              &#183; <a href="{$u.rel2.errata}">Известные проблемы</a></small></p>

			  <p><font size="+1" color="#990000"><b>Новости Проекта</b></font><br/>
			    <font size="-1">
			      Последние изменения: 
			      <xsl:value-of
				select="descendant::month[position() = 1]/name"/>
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="descendant::day[position() = 1]/name"/>,
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="descendant::year[position() = 1]/name"/>
			      <br/>
			      <!-- Pull in the 10 most recent news items -->
			      <xsl:for-each select="descendant::event[position() &lt;= 10]">
				&#183;  <a>
				  <xsl:attribute name="href">
				    news/newsflash.html#<xsl:call-template name="generate-event-anchor"/>
				  </xsl:attribute>
				  <xsl:choose>
				    <xsl:when test="count(child::title)">
				      <xsl:value-of select="title"/><br/>
				    </xsl:when>
				    <xsl:otherwise>
				      <xsl:value-of select="p"/><br/>
				    </xsl:otherwise>
				  </xsl:choose>
				</a>
			      </xsl:for-each>
			      <a href="news/newsflash.html">Далее...</a>
			    </font></p>
			  
			  <p><font size="+1" color="#990000"><b>FreeBSD в Прессе</b></font><br/>

			    <font size="-1">
			      Последние изменения: 
			      <xsl:value-of
				select="document('news/press.xml')/descendant::month[position() = 1]/name"/>
			      <xsl:text> </xsl:text>
			      <xsl:value-of
				select="document('news/press.xml')/descendant::year[position() = 1]/name"/>
			      <br/>
			      <!-- Pull in the 10 most recent press items -->
			      <xsl:for-each select="document('news/press.xml')/descendant::story[position() &lt; 10]">
				&#183; <a>
				  <xsl:attribute name="href">
				    news/press.html#<xsl:call-template name="generate-story-anchor"/>
				  </xsl:attribute>
				  <xsl:value-of select="name"/>
				</a><br/>
			      </xsl:for-each>
			      <a href="news/press.html">Далее...</a>
                            </font>
                          </p>

                         <p><font size="+1" color="#990000"><b>Бюллетени безопасности</b></font><br/>

                           <font size="-1">
                             Последнее обновление:
                             <xsl:value-of
                               select="document('security/advisories.xml')/descendant::month[position() = 1]/name"/>
                             <xsl:text> </xsl:text>
                             <xsl:value-of
                               select="document('security/advisories.xml')/descendant::day[position() = 1]/name"/>
                             <xsl:text>, </xsl:text>
                             <xsl:value-of
                               select="document('security/advisories.xml')/descendant::year[position() = 1]/name"/>
                             <br/>
                             <!-- Pull in the 10 most recent security advisories -->
                             <xsl:for-each select="document('security/advisories.xml')/descendant::advisory[position() &lt; 10]">
                               &#183; <a>
                                 <xsl:attribute name="href">ftp://ftp.freebsd.org/pub/FreeBSD/CERT/advisories/<xsl:value-of select="name"/>.asc</xsl:attribute>
                                 <xsl:value-of select="name"/>
                               </a><br/>
                             </xsl:for-each>
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
			  галерею <a href="{$base}/publish.html">публикаций</a>
			  посвященных FreeBSD или <a
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
	  
	    <td><a href="{$base}/copyright/daemon.html"><img
			     src="../gifs/powerlogo.gif" 
			     alt="[Powered by FreeBSD]"
			     height="64" 
			     width="160" 
			     border="0"/></a></td>
	  </tr>
	</table>

	<p><small>Обновления на веб-сервере происходят ежедневно
	  в 08:00 и 20:00 UTC.</small></p>
    
	<table width="100%" cellpadding="0" border="0" cellspacing="0">
	  <tr>
	    <td align="left" 
		valign="top"><small><a href="{$base}/mailto.html">Пишите 
		  нам</a><br/>
		<xsl:value-of select="$date"/></small></td>

	    <td align="right" 
		valign="top"><small><a href="copyright/index.html">Legal</a> &#169; 1995-2003
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

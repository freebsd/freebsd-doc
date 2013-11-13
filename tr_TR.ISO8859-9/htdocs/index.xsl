<?xml version="1.0" encoding="iso-8859-9"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/share/xml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>
<!--
     The FreeBSD Turkish Documentation Project
     Original revision: 1.77
-->

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/lang/share/xml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD$'"/>

  <xsl:output type="html" encoding="&xml.encoding;"
              doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <xsl:template match="/">
    <html>
      <head>
	<title>&title;</title>
	<meta name="description" content="The FreeBSD Projesi"/>
	<meta name="keywords" content="FreeBSD, BSD, UNIX, Support, Gallery,
	  Release, Application, Software, Handbook, FAQ, Tutorials, Bugs,
	  CVS, CVSup, News, Commercial Vendors, homepage, CTM, Unix"/>
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
	<link rel="icon" href="/favicon.ico" type="image/x-icon"/>
      </head>

      <body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#840084"
	alink="#0000FF">

	<table border="0" cellspacing="0" cellpadding="0" width="100%">
	  <tr>
	    <td><a href="http://www.FreeBSD.org/tr/index.html">
	      <img src="&enbase;/gifs/freebsd_1.gif" height="94" width="306"
		alt="FreeBSD: The Power to Serve" border="0"/></a></td>

	    <td align="right" valign="bottom">
	      <form action="http://www.FreeBSD.org/cgi/mirror.cgi"
		method="get">

		<br/>

		<font
		  color="#990000"><b>Yakınınızdaki
		  bir Yansı:</b></font>

		<br/>

		<select name="goto">
		  <!--  Only list TRUE mirrrors here! Native language pages
		        which are not mirrored should be listed in
		        support.xml.  -->

		  <option value="http://www2.at.FreeBSD.org/">IPv6 Avusturya</option>
		  <option value="http://www.dk.FreeBSD.org/">IPv6 Danimarka</option>
		  <option value="http://www2.de.FreeBSD.org">IPv6 Almanya</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">IPv6 Japonya</option>
		  <option value="http://www2.no.FreeBSD.org/">IPv6 Norveç</option>
		  <option value="http://www1.uk.FreeBSD.org/">IPv6 UK</option>
		  <option value="http://www4.us.FreeBSD.org/">IPv6 USA/1</option>
		  <option value="http://www5.us.FreeBSD.org/">IPv6 USA/2</option>
		  <option value="http://www.ar.FreeBSD.org/">Arjantin</option>
		  <option value="http://www.au.FreeBSD.org/">Avusturalya/1</option>
		  <option value="http://www2.au.FreeBSD.org/">Avusturalya/2</option>
		  <option value="http://www.at.FreeBSD.org/">Avusturya/1</option>
		  <option value="http://www2.at.FreeBSD.org/">Avusturya/2</option>
		  <option value="http://freebsd.unixtech.be/">Belçika</option>
		  <option value="http://www.br.FreeBSD.org/">Brezilya/1</option>
		  <option value="http://www2.br.FreeBSD.org/www.freebsd.org/">Brezilya/2</option>
		  <option value="http://www3.br.FreeBSD.org/">Brezilya/3</option>
		  <option value="http://www.bg.FreeBSD.org/">Bulgaristan</option>
		  <option value="http://www.ca.FreeBSD.org/">Kanada/1</option>
		  <option value="http://www2.ca.FreeBSD.org/">Kanada/2</option>
		  <option value="http://www.cn.FreeBSD.org/">Çin</option>
		  <option value="http://www.cz.FreeBSD.org/">Çek Cumhur.</option>
		  <option value="http://www.dk.FreeBSD.org/">Danimarka/1</option>
		  <option value="http://www3.dk.FreeBSD.org/">Danimarka/2</option>
		  <option value="http://www.ee.FreeBSD.org/">Estonya</option>
		  <option value="http://www.fi.FreeBSD.org/">Finlandiya/1</option>
		  <option value="http://www2.fi.FreeBSD.org/">Finlandiya/2</option>
		  <option value="http://www.fr.FreeBSD.org/">Fransa</option>
		  <option value="http://www.de.FreeBSD.org/">Almanya/1</option>
		  <option value="http://www1.de.FreeBSD.org/">Almanya/2</option>
		  <option value="http://www2.de.FreeBSD.org/">Almanya/3</option>
		  <option value="http://www.gr.FreeBSD.org/">Yunanistan/1</option>
		  <option value="http://www.FreeBSD.gr/">Yunanistan/2</option>
		  <option value="http://www.hk.FreeBSD.org/">Hong Kong</option>
		  <option value="http://www.hu.FreeBSD.org/">Macaristan/1</option>
		  <option value="http://www2.hu.FreeBSD.org/">Macaristan/2</option>
		  <option value="http://www.is.FreeBSD.org/">İzlanda</option>
		  <option value="http://www.ie.FreeBSD.org/">İrlanda/1</option>
		  <option value="http://www2.ie.FreeBSD.org/">İrlanda/2</option>
		  <option value="http://www.it.FreeBSD.org/">İtalya/1</option>
		  <option value="http://www.gufi.org/mirrors/www.freebsd.org/data/">Italya/2</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">Japonya</option>
		  <option value="http://www.kr.FreeBSD.org/">Kore/1</option>
		  <option value="http://www2.kr.FreeBSD.org/">Kore/2</option>
		  <option value="http://www.kw.FreeBSD.org/">Kuveyt</option>
		  <option value="http://www.lv.FreeBSD.org/">Letonya</option>
		  <option value="http://www.lt.FreeBSD.org/">Litvanya</option>
		  <option value="http://www.nl.FreeBSD.org/">Hollanda/1</option>
		  <option value="http://www2.nl.FreeBSD.org/">Hollanda/2</option>
		  <option value="http://www.nz.FreeBSD.org/">Yeni Zelanda</option>
		  <option value="http://www.no.FreeBSD.org/">Norveç/1</option>
		  <option value="http://www2.no.FreeBSD.org/">Norveç/2</option>
		  <option value="http://www.FreeBSD.org.ph/">Filipinler</option>
		  <option value="http://www.pl.FreeBSD.org/">Polonya/1</option>
		  <option value="http://www2.pl.FreeBSD.org/">Polonya/2</option>
		  <option value="http://www.pt.FreeBSD.org/">Portekiz/1</option>
		  <option value="http://www4.pt.FreeBSD.org/">Portekiz/2</option>
		  <option value="http://www5.pt.FreeBSD.org/">Portekiz/3</option>
		  <option value="http://www.ro.FreeBSD.org/">Romanya/1</option>
		  <option value="http://www2.ro.FreeBSD.org/">Romanya/2</option>
		  <option value="http://www3.ro.FreeBSD.org/">Romanya/3</option>
		  <option value="http://www4.ro.FreeBSD.org/">Romanya/4</option>
		  <option value="http://www.ru.FreeBSD.org/">Rusya/1</option>
		  <option value="http://www2.ru.FreeBSD.org/">Rusya/2</option>
		  <option value="http://www3.ru.FreeBSD.org/">Rusya/3</option>
		  <option value="http://www4.ru.FreeBSD.org/">Rusya/4</option>
		  <option value="http://www.sm.FreeBSD.org/">San Marino</option>
		  <option value="http://www2.sg.FreeBSD.org/">Singapur</option>
		  <option value="http://www.sk.FreeBSD.org/">Slovakya/1</option>
		  <option value="http://www2.sk.FreeBSD.org/">Slovakya/2</option>
		  <option value="http://www.si.FreeBSD.org/">Slovenya/1</option>
		  <option value="http://www2.si.FreeBSD.org/">Slovenya/2</option>
		  <option value="http://www.es.FreeBSD.org/">İspanya/1</option>
		  <option value="http://www2.es.FreeBSD.org/">İspanya/2</option>
		  <option value="http://www3.es.FreeBSD.org/">İspanya/3</option>
		  <option value="http://www.za.FreeBSD.org/">Güney Afrika/1</option>
		  <option value="http://www2.za.FreeBSD.org/">Güney Afrika/2</option>
		  <option value="http://www.se.FreeBSD.org/">İsveç/1</option>
		  <option value="http://www2.se.FreeBSD.org/">İsveç/2</option>
		  <option value="http://www.ch.FreeBSD.org/">İsviçre/1</option>
		  <option value="http://www2.ch.FreeBSD.org/">İsviçre/2</option>
		  <option value="http://www.tw.FreeBSD.org/">Tayvan/1</option>
		  <option value="http://www2.tw.FreeBSD.org/">Tayvan/2</option>
		  <option value="http://www3.tw.FreeBSD.org/">Tayvan/3</option>
		  <option value="http://www4.tw.FreeBSD.org/">Tayvan/4</option>
		  <option value="http://www.tr.FreeBSD.org/">Türkiye/1</option>
		  <option value="http://www2.tr.FreeBSD.org/">Türkiye/2</option>
		  <option value="http://www.enderunix.org/freebsd/">Türkiye/3</option>
		  <option value="http://www.ua.FreeBSD.org/">Ukrayna/1</option>
		  <option value="http://www2.ua.FreeBSD.org/">Ukrayna/2</option>
		  <option value="http://www5.ua.FreeBSD.org/">Ukrayna/3</option>
		  <option value="http://www4.ua.FreeBSD.org/">Ukrayna/Crimea</option>
		  <option value="http://www.uk.FreeBSD.org/">İngiltere/1</option>
		  <option value="http://www2.uk.FreeBSD.org/">İngiltere/2</option>
		  <option value="http://www3.uk.FreeBSD.org/">İngiltere/3</option>
		  <option value="http://www4.uk.FreeBSD.org/">İngiltere/4</option>
		  <option value="http://www1.uk.FreeBSD.org/">İngiltere/5</option>
		  <option value="http://www2.us.FreeBSD.org/">ABD/1</option>
		  <option value="http://www4.us.FreeBSD.org/">ABD/2</option>
		  <option value="http://www5.us.FreeBSD.org/">ABD/3</option>
		</select>

		<input type="submit" value=" Go "/>

		<br/>

		<font color="#990000"><b>Dil: </b></font>
		<a href="&enbase;/it/index.html">İtalyanca</a>,
		<a href="&enbase;/ja/index.html">Japonca</a>,
		<a href="&enbase;/ru/index.html">Rusça</a>,
		<a href="&enbase;/es/index.html">İspanyolca</a>,
		<a href="&enbase;/support.html#web">Diğerleri</a>
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
			  <p><font size="+1" color="#990000"><b>Haberler</b></font>


			    <small><br/>
			      &middot; <a href="&enbase;/news/newsflash.html">Anonslar</a><br/>
			      &middot; <a href="&enbase;/news/press.html">Basın</a><br/>
			      &middot; <a href="&enbase;/news/index.html">Diğerleri ...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Yazılım</b></font>
			    <small><br/>
			      &middot; <a href="&enbase;/doc/en_US.ISO8859-1/books/handbook/mirrors.html">Nereden Bulabilirim?</a><br/>
			      &middot; <a href="&enbase;/releases/index.html">Sürüm Bilgileri</a><br/>
			      &middot; <a href="&enbase;/ports/index.html">Ports Uygulamaları</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Dokümantasyon</b></font>

			    <small><br/>
			      &middot; <a href="&enbase;/projects/newbies.html">Yeniler İçin</a><br/>
			      &middot; <a href="&enbase;/doc/en_US.ISO8859-1/books/handbook/index.html">El Kitabı</a><br/>
			      &middot; <a href="&enbase;/doc/en_US.ISO8859-1/books/faq/index.html">SSS</a><br/>
			      &middot; <a href="http://www.FreeBSD.org/cgi/man.cgi">Klavuz Sayfaları</a><br/>
			      &middot; <a href="&enbase;/docproj/index.html">Dokümantasyon Proj.</a><br/>
			      &middot; <a href="docs.html">Diğerleri...</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Destek</b></font>

			    <small><br/>
			      &middot; <a href="&enbase;/support.html#mailing-list">Mail listeleri</a><br/>
			      &middot; <a href="&enbase;/support.html#newsgroups">Haber Grupları</a><br/>
			      &middot; <a href="&enbase;/support.html#user">Kullanıcı Grupları</a><br/>
			      &middot; <a href="&enbase;/support.html#web">Web Kaynakları</a><br/>
			      &middot; <a href="&enbase;/security/index.html">Güvenlik</a><br/>
			      &middot; <a href="&enbase;/support.html">Diğerleri...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Hata Bildirimi</b></font>
			    <small><br/>
			      &middot; <a href="&enbase;/send-pr.html">Hata Bildirimi Gönder</a><br/>
			      &middot; <a href="http://www.FreeBSD.org/cgi/query-pr-summary.cgi">Hata Sorgulama</a><br/>
			      &middot; <a href="http://www.FreeBSD.org/cgi/query-pr.cgi">Hata ID'sine Göre Ara</a><br/>
			      &middot; <a href="&enbase;/support.html#gnats">Diğerleri...</a><br/>
			    </small></p>


			  <p><font size="+1" color="#990000"><b>Geliştirim</b></font>

			    <small><br/>
			      &middot; <a href="&enbase;/projects/index.html">Projeler</a><br/>
			      &middot; <a href="&enbase;/releng/index.html">Sürüm Mühendisliği</a><br/>
			      &middot; <a href="&enbase;/support.html#cvs">CVS Deposu</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Satın Alma</b></font>

			    <small><br/>
			      &middot; <a href="&enbase;/commercial/software_bycat.html">Yazılım</a><br/>
			      &middot; <a href="&enbase;/commercial/hardware.html">Donanım</a><br/>
			      &middot; <a href="&enbase;/commercial/consulting_bycat.html">Danışmanlık</a><br/>
			      &middot; <a href="&enbase;/commercial/misc.html">Diğer</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Bağışlar</b></font>
			    <small><br/>
			      &middot; <a href="&enbase;/donations/index.html">Bağıs Kurumu</a><br/>
			      &middot; <a href="&enbase;/donations/donors.html">Yapılan Bağışlar</a><br/>
			      &middot; <a href="&enbase;/donations/wantlist.html">İhtiyaç Listesi</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Site içi</b></font>

			    <small><br/>
			      &middot; <a href="&enbase;/search/index-site.html">Site Haritası</a><br/>
			      &middot; <a href="&enbase;/search/search.html">Arama</a><br/>
			      &middot; <a href="&enbase;/internal/index.html">Diğer ...</a><br/>

			    </small></p>

			  <form action="http://www.FreeBSD.org/cgi/search.cgi" method="get">
			    <small>Arama:<br/>
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
	      <h2><font color="#990000">FreeBSD Nedir?</font></h2>

	      <p>FreeBSD x86 Uyumlu, DEC Alpha, IA-64, PC-98 ve
		UltraSPARC&reg; mimarileri için ileri seviye bir
		işletim sistemidir.  Berkeleydeki Kaliforniya
		Üniversitesinde geliştirilmiş
		&unix; türevi olan BSD 'yi
		temel almıştır.  FreeBSD <a
		href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/index.html">birçok
		kişi </a> tarafından geliştirilmekte ve
		devam ettirilmektedir. Ayrıca başka <a
		href="&enbase;/platforms/index.html">mimariler</a>
		için geliştirim değişik
		aşamalardadır.</p>

	      <h2><font color="#990000">En Büyük
		Özellikleri</font></h2>

	      <p>FreeBSD ileri seviyede ağ, performans,
		güvenlik ve uyumluluk <a
		href="&base;/features.html">özellikleri</a>sunar.
		Bu özellikler ticari olan bazı işletim
		sistemlerinde bile bulunmamaktadır.</p>

	      <h2><font color="#990000">Güçlü
		İnternet Çözümleri</font></h2>

	      <p>FreeBSD ideal bir <a
		href="&enbase;/internet.html">İnternet ya da
		İntranet</a> sunucusu olabilir. Ağır
		ağ yüklerinde sağlam ağ hizmetleri
		verecek yapıdadır ve aynı anda
		çalışan binlerce işleme cevap
		vermek için sistem hafızasını
		verimli bir şeklilde kullanır.  FreeBSD ile
		çalışan uygulama ve servisler
		için <a
		href="&enbase;/gallery/gallery.html">galeri</a>
		sayfamızı ziyaret edebilirsiniz.</p>

	      <h2><font color="#990000">Binlerce Uygulamayı
		Çalıştırabilirsiniz</font></h2>

	      <p>FreeBSD kalitesi günümüzde
		kullanılan düşük maliyetli PC
		donanımları ile birleşince mevcut
		ticari &unix; masaüstü
		sistemlere çok ekonomik bir alternatif
		olmaktadır.  FreeBSD masaüstü ve sunucu
		<a
		href="&enbase;/applications.html">uygulamaları</a>
		için hazır durumdadır.</p>

	      <h2><font color="#990000">Kolay Kurulum</font></h2>

	      <p>FreeBSD CD-ROM, DVD-ROM, flopi disk, manyetik teyp, ve
		MS-DOS&reg; disk bölümünden ya da bir
		ağ bağlantınız mevcutsa <i>direk</i>
		anonim FTP ya da NFS ile kurulabilir. Bütün
		ihtiyacınız bir çift 1.44MB flopi ve
		<a
		href="&enbase;/doc/en_US.ISO8859-1/books/handbook/install.html">bu</a>
		dokümandır.</p>

	      <h2><font color="#990000">FreeBSD
		<i>Ücretsizdir</i></font></h2>

	      <a href="&enbase;/copyright/daemon.html"><img
		src="&enbase;/gifs/dae_up3.gif" alt="" height="81"
		width="72" align="right" border="0"/></a>

	      <p>Bu özelliklere sahip bir işletim sisteminin
		yüksek fiyatlar ile
		satılacağını
		düşünebilirsiniz fakat FreeBSD <a
		href="&enbase;/copyright/index.html">ücretsiz</a>
		bir işletim sistemidir ve bütün kaynak
		kodu ile beraber gelir. Eğer denemek isterseniz <a
		href="&enbase;/doc/en_US.ISO8859-1/books/handbook/mirrors.html">daha
		fazla bilgi </a> mevcuttur.</p>

	      <h2><font color="#990000">FreeBSD 'ye Katkıda
		Bulunmak</font></h2>

	      <p>FreeBSD işletim sistemine katkıda bulunmak son derece
		basittir. İhtiyacınız olan tek şey FreeBSD işletim
		sisteminde geliştirilmesini düşündügünüz kısımları bulup
		bu değişiklikleri(dikkatli ve özenli bir şekilde) yapıp,
		yaptığınız değişiklikleri FreeBSD Projesine send-pr
		sistemi ile ya da tanıyorsanız bir FreeBSD geliştiricisine
		göndermek olacaktır.  Yapacağınız değişiklik
		dokümantasyon, sanatsal işler ya da kaynak kodu gibi
		şeyler olabilir.  Ayrıntılı bilgi için <a
		href="&enbase;/doc/en_US.ISO8859-1/articles/contributing/index.html">FreeBSD'ye
		Katkıda Bulunmak</a> makalesine başvurabilirsiniz.</p>

		<p>Program yazan biri olmasanız bile FreeBSD
		  Projesine katkıda bulunmak için
		  başka yollar mevcuttur.  The FreeBSD
		  Foundation(FreeBSD Kurumu) kar amacı
		  gütmeyen bir organizasyon olup yapılan
		  katkılar vergiden düşebilir
		  durumdadır.  Daha fazla bilgi için <a
		  href="mailto:bod@FreeBSDFoundation.org">bod@FreeBSDFoundation.org</a>
		  ile irtibata geçebilir ya da direk posta ile
		  şu adresi kullanabilirsiniz : The FreeBSD
		  Foundation, 7321 Brockway Dr.  Boulder, CO 80303.  USA</p>

		<p>Silicon Breeze firması
		  yaptığı BSD Daemon heykellerinden
		  gelen kazançların 15% 'ini FreeBSD
		  Foundation'a vermektedir.  Daha fazla bilgiye <a
		  href="http://www.linuxjewellery.com/beastie/">bu</a>
		  sayfadan ulaşabilirsiniz.</p>
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
			<td valign="top"><p><font size="+1" color="#990000"><b>Yeni Teknololi Sürümü:
			    &rel.current;</b></font><br/>

			    <small>&middot; <a href="&u.rel.announce;">Duyuru</a><br/>
			      &middot; <a href="&enbase;/doc/en_US.ISO8859-1/books/handbook/install.html">Kurulum Klavuzu</a><br/>
			      &middot; <a href="&u.rel.notes;">Sürüm Bilgileri</a><br/>
			      &middot; <a href="&u.rel.hardware;">Desteklenen Donanımlar</a><br/>
			      &middot; <a href="&u.rel.errata;">Düzeltilen Hatalar</a><br/>
			      &middot; <a href="&u.rel.early;">Erken Adaptasyon Klavuzu</a></small></p>

			  <p><font size="+1" color="#990000"><b>Kararlı Sürüm:
				&rel2.current;</b></font><br/>

			    <small>&middot; <a href="&u.rel2.announce;">Duyuru</a><br/>
			      &middot; <a href="&enbase;/doc/en_US.ISO8859-1/books/handbook/install.html">Kurulum Klavuzu</a><br/>
			      &middot; <a href="&u.rel2.notes;">Sürüm Bilgileri</a><br/>
			      &middot; <a href="&u.rel2.hardware;">Desteklenen Donanımlar</a><br/>
			      &middot; <a href="&u.rel2.errata;">Düzeltilen Hatalar</a></small></p>

			  <p><font size="+1" color="#990000"><b>Proje Haberleri</b></font></p>

			  <xsl:call-template name="html-index-news-project-items">
			    <xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
			    <xsl:with-param name="news.project.xml" select="$news.project.xml" />
			  </xsl:call-template>

			  <p><a href="&enbase;/news/newsflash.html">Öncekiler ...</a></p>

			  <p><font size="+1" color="#990000"><b>Basında FreeBSD</b></font></p>

			  <xsl:call-template name="html-index-news-press-items">
			    <xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
			    <xsl:with-param name="news.press.xml" select="$news.press.xml" />
			  </xsl:call-template>

			  <p><a href="&enbase;/en/news/press.html">Öncekiler ...</a></p>

			  <p><font size="+1" color="#990000"><b>Güvenlik Tavsiyeleri</b></font></p>

			  <xsl:call-template name="html-index-advisories-items">
			    <xsl:with-param name="advisories.xml" select="$advisories.xml" />
			    <xsl:with-param name="type" select="'advisory'" />
			  </xsl:call-template>

			  <p><a href="&enbase;/security/index.html">Öncekiler ...</a></p>
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
		      bgcolor="#FFFFFF" width="100%"><tr> <td>FreeBSD
		      hakkında daha fazla bilgi almak için
		      FreeBSD ile alakali <a
		      href="&enbase;/publish.html">yayınlar</a> ya
		      da <a
		      href="&enbase;/news/press.html">Basında
		      FreeBSD</a>, sayfalarını ziyaret
		      edebilirsiniz!</td>
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
							   src="&enbase;/gifs/mall_title_medium.gif" alt="[FreeBSD Mall]"
							   height="65" width="165" border="0"/></a></td>

	    <td><a href="http://www.ugu.com/"><img src="&enbase;/gifs/ugu_icon.gif"
						   alt="[Sponsor of Unix Guru Universe]"
						   height="64" width="76"
						   border="0"/></a></td>

	    <td><a href="http://www.daemonnews.org/"><img src="&enbase;/gifs/darbylogo.gif"
		alt="[Daemon News]" height="45" width="130"
		border="0"/></a></td>

	    <td><a href="&enbase;/copyright/daemon.html"><img
							     src="&enbase;/gifs/powerlogo.gif"
							     alt="[Powered by FreeBSD]"
							     height="64"
							     width="160"
							     border="0"/></a></td>
	  </tr>
	</table>

      <div id="FOOTER">
	&copyright;

	The mark FreeBSD is a registered trademark of The FreeBSD
	Foundation and is used by The FreeBSD Project with the
	permission of <a
	  href="http://www.freebsdfoundation.org/documents/Guidelines.shtml">The
	FreeBSD Foundation</a>.

      </div> <!-- FOOTER -->
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

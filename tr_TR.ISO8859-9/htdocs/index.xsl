<?xml version="1.0" encoding="iso-8859-9"?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "The FreeBSD Project">
]>
<!--
     The FreeBSD Turkish Documentation Project
     Original revision: 1.77
-->

<!-- $FreeBSD$ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

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
		  color="#990000"><b>Yak�n�n�zdaki
		  bir Yans�:</b></font>

		<br/>

		<select name="goto">
		  <!--  Only list TRUE mirrrors here! Native language pages
		        which are not mirrored should be listed in
		        support.sgml.  -->

		  <option value="http://www2.at.FreeBSD.org/">IPv6 Avusturya</option>
		  <option value="http://www.dk.FreeBSD.org/">IPv6 Danimarka</option>
		  <option value="http://www2.de.FreeBSD.org">IPv6 Almanya</option>
		  <option value="http://www.jp.FreeBSD.org/www.FreeBSD.org/">IPv6 Japonya</option>
		  <option value="http://www2.no.FreeBSD.org/">IPv6 Norve�</option>
		  <option value="http://www1.uk.FreeBSD.org/">IPv6 UK</option>
		  <option value="http://www4.us.FreeBSD.org/">IPv6 USA/1</option>
		  <option value="http://www5.us.FreeBSD.org/">IPv6 USA/2</option>
		  <option value="http://www.ar.FreeBSD.org/">Arjantin</option>
		  <option value="http://www.au.FreeBSD.org/">Avusturalya/1</option>
		  <option value="http://www2.au.FreeBSD.org/">Avusturalya/2</option>
		  <option value="http://www.at.FreeBSD.org/">Avusturya/1</option>
		  <option value="http://www2.at.FreeBSD.org/">Avusturya/2</option>
		  <option value="http://freebsd.unixtech.be/">Bel�ika</option>
		  <option value="http://www.br.FreeBSD.org/">Brezilya/1</option>
		  <option value="http://www2.br.FreeBSD.org/www.freebsd.org/">Brezilya/2</option>
		  <option value="http://www3.br.FreeBSD.org/">Brezilya/3</option>
		  <option value="http://www.bg.FreeBSD.org/">Bulgaristan</option>
		  <option value="http://www.ca.FreeBSD.org/">Kanada/1</option>
		  <option value="http://www2.ca.FreeBSD.org/">Kanada/2</option>
		  <option value="http://www.cn.FreeBSD.org/">�in</option>
		  <option value="http://www.cz.FreeBSD.org/">�ek Cumhur.</option>
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
		  <option value="http://www.is.FreeBSD.org/">�zlanda</option>
		  <option value="http://www.ie.FreeBSD.org/">�rlanda/1</option>
		  <option value="http://www2.ie.FreeBSD.org/">�rlanda/2</option>
		  <option value="http://www.it.FreeBSD.org/">�talya/1</option>
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
		  <option value="http://www.no.FreeBSD.org/">Norve�/1</option>
		  <option value="http://www2.no.FreeBSD.org/">Norve�/2</option>
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
		  <option value="http://www.es.FreeBSD.org/">�spanya/1</option>
		  <option value="http://www2.es.FreeBSD.org/">�spanya/2</option>
		  <option value="http://www3.es.FreeBSD.org/">�spanya/3</option>
		  <option value="http://www.za.FreeBSD.org/">G�ney Afrika/1</option>
		  <option value="http://www2.za.FreeBSD.org/">G�ney Afrika/2</option>
		  <option value="http://www.se.FreeBSD.org/">�sve�/1</option>
		  <option value="http://www2.se.FreeBSD.org/">�sve�/2</option>
		  <option value="http://www.ch.FreeBSD.org/">�svi�re/1</option>
		  <option value="http://www2.ch.FreeBSD.org/">�svi�re/2</option>
		  <option value="http://www.tw.FreeBSD.org/">Tayvan/1</option>
		  <option value="http://www2.tw.FreeBSD.org/">Tayvan/2</option>
		  <option value="http://www3.tw.FreeBSD.org/">Tayvan/3</option>
		  <option value="http://www4.tw.FreeBSD.org/">Tayvan/4</option>
		  <option value="http://www.tr.FreeBSD.org/">T�rkiye/1</option>
		  <option value="http://www2.tr.FreeBSD.org/">T�rkiye/2</option>
		  <option value="http://www.enderunix.org/freebsd/">T�rkiye/3</option>
		  <option value="http://www.ua.FreeBSD.org/">Ukrayna/1</option>
		  <option value="http://www2.ua.FreeBSD.org/">Ukrayna/2</option>
		  <option value="http://www5.ua.FreeBSD.org/">Ukrayna/3</option>
		  <option value="http://www4.ua.FreeBSD.org/">Ukrayna/Crimea</option>
		  <option value="http://www.uk.FreeBSD.org/">�ngiltere/1</option>
		  <option value="http://www2.uk.FreeBSD.org/">�ngiltere/2</option>
		  <option value="http://www3.uk.FreeBSD.org/">�ngiltere/3</option>
		  <option value="http://www4.uk.FreeBSD.org/">�ngiltere/4</option>
		  <option value="http://www1.uk.FreeBSD.org/">�ngiltere/5</option>
		  <option value="http://www2.us.FreeBSD.org/">ABD/1</option>
		  <option value="http://www4.us.FreeBSD.org/">ABD/2</option>
		  <option value="http://www5.us.FreeBSD.org/">ABD/3</option>
		</select>

		<input type="submit" value=" Go "/>

		<br/>

		<font color="#990000"><b>Dil: </b></font>
		<a href="&enbase;/it/index.html">�talyanca</a>,
		<a href="&enbase;/ja/index.html">Japonca</a>,
		<a href="&enbase;/ru/index.html">Rus�a</a>,
		<a href="&enbase;/es/index.html">�spanyolca</a>,
		<a href="&enbase;/support.html#web">Di�erleri</a>
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
			      &#183; <a href="&enbase;/news/newsflash.html">Anonslar</a><br/>
			      &#183; <a href="&enbase;/news/press.html">Bas�n</a><br/>
			      &#183; <a href="&enbase;/news/index.html">Di�erleri ...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Yaz�l�m</b></font>
			    <small><br/>
			      &#183; <a href="&enbase;/doc/en_US.ISO8859-1/books/handbook/mirrors.html">Nereden Bulabilirim?</a><br/>
			      &#183; <a href="&enbase;/releases/index.html">S�r�m Bilgileri</a><br/>
			      &#183; <a href="&enbase;/ports/index.html">Ports Uygulamalar�</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Dok�mantasyon</b></font>

			    <small><br/>
			      &#183; <a href="&enbase;/projects/newbies.html">Yeniler ��in</a><br/>
			      &#183; <a href="&enbase;/doc/en_US.ISO8859-1/books/handbook/index.html">El Kitab�</a><br/>
			      &#183; <a href="&enbase;/doc/en_US.ISO8859-1/books/faq/index.html">SSS</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/man.cgi">Klavuz Sayfalar�</a><br/>
			      &#183; <a href="&enbase;/docproj/index.html">Dok�mantasyon Proj.</a><br/>
			      &#183; <a href="docs.html">Di�erleri...</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Destek</b></font>

			    <small><br/>
			      &#183; <a href="&enbase;/support.html#mailing-list">Mail listeleri</a><br/>
			      &#183; <a href="&enbase;/support.html#newsgroups">Haber Gruplar�</a><br/>
			      &#183; <a href="&enbase;/support.html#user">Kullan�c� Gruplar�</a><br/>
			      &#183; <a href="&enbase;/support.html#web">Web Kaynaklar�</a><br/>
			      &#183; <a href="&enbase;/security/index.html">G�venlik</a><br/>
			      &#183; <a href="&enbase;/support.html">Di�erleri...</a>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Hata Bildirimi</b></font>
			    <small><br/>
			      &#183; <a href="&enbase;/send-pr.html">Hata Bildirimi G�nder</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr-summary.cgi">Hata Sorgulama</a><br/>
			      &#183; <a href="http://www.FreeBSD.org/cgi/query-pr.cgi">Hata ID'sine G�re Ara</a><br/>
			      &#183; <a href="&enbase;/support.html#gnats">Di�erleri...</a><br/>
			    </small></p>


			  <p><font size="+1" color="#990000"><b>Geli�tirim</b></font>

			    <small><br/>
			      &#183; <a href="&enbase;/projects/index.html">Projeler</a><br/>
			      &#183; <a href="&enbase;/releng/index.html">S�r�m M�hendisli�i</a><br/>
			      &#183; <a href="&enbase;/support.html#cvs">CVS Deposu</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Sat�n Alma</b></font>

			    <small><br/>
			      &#183; <a href="&enbase;/commercial/software_bycat.html">Yaz�l�m</a><br/>
			      &#183; <a href="&enbase;/commercial/hardware.html">Donan�m</a><br/>
			      &#183; <a href="&enbase;/commercial/consulting_bycat.html">Dan��manl�k</a><br/>
			      &#183; <a href="&enbase;/commercial/misc.html">Di�er</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Ba���lar</b></font>
			    <small><br/>
			      &#183; <a href="&enbase;/donations/index.html">Ba��s Kurumu</a><br/>
			      &#183; <a href="&enbase;/donations/donors.html">Yap�lan Ba���lar</a><br/>
			      &#183; <a href="&enbase;/donations/wantlist.html">�htiya� Listesi</a><br/>
			    </small></p>

			  <p><font size="+1" color="#990000"><b>Site i�i</b></font>

			    <small><br/>
			      &#183; <a href="&enbase;/search/index-site.html">Site Haritas�</a><br/>
			      &#183; <a href="&enbase;/search/search.html">Arama</a><br/>
			      &#183; <a href="&enbase;/internal/index.html">Di�er ...</a><br/>

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
		UltraSPARC&#174; mimarileri i�in ileri seviye bir
		i�letim sistemidir.  Berkeleydeki Kaliforniya
		�niversitesinde geli�tirilmi�
		&unix; t�revi olan BSD 'yi
		temel alm��t�r.  FreeBSD <a
		href="&enbase;/doc/en_US.ISO8859-1/articles/contributors/index.html">bir�ok
		ki�i </a> taraf�ndan geli�tirilmekte ve
		devam ettirilmektedir. Ayr�ca ba�ka <a
		href="&enbase;/platforms/index.html">mimariler</a>
		i�in geli�tirim de�i�ik
		a�amalardad�r.</p>

	      <h2><font color="#990000">En B�y�k
		�zellikleri</font></h2>

	      <p>FreeBSD ileri seviyede a�, performans,
		g�venlik ve uyumluluk <a
		href="&base;/features.html">�zellikleri</a>sunar.
		Bu �zellikler ticari olan baz� i�letim
		sistemlerinde bile bulunmamaktad�r.</p>

	      <h2><font color="#990000">G��l�
		�nternet ��z�mleri</font></h2>

	      <p>FreeBSD ideal bir <a
		href="&enbase;/internet.html">�nternet ya da
		�ntranet</a> sunucusu olabilir. A��r
		a� y�klerinde sa�lam a� hizmetleri
		verecek yap�dad�r ve ayn� anda
		�al��an binlerce i�leme cevap
		vermek i�in sistem haf�zas�n�
		verimli bir �eklilde kullan�r.  FreeBSD ile
		�al��an uygulama ve servisler
		i�in <a
		href="&enbase;/gallery/gallery.html">galeri</a>
		sayfam�z� ziyaret edebilirsiniz.</p>

	      <h2><font color="#990000">Binlerce Uygulamay�
		�al��t�rabilirsiniz</font></h2>

	      <p>FreeBSD kalitesi g�n�m�zde
		kullan�lan d���k maliyetli PC
		donan�mlar� ile birle�ince mevcut
		ticari &unix; masa�st�
		sistemlere �ok ekonomik bir alternatif
		olmaktad�r.  FreeBSD masa�st� ve sunucu
		<a
		href="&enbase;/applications.html">uygulamalar�</a>
		i�in haz�r durumdad�r.</p>

	      <h2><font color="#990000">Kolay Kurulum</font></h2>

	      <p>FreeBSD CD-ROM, DVD-ROM, flopi disk, manyetik teyp, ve
		MS-DOS&#174; disk b�l�m�nden ya da bir
		a� ba�lant�n�z mevcutsa <i>direk</i>
		anonim FTP ya da NFS ile kurulabilir. B�t�n
		ihtiyac�n�z bir �ift 1.44MB flopi ve
		<a
		href="&enbase;/doc/en_US.ISO8859-1/books/handbook/install.html">bu</a>
		dok�mand�r.</p>

	      <h2><font color="#990000">FreeBSD
		<i>�cretsizdir</i></font></h2>

	      <a href="&enbase;/copyright/daemon.html"><img
		src="&enbase;/gifs/dae_up3.gif" alt="" height="81"
		width="72" align="right" border="0"/></a>

	      <p>Bu �zelliklere sahip bir i�letim sisteminin
		y�ksek fiyatlar ile
		sat�laca��n�
		d���nebilirsiniz fakat FreeBSD <a
		href="&enbase;/copyright/index.html">�cretsiz</a>
		bir i�letim sistemidir ve b�t�n kaynak
		kodu ile beraber gelir. E�er denemek isterseniz <a
		href="&enbase;/doc/en_US.ISO8859-1/books/handbook/mirrors.html">daha
		fazla bilgi </a> mevcuttur.</p>

	      <h2><font color="#990000">FreeBSD 'ye Katk�da
		Bulunmak</font></h2>

	      <p>FreeBSD i�letim sistemine katk�da bulunmak son derece
		basittir. �htiyac�n�z olan tek �ey FreeBSD i�letim
		sisteminde geli�tirilmesini d���nd�g�n�z k�s�mlar� bulup
		bu de�i�iklikleri(dikkatli ve �zenli bir �ekilde) yap�p,
		yapt���n�z de�i�iklikleri FreeBSD Projesine send-pr
		sistemi ile ya da tan�yorsan�z bir FreeBSD geli�tiricisine
		g�ndermek olacakt�r.  Yapaca��n�z de�i�iklik
		dok�mantasyon, sanatsal i�ler ya da kaynak kodu gibi
		�eyler olabilir.  Ayr�nt�l� bilgi i�in <a
		href="&enbase;/doc/en_US.ISO8859-1/articles/contributing/index.html">FreeBSD'ye
		Katk�da Bulunmak</a> makalesine ba�vurabilirsiniz.</p>

		<p>Program yazan biri olmasan�z bile FreeBSD
		  Projesine katk�da bulunmak i�in
		  ba�ka yollar mevcuttur.  The FreeBSD
		  Foundation(FreeBSD Kurumu) kar amac�
		  g�tmeyen bir organizasyon olup yap�lan
		  katk�lar vergiden d��ebilir
		  durumdad�r.  Daha fazla bilgi i�in <a
		  href="mailto:bod@FreeBSDFoundation.org">bod@FreeBSDFoundation.org</a>
		  ile irtibata ge�ebilir ya da direk posta ile
		  �u adresi kullanabilirsiniz : The FreeBSD
		  Foundation, 7321 Brockway Dr.  Boulder, CO 80303.  USA</p>

		<p>Silicon Breeze firmas�
		  yapt��� BSD Daemon heykellerinden
		  gelen kazan�lar�n 15% 'ini FreeBSD
		  Foundation'a vermektedir.  Daha fazla bilgiye <a
		  href="http://www.linuxjewellery.com/beastie/">bu</a>
		  sayfadan ula�abilirsiniz.</p>
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
			<td valign="top"><p><font size="+1" color="#990000"><b>Yeni Teknololi S�r�m�:
			    &rel.current;</b></font><br/>

			    <small>&#183; <a href="&u.rel.announce;">Duyuru</a><br/>
			      &#183; <a href="&enbase;/doc/en_US.ISO8859-1/books/handbook/install.html">Kurulum Klavuzu</a><br/>
			      &#183; <a href="&u.rel.notes;">S�r�m Bilgileri</a><br/>
			      &#183; <a href="&u.rel.hardware;">Desteklenen Donan�mlar</a><br/>
			      &#183; <a href="&u.rel.errata;">D�zeltilen Hatalar</a><br/>
			      &#183; <a href="&u.rel.early;">Erken Adaptasyon Klavuzu</a></small></p>

			  <p><font size="+1" color="#990000"><b>Kararl� S�r�m:
				&rel2.current;</b></font><br/>

			    <small>&#183; <a href="&u.rel2.announce;">Duyuru</a><br/>
			      &#183; <a href="&enbase;/doc/en_US.ISO8859-1/books/handbook/install.html">Kurulum Klavuzu</a><br/>
			      &#183; <a href="&u.rel2.notes;">S�r�m Bilgileri</a><br/>
			      &#183; <a href="&u.rel2.hardware;">Desteklenen Donan�mlar</a><br/>
			      &#183; <a href="&u.rel2.errata;">D�zeltilen Hatalar</a></small></p>

			  <p><font size="+1" color="#990000"><b>Proje Haberleri</b></font></p>

			  <xsl:call-template name="html-index-news-project-items">
			    <xsl:with-param name="news.project.xml-master" select="$news.project.xml-master" />
			    <xsl:with-param name="news.project.xml" select="$news.project.xml" />
			  </xsl:call-template>

			  <p><a href="&enbase;/news/newsflash.html">�ncekiler ...</a></p>

			  <p><font size="+1" color="#990000"><b>Bas�nda FreeBSD</b></font></p>

			  <xsl:call-template name="html-index-news-press-items">
			    <xsl:with-param name="news.press.xml-master" select="$news.press.xml-master" />
			    <xsl:with-param name="news.press.xml" select="$news.press.xml" />
			  </xsl:call-template>

			  <p><a href="&enbase;/en/news/press.html">�ncekiler ...</a></p>

			  <p><font size="+1" color="#990000"><b>G�venlik Tavsiyeleri</b></font></p>

			  <xsl:call-template name="html-index-advisories-items">
			    <xsl:with-param name="advisories.xml" select="$advisories.xml" />
			    <xsl:with-param name="type" select="'advisory'" />
			  </xsl:call-template>

			  <p><a href="&enbase;/security/index.html">�ncekiler ...</a></p>
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
		      hakk�nda daha fazla bilgi almak i�in
		      FreeBSD ile alakali <a
		      href="&enbase;/publish.html">yay�nlar</a> ya
		      da <a
		      href="&enbase;/news/press.html">Bas�nda
		      FreeBSD</a>, sayfalar�n� ziyaret
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

<!--
     Local Variables:
     mode: xml
     sgml-indent-data: t
     sgml-omittag: nil
     sgml-always-quote-attributes: t
     End:
-->

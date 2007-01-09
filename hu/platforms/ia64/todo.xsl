<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY enbase "../../..">
<!ENTITY email "freebsd-ia64">
<!ENTITY title "FreeBSD/ia64 Projekt">
<!ENTITY % navinclude.developers "INCLUDE">
]>

<!-- FreeBSD Hungarian Documentation Project
     Translated by: Gabor Kovesdan <gabor@FreeBSD.org>
     Original Revision: r1.9				-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD: www/hu/platforms/ia64/todo.xsl,v 1.1 2007/01/07 22:44:47 keramida Exp $'"/>

  <xsl:output doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    encoding="iso-8859-2" method="html"/>

  <xsl:template match="/">
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

		<img align="right" alt="Montecito die" src="$enbase;/platforms/ia64/montecito-die.png"/>

		<p>A FreeBSD/ia64 PR adatb&aacute;zis keres&eacute;se:</p>

	<form action="http://www.FreeBSD.org/cgi/query-pr-summary.cgi"
	      method="get">
	    <input type="hidden" name="category" value="ia64"/>
	    <input type="hidden" name="sort" value="none"/>
	    <input type="text" name="text"/>
	    <input type="submit" value="Go"/>
		</form>

	<h3>
	  Ami m c&eacute;g h&aacute;ra van
	</h3>
	<p>
	  Ennek az oldalnak a c&eacute;lja, hogy kiindul&oacute;pont legyen
	  azok sz&aacute;m&aacute;ra, akik valamit tenni szeretn&eacute;nek.
	  Ez itt felsoroltaknem sz&uuml;ks&eacute;gszer&#251;en
	  fontoss&aacute;gi sorrendben vannak, de a sorrend egy j&oacute;
	  ir&aacute;nyad&oacute;.  Minden bizonnyal vannak olyan feladatok,
	  amelyek nem szerepelnek a list&aacute;ban.   Erre egy tipikus
	  p&eacute;lda az ia64 weboldalak karbantart&aacute;sa
	  ... sajnos.
	</p>

	<h4>
	  Tier 1 platformm&acute; v&aacute;l&aacute;s
	</h4>
	<p>
	  K&eacute; Tier 2 kiad&aacute;s ut&aacute;n imm&aacute;r itt az ideje,
	  hogy az ia64 Tier 1 platformm&aacute; v&aacute;ljon.  Ez a
	  k&ouml;vetkez&#245;ket ig&eacute;nyli:
	</p>
	<ul>
	  <li>
	    A telep&iacute;t&#245; rendszer fejleszt&eacute;se, hogy
	    sz&aacute;m&iacute;t&aacute;sba vegye, hogy GPT is l&eacute;tezik
	    egy EFI part&iacute;ci&oacute;val, bele&eacute;rtve m&aacute;s
	    oper&aacute;ci&oacute;s rendszereket is.  A lehet&#245;s&eacute;g,
	    hogy a FreeBSD-t hozz&aacute;adjuk az EFI boot
	    men&uuml;j&eacute;hez, szint&eacute;n egy remek
	    lehet&#245;s&eacute;g lenne.
	  </li>
	  <li>
	    A GNU debugger portol&aacute;sa.  Ez az alkalmaz&aacute;s nehezen
	    p&oacute;tolhat&oacute; &eacute;s sz&uuml;ks&eacute;ges minden
	    Tier 1 platformon.
	  </li>
	  <li>
	    Az X szerver (ports/x11/XFree86-4-Server) portol&aacute;sa.
	    Nem felt&eacute;tlen sz&uuml;ks&eacute;ges a Tier 1
	    st&aacute;tuszhoz, de ha valaki ia64 rendszert szeretne
	    haszn&aacute;lni asztali
	    sz&aacute;m&iacute;t&oacute;g&eacute;pk&eacute;nt, nem megy sokra
	    n&eacute;lk&uuml;le.
	  </li>
	</ul>

	<h4>
	  Portok &eacute;s csomagok
	</h4>
	<p>
	  Nagyon fontos feladat a FreeBSD ia64 portj&aacute;nak
	  sikeress&eacute; t&eacute;tel&eacute;ben, hogy a
	  felhaszn&aacute;l&oacute; az ls(1)-en k&iacute;v&uuml; az&eacute;rt
	  valami m&aacute;st is futtathasson.  A hatalmas m&eacute;ret&#251;
	  Ports Colletion els&#245;sorban az ia32 platformot c&eacute;lozza
	  meg, &iacute;gy nem meglep&#245; hogy rengeteg port nem fordul le,
	  vagy nem fut ia64 platformon.
	  <a href="http://pointyhat.FreeBSD.org/errorlogs/ia64-6-latest/">
	    Itt</a> megtekintheti a leg&uacute;jabb portok
	  list&aacute;j&aacute;t, amelyek valamilyen okn&aacute;l fogva nem
	  fordulnak le ia64-en.  Vegye figyelembe, hogy ha egy portnak olyan
	  f&uuml;gg&#245;s&eacute;ge van, amelyik nem fordul le, akkor azt meg
	  sem k&iacute;s&eacute;relj&uuml;k leford&iacute;tani, &iacute;gy nem
	  szerepel a list&aacute;ban.  Egy j&oacute; m&oacute;d a
	  seg&iacute;ts&eacute;gre azoknak a portoknak a
	  jav&iacute;t&aacute;sa, amelyek sok m&aacute;sik portnak a
	  f&uuml;gg&#245;s&eacute;ge. (Tekintse meg az "Aff." oszlopot a
	  t&aacute;bl&aacute;zatban.)
	</p>

	<h4>
	  A f&#251;r&eacute;sz ki&eacute;lez&acute;se
	</h4>
	<p>
	  Vannak olyan funkci&oacute;k (k&uuml;l&ouml;n&ouml;sen az assembly
	  rutinok), amelyek az&eacute;rt k&eacute;sz&uuml;ltek, hogy
	  p&oacute;tolj&aacute;k a hi&aacute;nz&oacute; funkcionalit&aacute;st,
	  de a sebess&eacute;get &eacute;s megb&iacute;zhet&oacute;s&aacute;got
	  nem vett&eacute;k figyelembe.  Ezeknek a funkci&oacute;knak az
	  &aacute;tn&eacute;z&eacute;se &eacute;s cser&eacute;je egy remek
	  feladat, amely egyidej&#251;leg &eacute;s &ouml;n&aacute;ll&oacute;an
	  v&eacute;gezhet&#245;, emelettt nem felt&eacute;tlen ig&eacute;nyel
	  nagy tud&aacute;st &eacute;s tapasztalatot.
	</p>

	<h4>
	  A mag fejleszt&eacute;se
	</h4>
	<p>
	  A nem m&#251;k&ouml;d&#245;, vagy nem l&eacute;tez&#245;
	  funkcionalit&aacute;sok mellett n&eacute;h&aacute;ny alapvet&#251;
	  dolog &uacute;jra&iacute;r&aacute;sa is akad, amelyek
	  potenci&aacute;lisan &eacute;rinthetik a t&ouml;bbi platformot is.
	  Ezek:
	</p>
	<ul>
	  <li>
	    Az UP &eacute;s SMP stabilit&aacute;s fejleszt&eacute;se a PMAP
	    modul &aacute;talak&iacute;t&aacute;s&aacute;sal.  Az
	    alacsonyszint&#251; VM ford&iacute;t&aacute;sok fejleszt&eacute;st
	    ig&eacute;nyelnek, mind a pontoss&acute;g, mind a
	    teljes&iacute;tm&eacute;ny tekintet&eacute;ben.
	  </li>
	  <li>
	    Alapvet&#245; eszk&ouml;zmeghajt&oacute;k, mint pl. a sio(4)
	    vagy syscons(4), nem m&#251;k&ouml;dnek olyan ia64 rendszereken,
	    amelyik nem t&aacute;mogat r&eacute;gi eszk&ouml;z&ouml;ket.
	    Ez egy nagy probl&eacute;ma, mert minden platformot &eacute;rint
	    &eacute;s sz&uuml;ks&eacute;ges lehet n&eacute;h&aacute;ny
	    alrendszer (nagy) r&eacute;szeinek &uacute;jra&iacute;r&aacute;sa.
	    Mindenk&eacute;ppen egy olyan munka, amely nagyfok&uacute;
	    t&aacute;mogat&aacute;st &eacute;s koordin&aacute;ci&oacute;t
	    ig&eacute;nyel.
	  </li>
	  <li>
	    Az elsz&oacute;rt (fizikai) memoacute;ria hat&eacute;konyabb
	    kezel&eacute;se az eg&eacute;sz n&eacute;vter&uuml;letet
	    &aacute;t&ouml;lel&#245; VM t&aacute;bl&aacute;k helyett
	    kisebb ter&uuml;letek &aacute;fed&eacute;s&eacute;vel.
	    Emiatt jelenleg r&aacute; vagyunk k&eacute;nyszer&iacute;tve,
	    hogy figyelmen k&iacute;v&uuml;l hagyjunk
	    mem&oacute;riar&eacute;szeket.
	  </li>
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

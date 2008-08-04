<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY base "../..">
<!ENTITY enbase "../../..">
<!ENTITY email "freebsd-ia64">
<!ENTITY title "A &os;/ia64 projekt &mdash; Tov&aacute;bbi
  teend&#245;k">
<!ENTITY % navinclude.developers "INCLUDE">
]>

<!-- FreeBSD Hungarian Documentation Project
     Translated by: Gabor Kovesdan <gabor@FreeBSD.org>
     %SOURCE%	en/platforms/ia64/todo.xsl
     %SRCID%	1.9
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date" select="'$FreeBSD: www/hu/platforms/ia64/todo.xsl,v 1.3 2008/06/25 11:31:18 gabor Exp $'"/>

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

		<p>A &os;/ia64 porttal kapcsolatos hibajelent&eacute;sek
		  keres&eacute;se:</p>

	<form action="http://www.FreeBSD.org/cgi/query-pr-summary.cgi"
	      method="get">
	    <input type="hidden" name="category" value="ia64"/>
	    <input type="hidden" name="sort" value="none"/>
	    <input type="text" name="text"/>
	    <input type="submit" value="Go"/>
		</form>

	<h3>Tov&aacute;bbi teend&#245;k</h3>

	<p>Ennek az oldalnak az a c&eacute;lja, hogy kiindul&oacute;pont
	  legyen azok sz&aacute;m&aacute;ra, akik valamit tenni
	  szeretn&eacute;nek a projekt &eacute;rdek&eacute;ben.  Ez itt
	  felsoroltak nem sz&uuml;ks&eacute;gszer&#251;en
	  fontoss&aacute;gi sorrendben szerepelnek, noha ez a sorrend
	  ir&aacute;nyad&oacute; lehet.  Minden bizonnyal vannak olyan
	  feladatok, amelyek nem szerepelnek a list&aacute;ban.  Erre
	  egy tipikus p&eacute;lda az ia64 porttal kapcsolatos honlapok
	  karbantart&aacute;sa...  sajnos.</p>

	<h4>Tier 1 platformm&acute; v&aacute;l&aacute;s</h4>

	<p>K&eacute;t Tier 2 kiad&aacute;s ut&aacute;n imm&aacute;r itt
	  az ideje, hogy az ia64 Tier 1 platformm&aacute; v&aacute;ljon.
	  Ehhez a k&ouml;vetkez&#245;kre lesz m&eacute;g
	  sz&uuml;ks&eacute;g:</p>

	<ul>
	  <li>A telep&iacute;t&#245;rendszer
	    tov&aacute;bbfejleszt&eacute;se, hogy
	    sz&aacute;m&iacute;t&aacute;sba vegye, hogy l&eacute;tezhet
	    GPT is EFI part&iacute;ci&oacute;val, bele&eacute;rtve
	    m&aacute;s oper&aacute;ci&oacute;s rendszereket is.
	    Szint&eacute;n egy remek lehet&#245;s&eacute;g lenne, ha a
	    &os;-t hozz&aacute; tudn&aacute;nk adni az EFI
	    rendszerind&iacute;t&#245; men&uuml;j&eacute;hez.</li>

	  <li>A GNU debugger portol&aacute;sa.  Ez az alkalmaz&aacute;s
	    nehezen p&oacute;tolhat&oacute; &eacute;s
	    sz&uuml;ks&eacute;ges minden Tier 1 platformon.</li>

	  <li>Az X szerver (ports/x11/XFree86-4-Server)
	    portol&aacute;sa.  Nem felt&eacute;tlen sz&uuml;ks&eacute;ges
	    a Tier 1 st&aacute;tuszhoz, de ha valaki ia64 rendszert
	    szeretne haszn&aacute;lni asztali
	    sz&aacute;m&iacute;t&oacute;g&eacute;peken,
	    en&eacute;lk&uuml;l nem sokra megy.</li>
	</ul>

	<h4>Portok &eacute;s csomagok</h4>

	<p>Nagyon fontos feladat a &os; ia64 portj&aacute;nak
	  sikeress&eacute; t&eacute;tel&eacute;ben, hogy a
	  felhaszn&aacute;l&oacute; az ls(1)-en k&iacute;v&uuml;l
	  az&eacute;rt valami m&aacute;st is tudjon haszn&aacute;lni.  A
	  hatalmas m&eacute;ret&#251; Portgy&#251;jtem&eacute;ny
	  els&#245;sorban az ia32 platformot c&eacute;lozza meg,
	  &iacute;gy tal&aacute;n nem annyira meglep&#245;, hogy
	  rengeteg port nem fordul le, vagy egy&aacute;ltal&aacute;n nem
	  is fut ia64 platformon.  <a
	    href="http://pointyhat.FreeBSD.org/errorlogs/ia64-6-latest/">Itt</a>
	  l&aacute;thatjuk azon leg&uacute;jabb portok
	  list&aacute;j&aacute;t, amelyek valamilyen okn&aacute;l fogva
	  nem fordulnak ia64-en.  Ha egy portnak olyan
	  f&uuml;gg&#245;s&eacute;ge van, amelyik nem fordul le, akkor
	  azt meg sem k&iacute;s&eacute;relj&uuml;k leford&iacute;tani,
	  &iacute;gy teh&aacute;t az nem szerepel a list&aacute;ban.
	  Nagyon sokat tudn&aacute;nk azzal seg&iacute;teni, ha
	  megjav&iacute;tan&aacute;nk azokat a portokat, amelyekt&#245;l
	  sok m&aacute;sik port f&uuml;gg.  (N&eacute;zz&uuml;k meg a
	  t&aacute;bl&aacute;zat "Aff." oszlop&aacute;t.)</p>

	<h4>A forr&aacute;sk&oacute;d csiszol&aacute;sa</h4>

	<p>Vannak olyan funkci&oacute;k (k&uuml;l&ouml;n&ouml;sen az
	  assembly rutinok), amelyek az&eacute;rt k&eacute;sz&uuml;ltek,
	  hogy p&oacute;toljanak bizonyos hi&aacute;nyz&oacute;
	  funkci&oacute;kat, de a sebess&eacute;get &eacute;s
	  megb&iacute;zhet&oacute;s&aacute;got nem vett&eacute;k
	  figyelembe.  Ezeknek a funkci&oacute;knak az
	  &aacute;tn&eacute;z&eacute;se &eacute;s cser&eacute;je egy
	  remek feladat, amely p&aacute;rhuzamosan &eacute;s
	  &ouml;n&aacute;ll&oacute;an v&eacute;gezhet&#245;, emellett
	  nem felt&eacute;tlen&uuml;l ig&eacute;nyel nagy tud&aacute;st
	  &eacute;s tapasztalatot.</p>

	<h4>A mag fejleszt&eacute;se</h4>

	<p>A nem m&#251;k&ouml;d&#245;, vagy nem l&eacute;tez&#245;
	  funkci&oacute;k mellett akad n&eacute;h&aacute;ny olyan
	  alapvet&#245; dolog is, amelyeket &uacute;jra kellene
	  &iacute;rni, &eacute;s ezek ak&aacute;r a t&ouml;bbi
	  platformot is &eacute;rinthetik.  T&ouml;bbek k&ouml;zt az
	  al&aacute;bbiak:</p>

	<ul>
	  <li>Az egy- &eacute;s t&ouml;bbprocesszoros stabilit&aacute;s
	    fejleszt&eacute;se a PMAP modul
	    &aacute;talak&iacute;t&aacute;s&aacute;val.  Az
	    alacsonyszint&#251; VM lek&eacute;pez&eacute;sek
	    fejleszt&eacute;st ig&eacute;nyelnek, mind a
	    pontoss&aacute;g, mind pedig a teljes&iacute;tm&eacute;ny
	    tekintet&eacute;ben.</li>

	  <li>Az alapvet&#245; eszk&ouml;zmeghajt&oacute;k, mint
	    p&eacute;ld&aacute;ul a sio(4) vagy syscons(4), nem
	    m&#251;k&ouml;dnek olyan ia64 rendszereken, amelyek nem
	    t&aacute;mogatj&aacute;k a r&eacute;gebbi
	    eszk&ouml;z&ouml;ket.  Ez egy komoly probl&eacute;ma, amely
	    minden platformot &eacute;rint, &eacute;s ehhez
	    n&eacute;h&aacute;ny egy&eacute;b alrendszer (nagyobb)
	    r&eacute;sz&eacute;nek &uacute;jra&iacute;r&aacute;sa is
	    sz&uuml;ks&eacute;ges lehet.  Ez mindenk&eacute;ppen egy
	    olyan munka, amely nagyfok&uacute; t&aacute;mogat&aacute;st
	    &eacute;s koordin&aacute;ci&oacute;t ig&eacute;nyel.</li>

	  <li>Az elsz&oacute;rt (fizikai) mem&oacute;riater&uuml;letek
	    hat&eacute;konyabb kezel&eacute;se az eg&eacute;sz
	    n&eacute;vt&eacute;ret &aacute;t&ouml;lel&#245; VM
	    t&aacute;bl&aacute;k helyett kisebb ter&uuml;letek
	    &aacute;tfed&eacute;s&eacute;vel.  Emiatt jelenleg r&aacute;
	    vagyunk k&eacute;nyszer&iacute;tve, hogy figyelmen
	    k&iacute;v&uuml;l hagyjunk bizonyos
	    mem&oacute;riar&eacute;szeket.</li>
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

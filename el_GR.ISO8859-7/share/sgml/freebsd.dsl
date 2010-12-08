<!--

  DSSSL style-sheet για μορφοποίηση της Ελληνικής τεκμηρίωσης του FreeBSD

  $FreeBSD$

  %SOURCE%	en_US.ISO8859-1/share/sgml/freebsd.dsl
  %SRCID%	1.22

-->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>

<!ENTITY % freebsd.l10n PUBLIC "-//FreeBSD//ENTITIES DocBook Language Specific Entities//EN">
%freebsd.l10n;

<!ENTITY % output.html  "IGNORE"> 
<!ENTITY % output.print "IGNORE">
<!ENTITY % lang.el.dsssl "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
      <!-- HTML only .................................................... -->

      <![ %output.html; [

	(define ($email-footer$)
          (make sequence
	    (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "Αυτό το κείμενο, και άλλα κείμενα, μπορεί να βρεθεί στο ")
		(create-link
		  (list (list "HREF" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                  (literal "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal ".")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"  
                (literal "Για ερωτήσεις σχετικά με το FreeBSD, διαβάστε την ")
		(create-link
		  (list (list "HREF" "http://www.FreeBSD.org/docs.html"))
                  (literal "τεκμηρίωση"))
                (literal " πριν να επικοινωνήσετε με την <")
		(create-link
		  (list (list "HREF" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal ">.")
                (make empty-element gi: "br")
                (literal "Για ερωτήσεις σχετικά με αυτή την τεκμηρίωση, στείλτε e-mail στην <")
		(create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
	        (literal ">.")))))

        (element quote
          (make sequence
            (make entity-ref name: "laquo")
            (process-children)
            (make entity-ref name: "raquo")))
      ]]>

      (define (local-el-label-title-sep)
        (list
          (list (normalize "warning")		": ")
	  (list (normalize "caution")		": ")
          (list (normalize "chapter")           "  ")
          (list (normalize "sect1")             "  ")
          (list (normalize "sect2")             "  ")
          (list (normalize "sect3")             "  ")
          (list (normalize "sect4")             "  ")
          (list (normalize "sect5")             "  ")
          ))

    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>

<!--
Local variables:
coding: iso-8859-7
mode: dsssl
fill-column: 78
End:
-->

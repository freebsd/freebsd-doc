<!--
     The FreeBSD Documentation Project
     The FreeBSD Brazilian Portuguese Documentation Project

     Original revision: 1.14
     $FreeBSD$
-->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>

<!ENTITY % output.html  "IGNORE"> 
<!ENTITY % output.print "IGNORE">
<!ENTITY % lang.ptbr.dsssl "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>

      <!-- Brazilian Portuguese Localization-->

      (define %default-language% "pt_br")

      <![ %lang.ptbr.dsssl; [
        (define %gentext-language% "pt_br")
      ]]>

      <![ %output.html; [ 

	(define ($email-footer$)
          (make sequence
	    (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "Este, e outros documentos, podem ser obtidos em ")
		(create-link
		  (list (list "HREF" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                  (literal "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal ".")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"  
                (literal "Para perguntas sobre FreeBSD, leia a ")
		(create-link
		  (list (list "HREF" "http://www.FreeBSD.org/docs.html"))
                  (literal "documenta\U-00E7;\U-00E3;o"))
                (literal " antes de contatar <")
		(create-link
		  (list (list "HREF" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal ">.")
                (make empty-element gi: "br")
                (literal "Para perguntas sobre esta documenta\U-00E7;\U-00E3;o, envie e-mail para <")
		(create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
	        (literal ">.")))))
     ]]>
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>

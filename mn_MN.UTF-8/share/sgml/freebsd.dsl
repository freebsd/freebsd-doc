<!-- 
    The FreeBSD Mongolian Documentation Project

    Original revision 1.22

    $FreeBSD$
-->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
<!ENTITY % lang.mn.dsssl "IGNORE">

<!ENTITY % freebsd.l10n PUBLIC "-//FreeBSD//ENTITIES DocBook Language Specific Entities//EN">
%freebsd.l10n;

<!ENTITY % output.html  "IGNORE"> 
<!ENTITY % output.print "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
      <![ %output.html; [ 

      <![ %lang.mn.dsssl; [
        (define %gentext-language% "mn")
      ]]>
	(define ($email-footer$)
          (make sequence
	    (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "Энэ болон бусад баримтуудыг ")
		(create-link
		  (list (list "HREF" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                  (literal "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal " хаягаас татаж авч болно.")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"  
                (literal "FreeBSD-ийн талаар <")
		(create-link
		  (list (list "HREF" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal "> хаягтай холбоо барихаасаа өмнө ")
		(create-link
		  (list (list "HREF" "http://www.FreeBSD.org/docs.html"))
                  (literal "баримтыг"))
                (literal " уншина уу.")
                (make empty-element gi: "br")
                (literal "Энэ бичиг баримттай холбоотой асуулт байвал <")
		(create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
	        (literal "> хаягаар цахим захидал явуулна уу.")
                (make empty-element gi: "br")
                (literal "Энэ  бичиг баримтын орчуулгатай холбоотой асуулт байвал <")
		(create-link (list (list "HREF" "mailto:admin@mnbsd.org"))
                  (literal "admin@mnbsd.org"))
	        (literal "> хаягаар цахим захидал явуулна уу.")))))
      ]]>

        (define (local-mn-label-title-sep)
        (list
          (list (normalize "warning")		": ")
	  (list (normalize "caution")		": ")
        ))

    </style-specification-body>
  </style-specification>
    
  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>

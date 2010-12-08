<!-- $FreeBSD$ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>

<!ENTITY % output.html  "IGNORE"> 
<!ENTITY % output.print "IGNORE">
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
                (literal "Dette og andre dokumenter kan downloades fra ")
		(create-link
		  (list (list "HREF" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                  (literal "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal ".")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"  
                (literal "For spørgsmål om FreeBSD, læs ")
		(create-link
		  (list (list "HREF" "http://www.FreeBSD.org/docs.html"))
                  (literal "dokumentationen"))
                (literal " før du kontakter <")
		(create-link
		  (list (list "HREF" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal ">.")
                (make empty-element gi: "br")
                (literal "For spørgsmål angående denne dokumentation, e-mail <")
		(create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
	        (literal ">.")))))
      ]]>
	<!-- Fix a problem with the Danish localisation. -->
	(define (local-da-label-title-sep)
	(list
	  (list (normalize "warning")           ": ")
	))

    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>

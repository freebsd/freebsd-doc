<!-- $FreeBSD: doc/es_ES.ISO_8859-1/share/sgml/freebsd.dsl,v 1.1 2000/03/23 09:00:07 nik Exp $ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
 
      <![ %output.html; [ 
	(define ($email-footer$)
          (make sequence
            (literal "For questions about FreeBSD, e-mail <")
            (make element gi: "a"
                  attributes: (list (list "href" "mailto:questions@FreeBSD.org"))
              (literal "questions@FreeBSD.org"))
            (literal ">.")
            (make empty-element gi: "br")
            (literal "For questions about this documentation, e-mail <")
              (make element gi: "a"
                    attributes: (list (list "href" "mailto:doc@FreeBSD.org"))
                (literal "doc@FreeBSD.org"))
	      (literal ">."))) 
      ]]>
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
